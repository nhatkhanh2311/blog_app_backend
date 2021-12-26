class Api::SessionsController < ApplicationController
  def create
    if (user = User.find_by_username(params.require(:username)))
      if user.authenticate(params.require(:password))
        token = AuthenticationTokenService.encode(user.id)
        render json: { token: token, name: user.name }, status: :created
      else
        render json: { message: "wrong password" }, status: :unauthorized
      end
    else
      render json: { message: "username not exist" }, status: :unauthorized
    end
  end
end
