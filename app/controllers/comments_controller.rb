class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :authorize_user
  before_action :authorize_admin, except: [:index, :show]

  def index
    @comments = Comment.all
    render json: @comments
  end

  def show
    render json: @comment
  end

  # get comments related to a challenge
  def challenge_comments
    @comments = Comment.where(challenge_id: params[:challenge_id])
    render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)
    # check if the user_id param is the same as the current user's id
    # if not, return an error
    if @comment.user_id != @current_user.id
      render json: { error: 'You are not authorized to create this comment' }, status: :unauthorized
      return
    end
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @current_user.id != comment_params[:user_id]
      render json: { error: 'You are not authorized to update this comment' }, status: :unauthorized
      return
    end
    if @comment.challenge_id != comment_params[:challenge_id]
      render json: { error: 'You cannot change the challenge for this comment' }, status: :unauthorized
      return
    end
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    #render json with success message that comment was deleted
    render json: { message: 'Comment was successfully deleted' }
    # head :no_content
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text, :user_id, :challenge_id)
  end
end
