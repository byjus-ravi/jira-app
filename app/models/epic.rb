class Epic < ApplicationRecord
    validates:name, presence:true
    validates:summary, presence:true
    has_many :stories
end
