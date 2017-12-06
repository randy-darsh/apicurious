class GithubUser
  attr_reader :name, :location, :followers, :following, :email, :avatar_url, :description, :login_name
  
  def initialize(attributes = {})
    @name = attributes[:name]
    @email = attributes[:email]
    @location = attributes[:location]
    @followers = attributes[:followers]
    @following = attributes[:following]
    @avatar_url = attributes[:avatar_url]
    @description = attributes[:bio]
    @login_name = attributes[:login]
  end
end
