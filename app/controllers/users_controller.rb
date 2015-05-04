class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
  #  @users = User.all
    @users= User.judges.where(:contest_id => nil)
  end

  def show
    @user = User.find(params[:id])
    @projects = @user.category ? @user.category.projects : []
    unless @user == current_user || current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @contests = Contest.all
    @categories = Category.all
    @categories_for_dropdown = []
    @categories_for_dropdown = @categories_for_dropdown << ["No Category", nil, {:id => 'nil_option'}]
    @categories.each do |category|
      @categories_for_dropdown = @categories_for_dropdown << [category.name, category.id, {:class => category.contest_id}]
    end
  end
  
  def update
    params[:user] ||= {}
    params[:user][:project_ids] ||= []
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user].permit!)
      flash[:notice] = 'Update successful'
      if !(params[:user][:project_ids] == [])
        redirect_to user_path(@user)
      else
        redirect_to contest_path(params[:user][:contest_id], :expand_judges => true)
      end
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
