require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  it "exists" do
    ResourceCategory.new
  end

  it "has a name" do
    expect(ResourceCategory.new).to respond_to(:name)
  end

  it "has an active flag" do
    expect(ResourceCategory.new).to respond_to(:active)
  end

end
