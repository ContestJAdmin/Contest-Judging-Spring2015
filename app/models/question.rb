class Question < ActiveRecord::Base
    def question_params
        params.require(:question).permit(:question, :question_types, :question_type_id)
    end
    
    belongs_to :question_type
    has_many :score
    
    validates :question, :presence => true, :length => {:maximum => 50}
    validates :question_type_id, :presence => true
end

