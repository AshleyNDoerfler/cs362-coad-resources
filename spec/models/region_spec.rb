require 'rails_helper'

RSpec.describe Region, type: :model do
  let(:region) { build(:region, name: 'Mt. Hood') }

  # it "exists" do
  #   Region.new
  # end

  describe "attributes" do
    it "has a name" do
      expect(region).to respond_to(:name)
    end

    it "has a string representation that is its name" do
      name = 'Mt. Hood'
      result = region.to_s
      expect(result).to eq(name)
    end
  end

  describe "associations" do
    it { should have_many(:tickets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe "member functions" do
    let(:region) { build(:region, name: 'Mt. Hood') }
    let(:region_unspecified) { build(:region, name: 'Unspecified') }

    it "to_s returns the name" do
      name = 'Mt. Hood'
      result = region.to_s
      expect(result).to eq(name)
    end

    it "unspecified returns the unspecified region" do
      expect(region_unspecified.name).to eq('Unspecified')
    end

    it "unspecified returns the same region if it already exists" do
      region_unspecified.save
      result = Region.unspecified
      expect(result).to eq(region_unspecified)
    end
  end

end
