class GithubService
  def initialize(user)
    @conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{user.oauth_token}"
      faraday.adapter Faraday.default_adapter
      @user = user
    end
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_user
    response = @conn.get("/user")
    parse(response)
  end

  def find_starred_repos
    response = @conn.get("/user/starred")
    parse(response)
  end

  def find_all_repos
    response = @conn.get("/user/repos")
    parse(response)
  end

  def find_recent_commits
    commit_hash = {}
    repos = get_all_repos
    repos.each do |repo|
      raw = @conn.get("/repos/#{user.nickname}/#{repo[:name]}/stats/participation")
      parsed = parse(raw)
      number = parsed[:owner].sum
      repo_name = repo[:name]
      commit_hash[repo_name] = number
    end
    commit_hash
    # parse(response)
  end

  private

  attr_reader :conn, :user
end
