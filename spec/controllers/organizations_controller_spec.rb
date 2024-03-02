require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

let(:user) { create(:user, email: "email@gmail.com") }
let(:admin_user) { create(:user, :admin, email: "email@gmail.com") }
let(:organization) { create(:organization) }

  describe "GET #index" do
    context "while logged in" do
      before(:each) { sign_in(user) }
      it { expect(get(:index)).to be_successful }
    end

    context "while logged in as admin" do
      before(:each) { sign_in(admin_user) }
      it { expect(get(:index)).to be_successful }
    end

    context "while logged out" do
      it { expect(get(:index)).to redirect_to(new_user_session_path) }
    end
  end

  describe "GET #new" do
    context "while logged in" do
      before(:each) { sign_in(user) }
      it { expect(get(:new)).to be_successful }
    end

    context "while logged out" do
      it { expect(get(:new)).to redirect_to(new_user_session_path) }
    end
  end 

  describe "POST #create" do
    context "success" do
      let(:organization) { create(:organization) }
      let(:params) do
        {
          organization: {
            name: "Fake Organization",
            phone: "555-555-5555",
            description: "Fake Description",
            liability_insurance: true,
            primary_name: "Fake Name",
            secondary_name: "Fake Name",
            secondary_phone: "555-555-5555",
            title: "Fake Title",
          }
        }
      end
      before(:each) { sign_in(user) }
      it { expect(post(:create, params: params)).to be_successful }
    end

    context "failure" do
      let(:params) do
        {
          organization: {
            name: nil,
            phone: nil,
            description: nil,
            liability_insurance: nil,
            primary_name: nil,
            secondary_name: nil,
            secondary_phone: nil,
            title: nil,
          }
        }
      end
      before(:each) { sign_in(user) }
      it { expect(post(:create, params: params)).to be_successful }
    end

  end

  describe "POST #update" do
    before { sign_in user }

      context 'with valid params' do
        let(:valid_params) { { name: 'Updated Organization Name' } }

        it 'redirects to organization_path' do
          post(:update, params: { id: organization.id, organization: valid_params })
          expect(response).to redirect_to(dashboard_path)
        end
    end
  end

  describe "approve" do
    before { sign_in admin_user }

    it "approves an organization" do
      organization.approve
      expect(organization).to be_approved
    end
  end

# TODO
# edit
# update
# show
# approve
# reject

end