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

end
