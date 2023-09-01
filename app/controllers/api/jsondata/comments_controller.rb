class Api::Jsondata::CommentsController < ApplicationController
    def index
      post = Post.find(params[:post_id])
      comments = post.comments
      render json: comments
    end
  
    def create
      post = Post.find(params[:post_id])
      user = User.find(params[:user_id])
      comment = post.comments.build(content: params[:content], user: user)
      if comment.save
        render json: comment, status: :created
      else
        render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end