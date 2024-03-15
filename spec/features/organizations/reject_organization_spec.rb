require 'rails_helper'

RSpec.describe 'Rejecting an organization', type: :feature do
  let(:admin) { create(:user, :admin, email: "email@gmail.com") }
  let(:organization) { create(:organization) }

  before do
    log_in_as(admin)
    organization.set_default_status
    visit organizations_path
  end

  it 'approves an organization' do
    click_on 'Pending'
    click_on organization.name
    click_on 'Reject'
    expect(page).to have_content('Organization ' + organization.name + ' has been rejected.')
    expect(page).to have_content(organization.name)
    expect(page).to have_content('Approved')
  end
end
