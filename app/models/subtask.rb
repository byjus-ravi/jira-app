class Subtask < ApplicationRecord
    belongs_to :story
    has_many :comments
    belongs_to :user
    enum :status , { open: 0, inprogress: 1, fixed: 2 , rejected: 3, verified: 4}
    belongs_to :reporter,    class_name: "User"
    belongs_to :assignee, class_name: "User"

    VALID_STATE_TRANSITIONS = Set[ %i(open inprogress), %i(inprogress fixed), %i(fixed verified) ,%i(inprogress rejected), %i(rejected fixed)].freeze
    validate :valid_state_transition? , if: :status_changed?

    private 

    def valid_state_transition?
        x=false
        if status_was.nil?
            x=true
        end
        if x==false
        x=VALID_STATE_TRANSITIONS.include? [status_was.to_sym, status.to_sym]
        end
        if x==false
            errors.add(:state," transition not possible")
        end
    end
end
