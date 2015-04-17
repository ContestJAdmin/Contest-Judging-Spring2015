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
    @attachment = Attachment.new
  end

  def create
    return if params[:attachment].blank?
    puts params.inspect
    @attachment = Attachment.new
    @attachment.uploaded_file(@contest, params)

    if @attachment.save
        flash[:success] = "File upload successful"
        redirect_to contest_path(@contest)
    else
        flash[:error] = "There was a problem submitting your attachment."
        render contest_path(@contest)
    end
  end
  
  def create_category(contest, category_name)
    @category = @contest.categories.build
    @category.name = category_name
    @category.save
  end
end
