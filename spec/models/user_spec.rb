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

end
