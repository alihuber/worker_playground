class TestQueueWorker < Gundog::ApplicationWorker

  def call
    if json == "bar"
      puts "#{Time.zone.now.to_s}  processing #{json} with "\
        "object #{self.object_id}"
      return
    end
    i = json.to_i
    if i == 2
      raise RuntimeError, "Error!"
    else
      puts "#{Time.zone.now.to_s}  processing #{json} with "\
        "object #{self.object_id}"
      Gundog::Publisher.new.publish("bar".to_json, to_queue: "test_queue")
    end
  end

end
