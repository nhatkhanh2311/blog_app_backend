class Api::EntriesController < ApplicationController
  before_action :logged_in?, only: %i[index create]

  def index
    entries = @user.entries.order(created_at: :desc)
    render json: {
      entries: as_json(entries),
      username: @user.username,
      name: @user.name,
      avatar: @user.avatar.service_url
    }, status: :ok
  end

  def index_user
    user = User.find_by_username(username_params)
    entries = user.entries.order(created_at: :desc)
    render json: {
      entries: as_json(entries),
      username: user.username,
      name: user.name,
      avatar: user.avatar.service_url
    }, status: :ok
  end

  def index_all
    entries = if !user_id.nil?
                Entry.where("user_id IN (SELECT followed_id FROM relationships WHERE follower_id = #{user_id})
                            OR user_id = #{user_id}").order(created_at: :desc)
              else
                Entry.all.order(created_at: :desc)
              end
    render json: { entries: as_json_all(entries) }, status: :ok
  end

  def create
    entry = @user.entries.build(entry_params)
    if entry.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :body, :image)
  end

  def as_json(entries)
    entries.map do |entry|
      {
        id: entry.id,
        title: entry.title,
        body: entry.body,
        image: entry.image.service_url,
        created_at: entry.created_at,
        updated_at: entry.updated_at
      }
    end
  end

  def as_json_all(entries)
    entries.map do |entry|
      user = User.find(entry.user_id)
      {
        id: entry.id,
        title: entry.title,
        body: entry.body,
        image: entry.image.service_url,
        created_at: entry.created_at,
        updated_at: entry.updated_at,
        username: user.username,
        name: user.name,
        avatar: user.avatar.service_url
      }
    end
  end
end
