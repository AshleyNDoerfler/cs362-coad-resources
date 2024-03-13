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
    context 'with valid params' do
      let(:valid_update_params) { { resource_category: { name: 'Updated Category' } } }

      before(:each) { sign_in(admin) }

      it 'updates the resource category' do
        patch :update, params: { id: resource_category.id }.merge(valid_update_params)
        expect(resource_category.reload.name).to eq('Updated Category')
      end

      it 'redirects to the updated resource category' do
        patch :update, params: { id: resource_category.id }.merge(valid_update_params)
        expect(response).to redirect_to(resource_category)
      end

      it 'sets a notice flash message' do
        patch :update, params: { id: resource_category.id }.merge(valid_update_params)
        expect(flash[:notice]).to eq('Category successfully updated.')
      end
    end

    context 'with invalid params' do
      let(:invalid_update_params) { { resource_category: { name: '' } } }

      before(:each) { sign_in(admin) }

      it 'does not update the resource category' do
        original_name = resource_category.name
        patch :update, params: { id: resource_category.id }.merge(invalid_update_params)
        expect(resource_category.reload.name).to eq(original_name)
      end

      it 'renders the edit template' do
        patch :update, params: { id: resource_category.id }.merge(invalid_update_params)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'POST #activate' do
    
  end

  describe 'POST #deactivate' do
    # TODO
  end

  describe 'DELETE #destroy' do
    # TODO
  end

end
