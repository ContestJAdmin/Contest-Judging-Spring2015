class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin
  before_filter :has_contest

  protected
  def has_contest
    unless (@contest = Contest.find(params[:contest_id]))
      flash[:error] = 'Category must be for an existing contest'
      redirect_to contests_path
    end
  end    
  
  public
  def new
    @category = @contest.categories.build
  end
  
  def create
    @category = @contest.categories.build(category_params)
    if @category.save
      flash[:success] = 'Category created'
      redirect_to contest_path(@contest)
    else
      render 'contests/index'
    end
  end
  
  def edit
    @category = @contest.categories.find(params[:id])
  end
  
  def show
     @category = @contest.categories.find(params[:id])
     @projects = @contest.projects.where(category_id: @category.id)
     @projects_unassgined =  @contest.projects.where(category_id: nil)
  end

  def update
    @category = @contest.categories.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Category Updated"
      redirect_to contest_path(@contest)
    else
      render 'categories/edit'
    end
  end
  
  def attach
    puts params[:unassigned][:project_ids].inspect
    params[:unassigned][:project_ids].each do |id|
      project = @contest.projects.find(id)
      project.category_id = params[:id]
      project.save
    end
    @category = @contest.categories.find(params[:id])
    @projects = @contest.projects.where(category_id: @category.id)
    @projects_unassgined =  @contest.projects.where(category_id: nil)
    render 'categories/show'
  end
  
  def unattach
    puts params[:assigned][:project_ids].inspect
    params[:assigned][:project_ids].each do |id|
        project = @contest.projects.find(id)
        project.category_id = nil
        project.save
    end
    @category = @contest.categories.find(params[:id])
    @projects = @contest.projects.where(category_id: @category.id)
    @projects_unassgined =  @contest.projects.where(category_id: nil)
    render 'categories/show'
  end
  
  def destroy
    @category = @contest.categories.find(params[:id])
    @category.destroy
    redirect_to contest_path(@contest)
  end
  
  def category_params
    params.require(:category).permit(:name)
  end
end
