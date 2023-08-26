class LikesController < ApplicationController
    before_action :set_post
  
    def create
      @like = Like.create(user: current_user, post: @post)
      if @like.save
        redirect_to @post, notice: 'Post liked successfully!'
      else
        redirect_to @post, alert: 'Unable to like the post.'
      end
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  end
  