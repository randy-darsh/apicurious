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
    get_json('/user')
  end

  def starred_repos_count
    get_json('/user/starred').count
  end

  def recent_commits
    get_json("/search/commits?q=author:#{user.nickname}&sort=author-date")[:items][0..14]
  end

  def followed_users
    followed_users = []
    get_json("/users/#{user.nickname}/following").each do |user|
      followed_users << user[:login]
    end
    followed_users
  end

  def recent_followed_commits
    followed_commits = {}
    followed_users.each do |user_nickname|
      followed_commits[user_nickname] = get_json("/search/commits?q=author:#{user_nickname}&sort=author-date")[:items][0..4]
    end
    followed_commits
  end

  def repos
    get_json("/users/#{user.nickname}/repos?sort=updated")
  end

  private

  attr_reader :connection, :user

  def get_json(url)
    response = connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

end
