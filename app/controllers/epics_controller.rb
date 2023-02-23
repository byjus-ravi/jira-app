class EpicsController<ApplicationController

    before_action :authenticate_user! , only: [:new, :show, :create, :edit, :update, :destroy]

    def search
        @item=params[:filter]
        if @item=="Epics"
        @epics=Epic.find_by_sql("select * from epics where name like '%#{params[:search]}%'")
        elsif @item=="Stories"
        @stories=Story.find_by_sql("select * from stories where name like '%#{params[:search]}%'")
        elsif @item=="Subtasks"
        @subtasks=Subtask.find_by_sql("select * from subtasks where name like '%#{params[:search]}%'")
        else
            @epics=Epic.find_by_sql("select * from epics where name like '%#{params[:search]}%'")
            @stories=Story.find_by_sql("select * from stories where name like '%#{params[:search]}%'")
            @subtasks=Subtask.find_by_sql("select * from subtasks where name like '%#{params[:search]}%'")
        end
    end

    def index
        @epics=Epic.all
    end

    def new
        @epic=Epic.new
    end

    def show
        @epic=Epic.find(params[:id])
    end

    def create
        @epic=Epic.new(epic_params)
        if @epic.save
            redirect_to @epic,flash: {message: "Epic is created successfully"}
        else
            redirect_to new_epic_path, flash: {message:@epic.errors.full_messages}
        end
    end

    def edit
        @epic=Epic.find(params[:id])
    end

    def update
        @epic=Epic.find(params[:id])
        if @epic.update(epic_params)
            redirect_to @epic,flash: {message: "Epic is updated successfully"}
        end
    end

    private

    def epic_params
        params.require(:epic).permit(:name,:summary)
    end

end