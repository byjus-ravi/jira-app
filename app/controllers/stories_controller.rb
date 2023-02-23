class StoriesController<ApplicationController

    before_action :authenticate_user!

    def index
        @stories=Story.all
    end

    def new
        puts params[:epic]
        @story=Story.new
        @story.epic_id=params[:epic]
    end

    def show
        @story=Story.find(params[:id])
        @open=Subtask.find_by_sql("select * from subtasks where status=0 and story_id=#{params[:id]}").size
        @inprogress=Subtask.find_by_sql("select * from subtasks where status=1 and story_id=#{params[:id]}").size
        @fixed=Subtask.find_by_sql("select * from subtasks where status=2 and story_id=#{params[:id]}").size
        @rejected=Subtask.find_by_sql("select * from subtasks where status=3 and story_id=#{params[:id]}").size
        @verified=Subtask.find_by_sql("select * from subtasks where status=4 and story_id=#{params[:id]}").size
        @total=Subtask.find_by_sql("select * from subtasks where story_id=#{params[:id]}").size
    end

    def create
        puts params
        @story=Story.new(story_params)
        if @story.save
            redirect_to @story,flash: {message: "Story is created successfully"}
        else
            redirect_to stories_new_path(@story.epic_id) ,flash: {message:@story.errors.full_messages}
        end
    end

    def edit
        @story=Story.find(params[:id])
    end

    def update
        @story=Story.find(params[:id])
        if @story.update(story_params)
            redirect_to @story,flash: {message: "Story is updated successfully"}
        end
    end

    def destroy
        @story=Story.find(params[:id])
        @story.destroy
        redirect_to stories_path
    end

    private

    def story_params
        params.require(:story).permit(:name,:description,:epic_id)
    end
end