require 'rails_helper'

RSpec.describe Organization, type: :model do

  it "exists" do
    Organization.new
  end

  it "has a name" do
    organization = Organization.new
    expect(organization).to respond_to(:name)
  end

  it "has a status" do
    organization = Organization.new
    expect(organization).to respond_to(:status)
  end

  it "has a phone" do
    organization = Organization.new
    expect(organization).to respond_to(:phone)
  end

  it "has an email" do
    organization = Organization.new
    expect(organization).to respond_to(:email)
  end

  it "has a description" do
    organization = Organization.new
    expect(organization).to respond_to(:description)
  end

  it "has a rejection_reason" do
    organization = Organization.new
    expect(organization).to respond_to(:rejection_reason)
  end

  it "has a liability_insurance flag" do
    organization = Organization.new
    expect(organization).to respond_to(:liability_insurance)
  end

  it "liability_insurance defaults to false" do
    organization = Organization.new
    expect(organization.liability_insurance).to eq(false)
  end

  it "has a primary_name" do
    organization = Organization.new
    expect(organization).to respond_to(:primary_name)
  end

  it "has a secondary_name" do
    organization = Organization.new
    expect(organization).to respond_to(:secondary_name)
  end

  it "has a secondary_phone" do
    organization = Organization.new
    expect(organization).to respond_to(:secondary_phone)
  end

  it "has a title" do
    organization = Organization.new
    expect(organization).to respond_to(:title)
  end

  it "has a transportation" do
    organization = Organization.new
    expect(organization).to respond_to(:transportation)
  end

  describe "associations" do
    it { should have_many(:users) }
    it { should have_many(:tickets) }
    it { should have_and_belong_to_many(:resource_categories) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:primary_name) }
    it { should validate_presence_of(:secondary_name) }
    it { should validate_presence_of(:secondary_phone) }

    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:name).case_insensitive }

    it { should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_length_of(:description).is_at_most(1020).on(:create) }
  end

  it "to_s returns the name" do
    name = 'Peepee Poopoo'
    organization = Organization.new(name: name)
    result = organization.to_s
    expect(result).to eq(name)
  end

  it "approve sets status to 'approved'" do
    organization = Organization.new(status: :submitted)
    organization.approve
    expect(organization.status).to eq('approved')
  end

  it "reject sets status to 'rejected'" do
    organization = Organization.new(status: :submitted)
    organization.reject
    expect(organization.status).to eq('rejected')
  end

end
