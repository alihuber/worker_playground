require "spec_helper"

describe "republish with altered data to update" do

  context "datasets are present" do
    (1..10).each do |i|
      let!("dataset_#{i}".to_sym) { Dataset.create(address: "Address_#{i}") }
    end

    it "updates all records correctly" do
      dataset_ids = Dataset.pluck(:id)

      dataset_ids.each do |id|
        Gundog::Publisher.new
          .publish(id.to_json, to_queue: "republish_worker_queue")
      end

      # wait for worker
      sleep(3)

      datasets = Dataset.last(10)
      datasets.each_with_index do |dataset, index|
        expect(dataset.reload.address).to eq "Address_#{index+2}"
      end
    end
  end
end
