class QuestionTypesController < ApplicationController
    before_filter :authenticate_user!
    before_filter :has_contest
    
    protected
    def has_contest
        unless(@contest = Contest.find(params[:contest_id]))
            flash[:error] = "QuestionType must be for an existing contest"
            redirect_to contests_path
        end
    end
    
    public
    def index
        @question_types = QuestionType.all
    end
    
    def show
        id = params[:id]
        @question_type = QuestionType.find(id)
    end
    
    def new 
        @question_type = @contest.question_types.build
    end
    
    def create 
        @question_type = @contest.question_types.build(question_type_params)
        if @question_type.save
            flash[:success] = "Successful"
            redirect_to contest_path(@contest)
        else
            render 'contests/index'
        end
    end
    
    def edit 
        @question_type = QuestionType.find(params[:id])
    end
    
    def update
        @question_type = QuestionType.find(params[:id])
        if @question_type.update_attributes(question_type_params)
            flash[:success] = "QuestionType Updated"
            redirect_to @question_type
        else
            render 'edit'
        end
    end
    
    def destroy
        QuestionType.find(params[:id]).destroy
        flash[:success] = "Question Type Deleted"
        redirect_to question_types_path
    end
    
    def question_type_params
        params.require(:question_type).permit(:question_type, :contest_id)
    end
end
