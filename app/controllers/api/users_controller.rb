class Api::UsersController < ApplicationController
  before_action :logged_in?, only: [:personal]

  def create
    user = User.new(user_params)
    if user.save
      render status: :created
    elsif user.errors[:username].include?("has already been taken")
      render json: { message: "username taken" }, status: :unprocessable_entity
    elsif user.errors[:email].include?("has already been taken")
      render json: { message: "email taken" }, status: :unprocessable_entity
    else
      render status: :unprocessable_entity
    end
  end

  def personal
    render json: as_json(@user), status: :ok
  end

  def user
    user = User.find_by_username(username_params)
    render json: as_json(user), status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :name, :email, :birthday, :phone, :gender)
  end

  def as_json(user)
    {
      id: user.id,
      username: user.username,
      name: user.name,
      email: user.email,
      birthday: user.birthday,
      phone: user.phone,
      gender: user.gender,
      created_at: user.created_at,
      updated_at: user.updated_at
    }
  end
end
