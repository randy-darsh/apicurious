class GithubService

  def initialize(user)
    @user = user
    @conn = Faraday.new(url: 'https://api.github.com/') do |faraday|
      faraday.headers['Authorization'] = "token #{user.token}"
      faraday.headers['Accept'] = "application/vnd.github.cloak-preview"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_basic_info
    response = conn.get('/user')
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_starred_repos_count
    response = conn.get('/user/starred')
    JSON.parse(response.body, symbolize_names: true).count
  end

  def get_recent_commits
    response = conn.get("/search/commits?q=author:#{user.nickname}&sort=author-date")
    JSON.parse(response.body, symbolize_names: true)[:items][0..9]
  end

  def following_users
    following_users = []
    response = conn.get("/users/#{user.nickname}/following")
    JSON.parse(response.body, symbolize_names: true).each do |user|
      following_users << user[:login]
    end
    following_users
  end

  def get_recent_following_commits
    following_commits = {}
    following_users.each do |user_nickname|
      response = conn.get("/search/commits?q=author:#{user_nickname}&sort=author-date")
      following_commits[user_nickname] = JSON.parse(response.body, symbolize_names: true)[:items][0..2]
    end
    following_commits
  end

  def get_repos
    response = conn.get("/users/#{user.nickname}/repos?sort=updated")
    JSON.parse(response.body, symbolize_names: true)
  end

  private

    attr_reader :conn,
                :user

end