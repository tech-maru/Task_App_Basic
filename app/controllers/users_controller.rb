class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update, :destroy]
  before_action :logged_in_user, only:[:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only:[:show, :edit, :update]
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
    @user = User.find(3)
    log_in(@user) && current_user?(@user)
    redirect_to user_url(@user)
  end
    
  def guest_admin
    @user = User.find(2)
    log_in(@user)
    redirect_to user_url(@user)
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    # before_action
    
    def set_user
      @user = User.find(params[:id])
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
    
end
