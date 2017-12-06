class DashboardController < ApplicationController

  def show
    @user = current_user
    @user_information = GithubService.new(@user).get_basic_info
    @starred_repos = GithubService.new(@user).get_starred_repos_count
    @recent_commits = GithubService.new(@user).get_recent_commits
    @users_followed_commits = GithubService.new(@user).get_recent_following_commits
    @repos = GithubService.new(@user).get_repos
  end

end
