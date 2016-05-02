class TestQueueWorker < Gundog::ApplicationWorker

  def call
    puts "processing #{json} with object #{self.object_id}"
  end
end
