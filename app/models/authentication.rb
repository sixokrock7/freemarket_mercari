class Authentication < ApplicationRecord
  belongs_to :user

  def self.find_for_facebook_oauth(auth)
    user = Authentication.find_by(provider, uid: auth.uid)
    if user.nil?
      registrered_user = User.find_by(email: auth.info.email)
      if registered_user.nil?
        user = User.create!(
          nickname: auth.info.name,
          email: auth.info.email,
          password: Devise.freandly_token[0, 20]
          )
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
    else
      user.user
    end
  end
end
