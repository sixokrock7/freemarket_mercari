class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    basic_action
  end

  def google_oauth2
    basic_action
  end

  private

  def basic_action
    @user = Authentication.find_or_create_by_oauth(request.env["omniauth.auth"])
    if @user.persisted?
      signed_in_and_redirect @user, event: :authentication
    else
      redirect_to new_user_registration_url
    end
  end
end
