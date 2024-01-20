require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  it "exists" do
    ResourceCategory.new
  end

  it "has a name" do
    expect(ResourceCategory.new).to respond_to(:name)
  end

end
