require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do
  let(:user) { create(:user, email: "user@gmail.com") }

  it 'logs in a user' do
    visit new_user_session_path  
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully'  
    expect(page).to have_content "Welcome to your dashboard!"
  end

end
