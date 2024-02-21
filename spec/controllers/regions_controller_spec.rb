require 'rails_helper'

RSpec.describe RegionsController, type: :controller do

  context 'as an admin user' do
    let(:admin) { create(:user, :admin, email: "email@gmail.com") }
    before(:each) { sign_in(admin) }

    describe 'POST #create' do
      let(:region) { create(:region) }

      context 'success' do
        let(:params) do
          {
            region: {
              name: 'Fake Region',
              description: 'Fake Description'
            }
          }
        end

        specify { expect(post(:create, params: params)).to redirect_to regions_path }
      end

      context 'failure' do
        let(:params) do
          {
            region: {
              name: nil,
              description: nil
            }
          }
        end

        specify { expect(post(:create, params: params)).to be_successful }
      end
    end
  end
  # TODO
  # index
  # show
  # new
  # create
  # edit
  # update
  # destroy

end
