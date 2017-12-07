class DashboardController < ApplicationController

  def show
    @user = GithubUser.new(current_user)
    @user_information = GithubService.new(@user).user_information
    @starred_repos = GithubService.new(@user).starred_repos_count
    @recent_commits = GithubService.new(@user).recent_commits
    @users_followed_commits = GithubService.new(@user).recent_followed_commits
    @repos = GithubService.new(@user).repos
  end

end
