class Authentication < ApplicationRecord
  belongs_to :user

  validates :user_id,
            :provider,
            :uid,
            presence: true

  validates :provider, uniqueness: { scope: :uid }

  def self.find_by_auth(auth)
    find_by(provider: auth.provider, uid: auth.uid)
  end

  def self.find_or_create_by_oauth(auth)
    authentication =Authentication.find_by_auth(auth)
    if authentication.nil?
      Authentication.find_or_create_user(auth)
    else
      authentication.user
    end
  end

  def self.find_or_create_user(auth)
    registered_user = User.find_by(email: info.email)
    if registered_user
      user = User.create!(
        nickname: auth.info.name,
        email: auth.info.email,
        password: Devise.freandly_token[0, 20])
      Authentication.create!(
        provider: auth.provider,
        uid: auth.uid,
        user_id: user.id
        )
      user
    else
      Authentication.create!(
        provider: auth.provider,
        uid: auth.uid,
        user_id: registered_user.id
        )
      registered_user
    end
  end
end
