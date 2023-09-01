class CommentsController < ApplicationController

    def new
        @post = Post.find(params[:post_id]) 
        @comment = @post.comments.new
      end
      

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(comment_params)
        @comment.author = current_user

        if @comment.save
            flash[:notice] = 'Comment is Ceated!'
        else
            flash[:alert] = 'Comment is not Created!'
        end
        redirect_to @post
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        @user = current_user
      end

    private

    def comment_params
        params.require(:comment).permit(:text)
    end
end
