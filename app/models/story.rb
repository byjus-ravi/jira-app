class Story < ApplicationRecord
    validates:name,presence:true
    validates:description,presence:true
    belongs_to :epic
    has_many :subtasks
end
