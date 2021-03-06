class Api::UsersController < ApplicationController
  before_action :logged_in?, only: %i[avatar personal]

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

  def avatar
    if @user.avatar.attach(avatar_params)
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def personal
    render json: { user: as_json(@user) }, status: :ok
  end

  def user
    user = User.find_by_username(username_params)
    if !user_id.nil?
      following = Relationship.find_by(follower_id: user_id, followed_id: user.id)
      followed = !following.nil?
    else
      followed = false
    end
    render json: { user: as_json(user), followed: followed }, status: :ok
  end

  def search
    users = User.where("LOWER(name) LIKE '%#{search_params}%' OR username LIKE '%#{search_params}%'")
    render json: { users: as_json_search(users) }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :name, :email, :birthday, :phone, :gender)
  end

  def avatar_params
    params.require(:avatar)
  end

  def search_params
    params.require(:search)
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
      avatar: user.avatar.service_url,
      created_at: user.created_at,
      updated_at: user.updated_at
    }
  end

  def as_json_search(users)
    users.map do |user|
      as_json(user)
    end
  end
end
