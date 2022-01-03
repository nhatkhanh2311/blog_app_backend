class Api::RelationshipsController < ApplicationController
  before_action :logged_in?, only: %i[follow unfollow following_users followed_users]

  def follow
    following = @user.active_relationships.build(followed_id: following_user_id)
    if following.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def unfollow
    following = @user.active_relationships.find_by(followed_id: following_user_id)
    if following.destroy
      render status: :accepted
    else
      render status: :unprocessable_entity
    end
  end

  def following_users
    followings = @user.active_relationships
    render json: { users: following_users_as_json(followings) }, status: :ok
  end

  def followed_users
    followers = @user.passive_relationships
    render json: { users: followed_users_as_json(followers) }, status: :ok
  end

  private

  def following_user_id
    params.require(:followed_id)
  end

  def following_users_as_json(followings)
    followings.map do |following|
      user = User.find(following.followed_id)
      {
        username: user.username,
        name: user.name,
        avatar: user.avatar.service_url
      }
    end
  end

  def followed_users_as_json(followers)
    followers.map do |follower|
      user = User.find(follower.follower_id)
      {
        username: user.username,
        name: user.name,
        avatar: user.avatar.service_url
      }
    end
  end
end
