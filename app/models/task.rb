class Task < ApplicationRecord
  belongs_to :user
  
  has_and_belongs_to_many :labels

  has_many :assignments, dependent: :destroy
  has_many :assignees, through: :assignments, source: :user

  enum status: { todo: 1, doing: 2, done: 3 }

  ransack_alias :assignee, :assignees_name_or_assignees_email
end
