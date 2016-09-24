class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

    def confirm_logged_in
      # unless they dont have their session id (hand stamp)
      unless session[:user_id]
        flash[:notice] = "Please log in."
        redirect_to(controller: 'access', action: 'login')
        return false;   # halts the before_action; dont allow the rest of the action to proceed
      else
        return true
      end
    end
end
