class AttachmentsController < ApplicationController
  before_filter :authenticate_user!
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
  end

  def create
    if params[:attachment].blank?
      flash[:error] = "There was no attachment."
      redirect_to new_contest_attachment_path(@contest)
      return
    end
    
    if upload_file_and_process(@contest, params)
      flash[:success] = "File upload successful"
      redirect_to contest_path(@contest)
    else
      redirect_to new_contest_attachment_path(@contest)
    end
  end
  
  def upload_file_and_process(contest, params)
    
    projects_for_rollback = []
    incoming_file = params[:attachment][:attachment]
    name =  'test.csv'
    directory = "public/"
    path = File.join(directory, name)
    
    File.open(path, "wb") { |f| f.write(incoming_file.read) }
    
    projects = CSV.open(path, {:headers => true, :encoding => 'ISO-8859-1'})
    projects.each do |row|
      parameters = {"name" => row[0], "location" => row[1]}
      category_name = row[2]
      if !contest.categories.exists?("name"=> category_name)
        if !create_category(contest, category_name)
          rollback(projects_for_rollback)
          flash[:error] = "Something went wrong, please check your project file's categories."
          return false
        end
      end
      parameters["category_id"] = contest.categories.find_by_name(category_name).id
      project = contest.projects.build(parameters)
      if(!project.location_unique?)
        rollback(projects_for_rollback)
        flash[:error] = "Duplicate location assignment detected."
        return false
      end
      if (!project.save)
        rollback(projects_for_rollback)
        flash[:error] = "Something went wrong, please check your project file."
        return false
      end
      projects_for_rollback.push(project)
    end
    return true
  end
    
  def create_category(contest, category_name)
    parameters = {"name" => category_name}
    category = contest.categories.build(parameters)
    if (!category.save)
      return false
    end
    return true
  end
  
  def rollback(projects)
    projects.each do |project|
      project.destroy
    end
  end
  
end
