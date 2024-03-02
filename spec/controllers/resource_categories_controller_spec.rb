require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
  let(:user) { create(:user, email: "email@gmail.com") } # Assuming you have a factory for users
  let(:admin) { create(:admin) } # Assuming you have a factory for admins
  let(:valid_attributes) { attributes_for(:resource_category) } # Assuming you have a factory for resource categories
  let(:resource_category) { create(:resource_category) } # Assuming you have a factory for resource categories

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

  describe 'POST #create' do
    before(:each) do
      user.confirm
      sign_in(user)
    end

    context 'while save is successful' do
      before(:each) do
        user.confirm
        sign_in(user)
      end
      it { expect(post(:create, params: { resource_category: valid_attributes })).to redirect_to(dashboard_path) }
      
      it 'gives a success message' do
        post(:create, params: { resource_category: valid_attributes })
        expect(flash[:notice]) == 'Category successfully created.'
      end
    end

    context 'not saved successfully' do
      before do
        allow(resource_category).to receive(:save).and_return(false)
      end

      it 'renders new' do
        post(:create, params: { resource_category: valid_attributes })
        expect(response).to redirect_to(dashboard_path)
      end
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
