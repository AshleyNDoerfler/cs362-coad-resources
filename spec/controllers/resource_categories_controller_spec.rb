require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
  let(:user) { create(:user, email: "email@gmail.com") } # Assuming you have a factory for users
  let(:admin) { create(:admin) } # Assuming you have a factory for admins
  let(:valid_attributes) { attributes_for(:resource_category) } # Assuming you have a factory for resource categories

  describe 'GET #index' do
    context 'while logged out' do
      it { expect(get(:index)).to redirect_to(new_user_session_path) }
    end

    # TODO: Fix this test
    # context 'while logged in' do
    #   before(:each) do
    #     user.confirm
    #     sign_in(user)
    #   end
    #   it { expect(get(:index)).to be_successful}
    # end
  end

  describe 'GET #new' do
    context 'while logged out' do
      it { expect(get(:new)).to redirect_to(new_user_session_path) }
    end

    context 'while logged in' do
      before(:each) do
        user.confirm
        sign_in(user)
      end
      it { expect(get(:new)).to redirect_to(dashboard_path) }
    end
  end

  # TODO
  # index
  # show
  # create
  # edit
  # update
  # activate
  # deactivate
  # destroy

end
