class IndexController < ApplicationController

  def index
  end

  def publish
    Gundog::Publisher.publish(params["publish"].to_json,
                              to_queue: "test_queue")
    render :index
  end

  def flood
    12.times do
      string = (0...8).map { (65 + rand(26)).chr }.join
      Gundog::Publisher.publish(string.to_json, to_queue: "test_queue")
    end
    render :index
  end
end
