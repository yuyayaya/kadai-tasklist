class TasksController < ApplicationController
     before_action :require_user_logged_in
     before_action :correct_user, only:[:edit, :destroy, :show, :update]
     
    def index
      if logged_in?
        @task = Task.all
        @tasks = current_user.tasks.order(id: :desc)
      else
          redirect_to sessions_new_path
      end
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        @task = Task.new
    end
        
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = "新規タスクが作成されました"
            redirect_to @task
        else
            @tasks = current_user.tasks.order(id: :desc)
            flash.now[:dneger] = "新規タスクが作成できませんでした"
            render :new
        end
    end
        
    def edit
        @task = Task.find(params[:id])
    end
            
    def update 
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
           flash[:success] = "タスクを編集しました"
           redirect_to @task
        else
           flash[:denger] = "タスクが編集できませんでした"
           render :new
        end
       
    end
                
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = "タスクが削除されました"
        redirect_to tasks_url
    end
    
    private
    
    def task_params
        params.require(:task).permit(:content, :status,)
    end
    
    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
      redirect_to root_path
      end
    end
end
