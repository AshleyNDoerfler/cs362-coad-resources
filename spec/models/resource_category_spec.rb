require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  it "exists" do
    ResourceCategory.new
  end

  describe "attributes" do
    it "has a name" do
      expect(ResourceCategory.new).to respond_to(:name)
    end

    it "has an active flag" do
      expect(ResourceCategory.new).to respond_to(:active)
    end

    it "is active by default" do
      expect(ResourceCategory.new.active).to eq(true)
    end
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
  
  describe "member functions" do
    it "to_s returns the name" do
      name = 'Peepee Poopoo'
      resource_category = ResourceCategory.new(name: name)
      result = resource_category.to_s
      expect(result).to eq(name)
    end

    it "activate sets active to true" do
      resource_category = ResourceCategory.new(active: false)
      resource_category.activate
      expect(resource_category.active).to eq(true)
    end

    it "deactivate sets active to false" do
      resource_category = ResourceCategory.new(active: true)
      resource_category.deactivate
      expect(resource_category.active).to eq(false)
    end

    it "inactive? returns true if active is false" do
      resource_category = ResourceCategory.new(active: false)
      expect(resource_category.inactive?).to eq(true)
    end

    it "inactive? returns false if active is true" do
      resource_category = ResourceCategory.new(active: true)
      expect(resource_category.inactive?).to eq(false)
    end
  end

  describe "static functions" do
    it "unspecified returns the unspecified resource category" do
      resource_category = ResourceCategory.unspecified
      expect(resource_category.name).to eq('Unspecified')
    end

    it "unspecified returns the same resource category if it already exists" do
      resource_category = ResourceCategory.new(name: 'Unspecified')
      resource_category.save
      result = ResourceCategory.unspecified
      expect(result).to eq(resource_category)
    end
  end

end
