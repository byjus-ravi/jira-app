class SubtasksController<ApplicationController

    before_action :authenticate_user!


    def touser
        @subtasks=current_user.assigned_tasks
    end

    def byuser
        @subtasks=current_user.owned_tasks
    end

    def index
        @subtask=Subtasks.all
    end

    def new
        @subtask=Subtask.new
        @subtask.story_id=params[:story]
        allusers=User.all
        @users=Array.new()
        allusers.each do |u|
           @users.push(u.email)
        end
    end

    def show
        @x=1
        @a="Oldest on top"
        @subtask=Subtask.find(params[:id])


        allusers=User.all
        @users=Array.new()
        allusers.each do |u|
           @users.push(u.email)
        end


        id=@subtask.id
        @comments=Comment.find_by_sql("select * from comments where subtask_id=#{id} order by created_at desc")

        if params[:num] && params[:num]=="1"
            @comments=Comment.find_by_sql("select * from comments where subtask_id=#{id} order by created_at asc")
            @x=2
            @a="Newest on top"
        elsif params[:num] && params[:num]=="2"
            @comments=Comment.find_by_sql("select * from comments where subtask_id=#{id} order by created_at desc")
            @x=1
            @a="Oldest on top"
        end
    end

    def create
        puts params
        @subtask=Subtask.new(subtask_params)
        user=User.find_by(email:params[:subtask][:assignee_id])
        @subtask.user=current_user
        @subtask.reporter=current_user
        @subtask.assignee=user
        if @subtask.save
            redirect_to story_path(params[:subtask][:story_id]),flash: {message:"Subtask created successfully"}
        end
    end


    def update
        @subtask=Subtask.find(params[:id])
        if params[:subtask][:assignee_id]
            user=User.find_by(email:params[:subtask][:assignee_id])
            @subtask.assignee=user
            @subtask.save
            redirect_to subtask_path(@subtask),flash: {message: "Assignee is changed successfully"}
        elsif @subtask.update(params.require(:subtask).permit(:status))
            redirect_to subtask_path(@subtask),flash: {message: "Status is changed successfully"}
        else
            redirect_to subtask_path(@subtask),flash: { error: @subtask.errors.full_messages }
        end
    end


    private

    def subtask_params
        params.require(:subtask).permit(:name,:description,:story_id,:status,:duedate,:team,:priority)
    end
end