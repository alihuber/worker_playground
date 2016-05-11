require "rails_helper"

RSpec.describe Dataset, type: :model do

  let(:dataset) { Dataset.new }

  it "has an address field" do
    expect(dataset).to respond_to(:address)
  end
end
