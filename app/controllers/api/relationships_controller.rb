class Api::RelationshipsController < ApplicationController
  before_action :logged_in?, only: %i[follow followed_users]

  def follow
    following = @user.relationships.build(followed_id: followed_user_id)
    if following.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def followed_users
    followings = @user.relationships
    render json: { users: followed_users_as_json(followings) }, status: :ok
  end

  private

  def followed_user_id
    params.require(:followed_id)
  end

  def followed_users_as_json(followings)
    followings.map do |following|
      user = User.find(following.followed_id)
      {
        username: user.username,
        name: user.name
      }
    end
  end
end
