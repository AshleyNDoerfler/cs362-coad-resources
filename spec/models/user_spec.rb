require 'rails_helper'

RSpec.describe User, type: :model do

  # it "exists" do
  #   User.new
  # end

  let(:user) { build(:user) }

  describe "attributes" do
    it "has an email" do
      expect(user).to respond_to(:email)
    end

    it "email defaults to an empty string" do
      expect(user.email).to eq("")
    end

    it "email is required" do
      expect(user).to validate_presence_of(:email)
    end

    it "has an email that is a string" do
      expect(user.email).to be_a(String)
    end

    it "has a role" do
      expect(user). to respond_to(:role)
    end

    it "role defaults to 'organization'" do
      expect(user.role).to eq("organization")
    end
  end

  describe "associations" do
    it { should belong_to(:organization).options[:optional] }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }
    it { should allow_value('fake@email.com').for(:email).on(:create) }
    it { should_not allow_value('fakeemail.com').for(:email).on(:create) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password).on(:create) }
    it { should validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create) }
  end

  describe "member functions" do
    it "to_s returns the email" do
      expect(user.to_s).to eq(user.email)
    end

    it "set_default_role sets role to 'organization'" do
      expect(user.set_default_role).to eq("organization")
    end
  end
  
end
