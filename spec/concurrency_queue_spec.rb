require "spec_helper"

describe "concurrency queue actions" do
  context "no datasets are present" do
    it "does nothing" do
      expect {
        Gundog::Publisher.new.publish([1, "foo"].to_json,
                                      to_queue: "concurrency_queue")
        sleep(2)
      }.not_to change { Dataset.count }
    end
  end


  context "datasets are present" do
    (1..10).each do |i|
      let!("dataset_#{i}".to_sym) { Dataset.create }
    end

    it "updates all records correctly" do
      (1..10).each do |i|
        Gundog::Publisher.new.publish([i, "Address_#{i}"].to_json,
                                      to_queue: "concurrency_queue")
      end

      # wait for worker
      sleep(3)

      (1..10).each do |i|
        dataset = Dataset.find(i)
        expect(dataset.address).to eq "Address_#{i}"
      end
    end
  end

  context "several threads want to update same dataset" do
    let!(:dataset_1) { Dataset.create(address: "old_address") }

    it "will not raise an error, last message will win" do
      id = dataset_1.id
      Gundog::Publisher.new.publish([id, "new_address_1"].to_json,
                                    to_queue: "concurrency_queue")
      Gundog::Publisher.new.publish([id, "new_address_2"].to_json,
                                    to_queue: "concurrency_queue")
      Gundog::Publisher.new.publish([id, "new_address_3"].to_json,
                                    to_queue: "concurrency_queue")
      # wait for worker
      sleep(3)

      expect(dataset_1.reload.address).to eq "new_address_3"
    end
  end
end
