class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = @post.comments
    @index = @user.posts.order(created_at: :asc).pluck(:id).index(@post.id) + 1
  end
end