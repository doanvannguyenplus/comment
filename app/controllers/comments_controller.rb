class CommentsController < ApplicationController
    before_action :find_micropost, only: :create

    def create
        # @micropost = 
        @comment = current_user.comments.build(comment_params)
        @comments = current_user.comments
        # @comment = Comment.new(comment_params)
		if @comment.save
            flash[:success] = "Comment created!"
            redirect_to micropost_path @micropost
			# redirect_to root_url
		else
			render 'microposts/show'
		end
    end

    def destroy
        @comment = Comment.find_by(id: params[:id])
        @comment.destroy
		flash[:success] = "Micropost deleted"
		redirect_to request.referrer || root_url
    end

private

def comment_params
    params.require(:comment).permit(:content, :user_id, :micropost_id, :id)
end

def find_micropost
    @micropost = Micropost.find_by id: comment_params[:micropost_id]
end

end
