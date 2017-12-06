class GithubService

  def initialize(user)
    @user = user
    @connection = Faraday.new(url: 'https://api.github.com/') do |faraday|
      faraday.headers['Authorization'] = "token #{user.token}"
      faraday.headers['Accept'] = "application/vnd.github.cloak-preview"
      faraday.adapter Faraday.default_adapter
    end
  end

  def user_information
    response = connection.get('/user')
    JSON.parse(response.body, symbolize_names: true)
  end

  def starred_repos_count
    response = connection.get('/user/starred')
    JSON.parse(response.body, symbolize_names: true).count
  end

  def recent_commits
    response = connection.get("/search/commits?q=author:#{user.nickname}&sort=author-date")
    JSON.parse(response.body, symbolize_names: true)[:items][0..14]
  end

  def following_users
    following_users = []
    response = connection.get("/users/#{user.nickname}/following")
    JSON.parse(response.body, symbolize_names: true).each do |user|
      following_users << user[:login]
    end
    following_users
  end

  def recent_following_commits
    following_commits = {}
    following_users.each do |user_nickname|
      response = connection.get("/search/commits?q=author:#{user_nickname}&sort=author-date")
      following_commits[user_nickname] = JSON.parse(response.body, symbolize_names: true)[:items][0..4]
    end
    following_commits
  end

  def repos
    response = connection.get("/users/#{user.nickname}/repos?sort=updated")
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  attr_reader :connection, :user

end
