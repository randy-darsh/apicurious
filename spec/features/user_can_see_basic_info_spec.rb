require 'rails_helper'

describe "User can view basic account info" do
  before do
    omniauth_stub
  end

  it "user can see their profile picture and other info" do
    VCR.use_cassette("user_views_basic_info") do
      visit(root_path)

      click_on('Login with Github')

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content(user.nickname)
    end
  end
end
