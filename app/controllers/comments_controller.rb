class CommentsController<ApplicationController

    before_action :authenticate_user!

    def new
        @comment=Comment.new
        @comment.subtask_id=params[:subtask]
    end

    def create
        @comment=Comment.new(comment_params)
        @comment.user=current_user
        if @comment.save
            redirect_to subtask_path(params[:comment][:subtask_id])
        end
    end

    def destroy
        @comment=Comment.find(params[:id])
        subtask=@comment.subtask_id
        if @comment.user==current_user
        @comment.destroy
        end
        redirect_to subtask_path(subtask)
    end

    private

    def comment_params
        params.require(:comment).permit(:description,:subtask_id)
    end
end