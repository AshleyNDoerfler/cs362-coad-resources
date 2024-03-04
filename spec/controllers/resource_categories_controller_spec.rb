require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
  let(:user) { create(:user, email: "email@gmail.com") } # Assuming you have a factory for users
  let(:admin) { create(:user, :admin, email: "email@gmail.com") }
  let(:valid_attributes) { attributes_for(:resource_category) } # Assuming you have a factory for resource categories
  let(:resource_category) { create(:resource_category) } # Assuming you have a factory for resource categories
  let(:invalid_params) { { resource_category: attributes_for(:resource_category, name: '') } }

  describe 'GET #index' do
    context 'while logged in' do
      before(:each) { sign_in(admin) }
      specify { expect(get(:index)).to be_successful }
    end

    context 'while logged out' do
      specify { expect(get(:index)).to redirect_to(new_user_session_path) }
    end
  end

  describe 'GET #new' do
    context 'while logged in' do
      before(:each) { sign_in(admin) }
      specify { expect(get(:new)).to be_successful }
    end

    context 'while logged out' do
      specify { expect(get(:new)).to redirect_to(new_user_session_path) }
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) { { resource_category: attributes_for(:resource_category) } }

      before(:each) { sign_in(admin) }
      it 'creates a new resource category' do
        expect {
          post :create, params: valid_params
        }.to change(ResourceCategory, :count).by(1)
      end

      it 'redirects to resource_categories_path' do
        post :create, params: valid_params
        expect(response).to redirect_to(resource_categories_path)
      end

      it 'sets a notice flash message' do
        post :create, params: valid_params
        expect(flash[:notice]) == ('Category successfully created.')
      end
    end

    context 'with invalid params' do

      before(:each) { sign_in(admin) }
      it 'does not create a new resource category' do
        expect {
          post :create, params: invalid_params
        }.not_to change(ResourceCategory, :count)
      end

      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    before { sign_in user }

    context 'with valid params' do
      let(:valid_params) { { name: 'Updated Resource Category Name' } }

      it 'updates' do
        post(:update, params: { id: resource_category.id, resource_category: valid_params })
        expect(flash[:notice]) == ('Category successfully updated.')
      end

      it 'fails to update' do
        expect{ patch(:update, params: invalid_params).to render_template(:edit)}
      end
    end
  end

  describe 'POST #activate' do
    before(:each) do
      user.confirm
      sign_in(user)
    end

    it 'activates a resource category' do
      resource_category.activate
      expect(resource_category).to be_active
    end

    context 'activated successfully' do
      it 'sets a flash notice' do
        post(:activate, params: { id: resource_category.id })
        expect(flash[:notice]) == ('Category activated.')
      end
    end

    context 'not activated successfully' do
      let(:resource_category_path) {}
      before do
        allow(resource_category).to receive(:activate).and_return(false)
      end

      it 'renders resource_category_path' do
        post(:activate, params: { id: resource_category.id })
        expect(flash[:alert]) == ('There was a problem activating the category.')
      end
    end
  end

  describe 'POST #deactivate' do
    before(:each) do
      user.confirm
      sign_in(user)
    end

    it 'deactivates a resource category' do
      resource_category.deactivate
      expect(resource_category).to be_inactive
    end

    context 'deactivated successfully' do
      it 'sets a flash notice' do
        post(:deactivate, params: { id: resource_category.id })
        expect(flash[:notice]) == ('Category deactivated.')
      end
    end

    context 'not deactivated successfully' do
      let(:resource_category_path) {}
      before do
        allow(resource_category).to receive(:deactivate).and_return(false)
      end

      it 'renders resource_category_path' do
        post(:deactivate, params: { id: resource_category.id })
        expect(flash[:alert]) == ('There was a problem deactivating the category.')
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      user.confirm
      sign_in(user)
    end

    it 'gives a notice' do
      delete :destroy, params: { id: resource_category.id }
      expect(flash[:notice]) == "Category #{resource_category.name} was deleted.\nAssociated tickets now belong to the 'Unspecified' category."
    end
  end

end
