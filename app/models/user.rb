class User < ApplicationRecord
  def self.from_omniauth(auth_info)
    user = User.where(uid: auth_info["uid"]).first
    if user && user.oauth_token != auth_info["credentials"]["token"]
      user.oauth_token = auth_info["credentials"]["token"]
      user.save
    elsif user.nil?
      user = User.create(uid: auth_info["uid"], name: auth_info["info"]["name"], nickname: auth_info["info"]["nickname"], oauth_token: auth_info["credentials"]["token"])
    end
    user
  end
end
