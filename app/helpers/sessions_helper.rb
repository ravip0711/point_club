module SessionsHelper

  # Logs the given user.

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  # Returns the current logged-in user if any.
  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  # Returns true if the user is logged in, false otherwise.
  def signed_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def sign_out
    current_user.update_attribute(:remember_token, 
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

end
