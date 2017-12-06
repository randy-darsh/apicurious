class User < ApplicationRecord

  def self.update_or_create(auth)
    user = find_by(uid: auth[:uid]) || User.new
    user.attributes = {
      uid: auth[:uid],
      provider: auth[:provider],
      nickname: auth[:info][:nickname],
      name: auth[:info][:name],
      email: auth[:info][:email],
      image: auth[:info][:image],
      token: auth[:credentials][:token]
    }
    user.save
    user
  end

end
