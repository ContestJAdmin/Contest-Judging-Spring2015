class QuestionType < ActiveRecord::Base
    def question_type_params
        params.require(:question_type).permit(:question_type, :contest_id)
    end
    
    belongs_to :contest
    has_many :questions, :dependent => :destroy
    
    validates :question_type, :presence => true, :length => {:maximum => 50}
    validates :contest_id, :presence => true
    
end


