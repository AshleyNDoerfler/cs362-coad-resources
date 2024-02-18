require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
  let(:user) { create(:user, email: "email@gmail.com") } # Assuming you have a factory for users
  let(:admin) { create(:admin) } # Assuming you have a factory for admins
  let(:valid_attributes) { attributes_for(:resource_category) } # Assuming you have a factory for resource categories

  describe 'GET #index while logged out' do
    it { expect(get(:index)).to redirect_to(new_user_session_path) }
  end

end
