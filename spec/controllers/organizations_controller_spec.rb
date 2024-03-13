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

  describe "POST #approve" do
    before { sign_in admin_user }

    it "approves an organization" do
      organization.approve
      expect(organization).to be_approved
    end

    context 'saved successfully' do
      it 'redirects to organizations_path' do
        post(:approve, params: { id: organization.id })
        expect(response).to redirect_to(organizations_path)
      end

      it 'sets a flash notice' do
        post(:approve, params: { id: organization.id })
        expect(flash[:notice]).to eq("Organization #{organization.name} has been approved.")
      end
    end

    context 'not saved successfully' do
      let(:organization_path) {}
      before do
        allow(organization).to receive(:save).and_return(false)
      end

      it 'renders organization_path' do
        post(:approve, params: { id: organization.id })
        expect(response).to render_template(organization_path)
      end
    end

  end

  describe "POST #reject" do
    before { sign_in admin_user }

    let(:organization) { create(:organization) }
    let(:valid_params) do
      {
        id: organization.id,
        organization: {
          rejection_reason: "Some reason for rejection"
        }
      }
    end

    it "rejects an organization" do
      post(:reject, params: valid_params)
      expect(organization.reload).to be_rejected
    end

    context 'saved successfully' do
      it 'redirects to organizations_path' do
        post(:reject, params: valid_params)
        expect(response).to redirect_to(organizations_path)
      end

      it 'sets a flash notice' do
        post(:reject, params: valid_params)
        expect(flash[:notice]).to eq("Organization #{organization.name} has been rejected.")
      end
    end

    # context 'not saved successfully' do
    #   let(:invalid_params) do
    #     {
    #       id: nil,
    #       organization: {
    #         rejection_reason: nil  
    #       }
    #     }
    #   end

    #   it 'renders organization_path' do
    #     allow(organization).to receive(:save).and_return(false)
    #     post(:reject, params: invalid_params)
    #     expect(response).to render_template(organization_path)
    #   end
    # end
  end

end