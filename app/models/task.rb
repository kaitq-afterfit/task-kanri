class Task < ApplicationRecord
  belongs_to :user
  
  has_and_belongs_to_many :labels

  has_many :assignments
  has_many :assignees, through: :assignments, source: :user
end
