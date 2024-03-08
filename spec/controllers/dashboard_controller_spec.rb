require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:user) { create(:user, email: "email@gmail.com") }
  let(:admin_user) { create(:user, :admin, email: "fuckemails@gmail.com") }
  let(:organization) { create(:organization) }
  let(:closed_ticket) { create(:ticket, status: 'Closed') }
  let(:captured_ticket) { create(:ticket, status: 'Captured') }
  let(:organization_ticket) { create(:ticket, organization: organization) }
  let(:organization_closed_ticket) { create(:ticket, organization: organization, status: 'Closed') }
  let(:organization_approved_user) { create(:user, organization: create(:organization, status: :approved), email: "emaildumb@gmail.com") }

  describe "GET #index while logged in" do
    before(:each) { sign_in(user) }

    it { expect(get(:index)).to be_successful }
  end

  describe "GET #index while logged in as admin" do
    before(:each) { sign_in(admin_user) }

    it { expect(get(:index)).to be_successful }
  end

  describe "GET #index while logged out" do
    it { expect(get(:index)).to be_successful }
  end

  describe "GET #index" do
    it 'returns status options for approved organization users' do
      sign_in organization_approved_user
      get :index
      expect(assigns(:status_options)).to eq(['Open', 'My Captured', 'My Closed'])
    end 
  end

  before do
    sign_in user
  end

  describe 'GET #index' do
  
    it 'returns a successful response for "Closed" tickets' do
      get :index, params: { status: 'Closed' }
      expect(response).to be_successful
    end

    it 'returns a successful response for "Captured" tickets' do
      get :index, params: { status: 'Captured' }
      expect(response).to be_successful
    end

    it 'returns a successful response for "My Captured" tickets' do
      get :index, params: { status: 'My Captured' }
      expect(response).to be_successful
    end

    it 'returns a successful response for "My Closed" tickets' do
      get :index, params: { status: 'My Closed' }
      expect(response).to be_successful
    end
  end

  describe 'GET #index' do
    it 'returns a successful response for "Open" tickets' do
      get :index, params: { status: 'Open' }
      expect(response).to be_successful
    end
  end


end