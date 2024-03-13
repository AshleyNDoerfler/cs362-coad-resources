require 'rails_helper'

RSpec.describe 'Creating a Region', type: :feature do
  let(:admin) { create(:user, :admin, email: "email@gmail.com") }
  let(:region) { build(:region) }

  before { log_in_as(admin) }

  context 'as an admin' do
    it 'creates a region' do
      visit regions_path
      click_on 'Add Region'
      fill_in 'Name', with: region.name
      click_on 'Add Region'
      expect(page).to have_content(region.name)
    end
  end
end
