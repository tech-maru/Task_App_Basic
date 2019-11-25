class TasksController < ApplicationController
   before_action :current_user
   before_action :set_task, only:[:show, :edit, :update, :destroy]
   before_action :logged_in_user
   before_action :correct_tasks_user, only:[:index, :edit]
 
   

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
  end
  
  def edit
    @user = User.find(params[:user_id])
  end
 
  def update
    @user = User.find(params[:user_id])
    if @task.update(tasks_params)
      redirect_to user_task_url(@user, @task)
    else
      flash[:notice] = "" 
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:saccess] = "#{@task.name}を削除しました。"
    redirect_to user_tasks_path(@current_user)
  end

  private
    
    def tasks_params
      params.require(:task).permit(:title, :note)
    end
    
    def set_task
      @task = Task.find(params[:id])
    end
    
    def correct_tasks_user
      @user = User.find(params[:user_id])
      unless  current_user?(@user) && @user
        flash[:danger] = "アクセス権限がありません"
        redirect_to root_url
      end
    end
    
  
end
