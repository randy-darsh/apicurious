class GithubUser
  attr_reader :id,
              :uid,
              :nickname,
              :name,
              :provider,
              :email,
              :token,
              :image

  def initialize(attributes = {})
    @id = attributes[:id]
    @uid = attributes[:uid]
    @nickname = attributes[:nickname]
    @name = attributes[:name]
    @provider = attributes[:provider]
    @email = attributes[:email]
    @token = attributes[:token]
    @image = attributes[:image]
  end
end
