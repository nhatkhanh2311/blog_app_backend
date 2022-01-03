class Api::CommentsController < ApplicationController
  before_action :logged_in?, only: %i[create]

  def index
    comments = Comment.where(entry_id: entry_id_params)
    render json: { comments: as_json(comments) }, status: :ok
  end

  def create
    comment = @user.comments.build(comment_params)
    if comment.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  private

  def entry_id_params
    params.require(:entry_id)
  end

  def comment_params
    params.require(:comment).permit(:content, :entry_id)
  end

  def as_json(comments)
    comments.map do |comment|
      user = User.find(comment.user_id)
      {
        id: comment.id,
        content: comment.content,
        created_at: comment.created_at,
        updated_at: comment.updated_at,
        username: user.username,
        name: user.name,
        avatar: user.avatar.service_url
      }
    end
  end
end
