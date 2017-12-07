require 'rails_helper'

describe 'user visits the welcome page' do
  before do
    omniauth_stub
  end

  it 'they can log in' do
    VCR.use_cassette("user_logs_in") do
      visit root_path

      click_on "Login with Github"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("randy-darsh")
      expect(page).to have_link("Logout")
      expect(page).to_not have_content('Login with Github')
    end
  end

  it 'they can log out' do
    VCR.use_cassette("user_logs_out") do
      visit root_path

      click_on "Login with Github"

      click_on "Logout"

      expect(page).to have_content("Login with Github")
      expect(page).to_not have_content("randy-darsh")
      expect(page).to_not have_content("Logout")
    end
  end
end
