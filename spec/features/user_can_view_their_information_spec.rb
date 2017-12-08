require 'rails_helper'

describe "user logs in to their account" do
  before do
    omniauth_stub
  end

  it "user can see their profile info, commits, repos and follower activity" do
    VCR.use_cassette("user_views_profile_info") do
      visit(root_path)

      click_on('Login with Github')

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content(User.first.nickname)
      expect(User.first.image).to eq("https://avatars3.githubusercontent.com/u/22040967?s=460&v=4")
      expect(page).to have_content("Starred Repos (1)")
      expect(page).to have_content("Following (3)")
      expect(page).to have_content("Followers (0)")
      expect(page).to have_content("Your Recent Commits")
      expect(page).to have_content("Your Repositories (30)")
      expect(page).to have_content("Users You Follow Activity")
    end
  end
end
