require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe "GET #index while logged in" do
    let(:user) { create(:user, email: "email@gmail.com") }

    before(:each) { sign_in(user) }

    it { expect(get(:index)).to be_successful }
  end

  describe "GET #index while logged in as admin" do
    let(:admin_user) { create(:user, :admin, email: "email@gmail.com") }

    before(:each) { sign_in(admin_user) }

    it { expect(get(:index)).to be_successful }
  end

  describe "GET #index while logged out" do
    it { expect(get(:index)).to redirect_to(new_user_session_path) }
  end

end