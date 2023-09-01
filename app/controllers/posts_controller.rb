class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = @post.comments
    @index = @user.posts.order(created_at: :asc).pluck(:id).index(@post.id) + 1
  end

  def new
    @post = Post.new
  end

  def create 
    @post = current_user.posts.new(post_params)
    
    if @post.save 
      flash[:notice] = 'Post is created!'
      redirect_to users_path
    else
      render :new
      flash[:notice] = 'Post is not created!'
  end
end

private

  def post_params 
   params.require(:post).permit(:title, :text)
  end
end