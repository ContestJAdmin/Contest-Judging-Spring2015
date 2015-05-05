class ContestsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin
  
  def index
    @contests = Contest.all
  end
  
  def show
    id = params[:id]
    @contest = Contest.find(id)
    @categories_projects = {}
    @contest.categories.each do |category|
        @categories_projects[category.id] = Category.find(category.id).projects
    end
  end
  
  def new 
    @contest = Contest.new
  end
  
  def create 
    @contest = Contest.new(contest_params)
    if @contest.save
        flash[:success] = "Successfull"
        redirect_to @contest
    else
        render 'new'
    end
  end
    
  def edit 
    @contest = Contest.find(params[:id])
  end
    
  def update
    @contest = Contest.find(params[:id])
    if @contest.update_attributes(contest_params)
      flash[:success] = "Contest Updated"
      redirect_to @contest
    else
      render 'edit'
    end
  end
    
  def destroy
    Contest.find(params[:id]).destroy
    flash[:success] = "Contest Deleted"
    redirect_to contests_path
  end
    
  def contest_params
    params.require(:contest).permit(:name, :location, :date)
  end
end
