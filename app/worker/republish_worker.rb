class RepublishWorker < Gundog::ApplicationWorker

  def call
    puts "#{Time.zone.now.to_s} processing #{json} with "\
      "object #{self.object_id}"
    dataset_id  = json.to_i
    dataset     = Dataset.where(id: dataset_id).first
    new_address = IncreaseAddressService.new.call(dataset.address)
    Gundog::Publisher.new.publish([dataset.id, new_address].to_json,
                                  to_queue: "concurrency_queue_worker_queue")
  end

end
