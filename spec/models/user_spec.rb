require 'rails_helper'

RSpec.describe User, type: :model do

  it "exists" do
    User.new
  end

  it "has an email" do
    user = User.new
    expect(user).to respond_to(:email)
  end

  it "email defaults to an empty string" do
    user = User.new
    expect(user.email).to eq("")
  end

  it "email is required" do
    user = User.new
    expect(user).to validate_presence_of(:email)
  end

  it "has an email that is a string" do
    user = User.new
    expect(user.email).to be_a(String)
  end

  it "has a role" do
    user = User.new
    expect(user). to respond_to(:role)
  end

  it "role defaults to 'organization'" do
    user = User.new
    expect(user.role).to eq("organization")
  end

  describe "associations" do
    it { should belong_to(:organization).options[:optional] }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }
    # it { should validate(:email).format(:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/) } # TODO: Fix This
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password).on(:create) }
    it { should validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create) }
  end

end
