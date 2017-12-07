require 'rails_helper'

RSpec.describe User, type: :model do
  it "creates or updates itself from an oauth hash" do
    auth = {
      provider: 'github',
      uid: '192837465',
      info: {
        nickname: 'randy-darsh',
        name: 'Randy Springer',
        email: 'person@person.com'
      },
      credentials: {
        token: "1a2s3t4r5i6n7g"
      }
    }

    User.update_or_create(auth)
    new_user = User.first

    expect(new_user.provider).to eq auth[:provider]
    expect(new_user.uid).to eq auth[:uid]
    expect(new_user.nickname).to eq auth[:info][:nickname]
    expect(new_user.name).to eq auth[:info][:name]
    expect(new_user.email).to eq auth[:info][:email]
    expect(new_user.token).to eq auth[:credentials][:token]
  end
end