class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update, :destroy]
  before_action :admin_user, only:[:index, :destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20).order(admin: :desc)
  end
  
  def show
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = '更新しました。'
      redirect_to user_url(@user)
    else
    render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました"
    redirect_to users_path
  end
  
  def guest_general
    @current_useruser = User.find(3)
    session[:user_id] = @current_user.id
    redirect_to user_url(@user)
  end
    
  def guest_admin
    @current_user = User.find(2)
    session[:user_id] = @current_user.id
    redirect_to user_url(@current_user)
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
end
