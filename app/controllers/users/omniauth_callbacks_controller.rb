class Users::OmniauthCallbacksController < ApplicationController
  def facebook
    @user = Authentication.find_for_facebook_oauth(request.env["omniauth.auth"])

    if @user.persisted?
      signed_in_and_redirect @user, event: :Authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
