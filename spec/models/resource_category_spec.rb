require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  # it "exists" do
  #   ResourceCategory.new
  # end

  describe "attributes" do
    let(:resource_category) { create(:resource_category) }

    it "has a name" do
      expect(resource_category).to respond_to(:name)
    end

    it "has an active flag" do
      expect(resource_category).to respond_to(:active)
    end

    it "is active by default" do
      expect(resource_category.active).to eq(true)
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
    let(:resource_category) { create(:resource_category, active: false) }

    it "to_s returns the name" do
      name = "Billy Ray Cyrus"
      result = resource_category.to_s
      expect(result).to eq(name)
    end

    it "activate sets active to true" do
      resource_category.activate
      expect(resource_category.active).to eq(true)
    end

    it "deactivate sets active to false" do
      resource_category.deactivate
      expect(resource_category.active).to eq(false)
    end

    it "inactive? returns true if active is false" do
      expect(resource_category.inactive?).to eq(true)
    end

    it "inactive? returns false if active is true" do
      resource_category.activate
      expect(resource_category.inactive?).to eq(false)
    end
  end

  describe "static functions" do
    let(:resource_category) { create(:resource_category) }
    let(:resource_category_unspecified) { create(:resource_category, name: 'Unspecified', active: false) }

    it "unspecified returns the unspecified resource category" do
      resource_category = ResourceCategory.unspecified
      expect(resource_category.name).to eq('Unspecified')
    end

    it "unspecified returns the same resource category if it already exists" do
      resource_category_unspecified.save
      result = ResourceCategory.unspecified
      expect(result).to eq(resource_category_unspecified)
    end
  end

  describe "scopes" do
    let(:active_resource_category) { ResourceCategory.create(name: 'Active', active: true) }
    let(:inactive_resource_category) { ResourceCategory.create(name: 'Inactive', active: false) }

    it "active returns active resource categories" do
      result = ResourceCategory.active
      expect(result).to include(active_resource_category)
      expect(result).to_not include(inactive_resource_category)
    end

    it "inactive returns inactive resource categories" do
      result = ResourceCategory.inactive
      expect(result).to include(inactive_resource_category)
      expect(result).to_not include(active_resource_category)
    end
  end

end
