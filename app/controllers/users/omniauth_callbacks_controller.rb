class Users::OmniauthCallbacksController < ApplicationController
  def facebook
    basic_action
  end

  def google_oauth2
    basic_action
  end

  def basic_action
    @user = Authentication.find_or_create_by_oauth(request.env["omniauth.auth"])
    if @user.persisted?
      signed_in_and_redirect @user, event: :Authentication
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
    end
  end
end
