require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  let(:ticket) { create(:ticket) }
  let(:user) { create(:user, email: "email@gmail.com")}
  let(:admin) { create(:user, :admin, email: "email@gmail.com") }
  let(:admin_approved) { create(:user, :organization_approved, :admin, email: "email@email.com") }
  let(:admin_unapproved) { create(:user, :organization_unapproved, :admin, email: "email@email.com") }
  let(:organization_approved) { create(:user, :organization_approved, email: "email@email.com") }
  let(:organization_unapproved) { create(:user, :organization_unapproved, email: "email@email.com") }

  describe 'GET #new' do
    it { expect(get(:new)).to be_successful }
  end

  describe 'GET #show' do
    before do
      sign_in organization_approved
    end

    it { expect(get(:show, params: { id: ticket.id })).to be_successful }
  end


  describe 'POST #create' do
    let(:region) { create(:region) }
    let(:resource_category) { create(:resource_category) }

    context 'success' do
      let(:params) do
        {
          ticket: {
            name: 'Fake Ticket',
            phone: '555-555-5555',
            description: 'Fake Description',
            region_id: region.id,
            resource_category_id: resource_category.id
          }
        }
      end

      specify { expect(post(:create, params: params)).to redirect_to ticket_submitted_path }
    end

    context 'failure' do
      let(:params) do
        {
          ticket: {
            name: nil,
            phone: nil,
            description: nil,
            resource_category_id: nil
          }
        }
      end

      specify { expect(post(:create, params: params)).to be_successful }
    end
  end


  describe 'POST #capture' do
    context 'success' do
      before do
        sign_in(organization_approved)
        allow(TicketService).to receive(:capture_ticket).and_return :ok
      end

      specify { expect(post(:capture, params: { id: ticket.id })).to redirect_to dashboard_path << '#tickets:open' }

      it {
        expect(TicketService).to receive(:capture_ticket).and_return(:error)
        post(:capture, params: {id: ticket.id})
        expect(response).to be_successful
      }
    end

    context 'failure' do
      specify { expect(post(:capture, params: { id: ticket.id })).to_not be_successful }

      it 'returns unsuccessful if the user is an unapproved organization' do
        sign_in(organization_unapproved)
        expect(post(:capture, params: { id: ticket.id })).to_not be_successful
      end
    end

    context 'logged-out' do
      it { 
        post(:capture, params: { id: ticket.id })
        expect(response).to_not be_successful
        expect(response).to redirect_to(dashboard_path)
      }
      

      describe 'POST #release' do
        it {
          ticket = create(:ticket)
          post(:release, params: { id: ticket.id })
          expect(response).to redirect_to dashboard_path
        }
      end
    end

    context 'logged-in organization' do
      describe 'POST #release own ticket' do
        it {
          sign_in organization_approved
          ticket = create(:ticket, organization_id: organization_approved.organization_id)
          post(:release, params: { id: ticket.id })
          expect(response).to redirect_to (dashboard_path << '#tickets:organization')
        }
      end

      describe 'POST #release don\'t own ticket' do
        it {
          sign_in organization_approved
          other_organization = create(:organization, name: "Jojo", email: "email_69@email.com")
          ticket = create(:ticket, organization_id: other_organization.id)
          post(:release, params: { id: ticket.id })
          expect(response).to be_successful
        }
      end
    end

    context 'admin' do
      describe 'POST #release own ticket unapproved' do
        it {
          sign_in admin_unapproved
          ticket = create(:ticket)
          post(:release, params: { id: ticket.id })
          expect(response).to redirect_to dashboard_path
        }
      end

      describe 'POST #release own ticket unapproved' do
        it {
          sign_in admin_approved
          ticket = create(:ticket, organization_id: admin_approved.organization_id)
          post(:release, params: { id: ticket.id })
          expect(response).to redirect_to (dashboard_path << '#tickets:captured')
        }
      end
    end
  end

  describe 'PATCH #close' do
    context 'as logged-out user' do
      it "redirects to dashboard" do
        patch :close, params: { id: ticket.id }
        expect(response).to redirect_to dashboard_path
      end
    end

    context 'as logged-in user' do
      it "redirects to dashboard" do
        sign_in user
        patch :close, params: { id: ticket.id }
        expect(response).to redirect_to dashboard_path
      end
    end

    context 'as logged-in admin' do
      it "redirects to dashboard" do
        sign_in admin
        patch :close, params: { id: ticket.id }
        expect(response).to redirect_to dashboard_path << '#tickets:open'
      end
    end
    
    context 'as logged-in unapproved admin' do
      it "redirects to dashboard" do
        sign_in admin_unapproved
        patch :close, params: { id: ticket.id }
        expect(response).to redirect_to dashboard_path << '#tickets:open'
      end
    end

    context 'as logged-in organization' do
      it "to be successful" do
        sign_in organization_approved
        patch :close, params: { id: ticket.id }
        expect(response).to be_successful
      end
    end
  end

  # describe 'POST #release' do
  #   context 'success' do
  #     before do
  #       sign_in(organization_approved)
  #       allow(TicketService).to receive(:capture_ticket).and_return :ok
  #     end

  #     specify { expect(post(:release, params: { id: ticket.id })).to redirect_to dashboard_path << '#tickets:organization' }

  #     it {
  #       expect(TicketService).to receive(:release_ticket).and_return(:error)
  #       post(:release, params: {id: ticket.id})
  #       expect(response).to be_successful
  #     }
  #   end
  # end


# new 
# create
# show
# capture
# release TODO
# close TODO
# destroy TODO

end
