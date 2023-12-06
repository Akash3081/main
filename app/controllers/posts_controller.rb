class PostsController < ApplicationController
  before_action :authorize_request
  before_action :set_post, only: %i[show update destroy]

  def index
    posts = Post.all
    render json: posts, include: :user
  end

  def create
    post = @current_user.posts.new(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @post, include: :user
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    head :no_content
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
