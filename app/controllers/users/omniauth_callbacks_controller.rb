class Users::OmniauthCallbacksController < ApplicationController
  def facebook
    @user = Authentication.find_or_create_from_oauth(request.env["omniauth.auth"])

    if @user.persisted?
      signed_in_and_redirect @user, event: :Authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = Authentication.find_or_create_from_oauth(request.env["omniauth.auth"])
    if @user.persisted?
      signed_in_and_redirect @user, event: :Authentication
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
    end
  end
end
