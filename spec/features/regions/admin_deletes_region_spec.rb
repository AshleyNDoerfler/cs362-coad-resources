require 'rails_helper'

RSpec.describe 'Deleting a Region', type: :feature do
  let(:admin) { create(:user, :admin, email: "email@gmail.com") }
  let(:region) { create(:region) }

  before do
    log_in_as(admin)
    visit region_path(region)
  end

  it 'deletes the region' do
    click_on 'Delete'
    expect(page).to have_content('Region ' + region.name + ' was deleted.')
  end
end
