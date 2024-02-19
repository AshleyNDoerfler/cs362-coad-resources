require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

# NOTE: may need "Devise gem"
let(:user) { create(:user, email: "email@gmail.com") }
let(:admin_user) { create(:user, :admin, email: "email@gmail.com") }

  describe "GET #index while logged in" do

    before(:each) { sign_in(user) }

    it { expect(get(:index)).to be_successful }
  end

  describe "GET #index while logged in as admin" do

    before(:each) { sign_in(admin_user) }

    it { expect(get(:index)).to be_successful }
  end

  describe "GET #index while logged out" do
    it { expect(get(:index)).to redirect_to(new_user_session_path) }
  end

  describe "GET #new while logged in" do

    before(:each) { sign_in(user) }

    it { expect(get(:new)).to be_successful }
    
  end
# TODO
# new
# create
# edit
# update
# show
# approve
# reject

end