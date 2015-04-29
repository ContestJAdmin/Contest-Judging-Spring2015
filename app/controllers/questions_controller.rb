class QuestionsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :has_question_type
    
    protected
    def has_question_type
        unless(@question_type = QuestionType.find(params[:question_type_id]))
            flash[:error] = "Question must be for an existing question_type"
            redirect_to contest_question_type_path(@question_type.contest_id, @question_type)
        end
    end
    
    public
    def index
        @questions = Question.all
    end
    
    def show
        id = params[:id]
        @question = Question.find(id)
    end
    
    def new 
        @question = @question_type.questions.build
    end
    
    def create 
        @question = @question_type.questions.build(question_params)
        if @question.save
            flash[:success] = "Successful"
            redirect_to contest_question_type_path(@question_type.contest_id, @question_type)
        else
            render 'new'
        end
    end
    
    def edit 
        @question = @question_type.questions.find(params[:id])
    end
    
    def update
        @question = @question_type.questions.find(params[:id])
        if @question.update_attributes(question_params)
            flash[:success] = "Question Updated"
            redirect_to contest_question_type_path(@question_type.contest_id, @question_type)
        else
            render 'edit'
        end
    end
    
    def destroy
        @question = @question_type.questions.find(params[:id]).destroy
        flash[:success] = "Question Deleted"
        redirect_to contest_question_type_path(@question_type.contest_id, @question_type)
    end
    
    def question_params
        params.require(:question).permit(:question, :question_types, :question_type_id)
    end
end
