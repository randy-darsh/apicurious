class DashboardController < ApplicationController
  def show
    raw_data = GithubService.new(current_user).find_user
    @starred_repos = GithubService.new(current_user).find_starred_repos
    @all_repos = GithubService.new(current_user).find_all_repos
    @github_user = GithubUser.new(raw_data)
  end
  
  def all_repos
    raw_data = GithubService.new(current_user).find_user
    @starred_repos = GithubService.new(current_user).find_starred_repos
    @all_repos = GithubService.new(current_user).find_all_repos
    @github_user = GithubUser.new(raw_data)
  end

  def recent_commits
    raw_data = GithubService.new(current_user).find_user
    @recent_commits = GithubService.new(current_user).find_recent_commits
    @starred_repos = GithubService.new(current_user).find_starred_repos
    @all_repos = GithubService.new(current_user).find_all_repos
    @github_user = GithubUser.new(raw_data)
  end
end
