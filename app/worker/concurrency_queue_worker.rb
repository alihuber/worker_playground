class ConcurrencyQueueWorker < Gundog::ApplicationWorker


  def call
    puts "#{Time.zone.now.to_s}  processing #{json} with object #{self.object_id}"
    dataset_id  = json[0]
    new_address = json[1]
    dataset = Dataset.where(id: dataset_id).first
    dataset.update(address: new_address) if dataset
  end

end
