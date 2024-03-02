require 'rails_helper'

RSpec.describe RegionsController, type: :controller do
  let(:admin) { create(:user, :admin, email: "email@gmail.com") }

  context 'as an admin user' do
    before(:each) { sign_in(admin) }

    describe 'POST #create' do
      let(:region) { create(:region) }

      context 'success' do
        let(:params) { { region: attributes_for(:region) } }
        specify { expect(post(:create, params: params)).to redirect_to regions_path }
      end

      context 'failure' do
        let(:params) { { region: attributes_for(:region, name: nil, description: nil) } }
        specify { expect(post(:create, params: params)).to be_successful }
      end
    end
  end

  describe 'GET #edit' do
    let(:region) { create(:region) }
    
    before(:each) { sign_in(admin) }
    specify { expect(get(:edit, params: { id: region.id })).to be_successful }
  end




  # TODO
  # index
  # show
  # new
  # update
  # destroy

end
