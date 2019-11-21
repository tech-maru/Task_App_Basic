class TasksController < ApplicationController
   before_action :current_user

  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks.all
  end
  
  def new
    @task = Task.new
    # これは、createアクションでstrongparameterを使用する際に、ルートキーがないと跳ねられるので、記載しておく
  end
  
  def create
    @user = User.find(params[:user_id])
    @task = @user.tasks.new(tasks_params)
    if @task.save
      flash[:success] = "新しいタスクを登録しました。"
      redirect_to user_tasks_url(@current_user)
    else
      render :new
    end
  end
  
  def show
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:user_id])
    @task  = Task.find(params[:id])
  end
 
  def update
    @user = User.find(params[:user_id])
    @task  = Task.find(params[:id])
    @task.update(tasks_params)
    redirect_to user_task_url(@user, @task)
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to user_tasks_path(@current_user)
  end

  private
    
    def tasks_params
      params.require(:task).permit(:title, :note)
    end
    
    
end
