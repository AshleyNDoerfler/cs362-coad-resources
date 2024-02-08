require 'rails_helper'

RSpec.describe Region, type: :model do

  it "exists" do
    Region.new
  end

  it "has a name" do
    region = Region.new
    expect(region).to respond_to(:name)
  end

  it "has a string representation that is its name" do
    name = 'Mt. Hood'
    region = Region.new(name: name)
    result = region.to_s
  end

  it { should have_many(:tickets) }

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  it "to_s returns the name" do
    name = 'Mt. Hood'
    region = Region.new(name: name)
    result = region.to_s
    expect(result).to eq(name)
  end

  it "unspecified returns the unspecified region" do
    region = Region.unspecified
    expect(region.name).to eq('Unspecified')
  end

  it "unspecified returns the same region if it already exists" do
    region = Region.new(name: 'Unspecified')
    region.save
    result = Region.unspecified
    expect(result).to eq(region)
  end

end
