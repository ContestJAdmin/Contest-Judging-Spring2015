class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
  #  @users = User.all
    @users= User.where('id > 1')
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user || current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    params[:user][:project_ids] ||= []
    @user = User.find(params[:id])
     if @user.update_attributes(params[:user].permit!)
      flash[:notice] = 'updated success'
      redirect_to :action =>'index',:id =>@user
    else
      render :action=>'show'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Judge Account Deleted"
    redirect_to :action => 'index'
  end

private
  
def user_params 
  params.require(:user).permit!
end
  
end
