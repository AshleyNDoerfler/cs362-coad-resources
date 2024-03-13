require 'rails_helper'

RSpec.describe 'Deleting a Resource Category', type: :feature do
  let(:admin) { create(:user, :admin, email: "emails@gmail.com") }
  let!(:resource_category) { create(:resource_category) }

  context 'as an admin' do

    it 'deletes a resource category' do
      log_in_as(admin)
      visit resource_categories_path
      click_on resource_category.name
      expect(page).to have_content(resource_category.name)
      click_on 'Delete'
      expect(page).to have_content('Category' + ' ' + resource_category.name + ' ' + 'was deleted.')
    end
  end

end
