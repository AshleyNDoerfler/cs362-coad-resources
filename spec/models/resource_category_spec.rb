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

  it "is active by default" do
    expect(ResourceCategory.new.active).to eq(true)
  end

  describe "associations" do
    it { should have_and_belong_to_many(:organizations) }
    it { should have_many(:tickets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  it "to_s returns the name" do
    name = 'Peepee Poopoo'
    resource_category = ResourceCategory.new(name: name)
    result = resource_category.to_s
    expect(result).to eq(name)
  end

end
