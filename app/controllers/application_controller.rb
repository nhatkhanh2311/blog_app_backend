class ApplicationController < ActionController::API
  def logged_in?
    if token
      user_id = AuthenticationTokenService.decode(token)
      @user = User.find(user_id)
    else
      render status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render status: :unauthorized
  end

  def token
    request.headers[:Authorization].split(" ").last if request.headers[:Authorization].present?
  end
end
