class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments
  has_many :subtasks
  has_many :owned_tasks,    class_name: "Subtask", foreign_key: "reporter_id"
  has_many :assigned_tasks, class_name: "Subtask", foreign_key: "assignee_id"
end
