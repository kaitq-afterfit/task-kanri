class Task < ApplicationRecord
  belongs_to :user
  
  has_and_belongs_to_many :labels

  has_many :assignments, dependent: :destroy
  has_many :assignees, through: :assignments, source: :user

  enum status: { todo: 1, doing: 2, done: 3 }

  validates :name, presence: true
  validates :description, length: { maximum: 255 }
  validates :start_date, presence: true
  validates :due_date, presence: true
  validate :start_end_check
  ransack_alias :assignee, :assignees_name_or_assignees_email

  private

    def start_end_check
      errors.add(:due_date, "を正しく記入してください。") unless
      self.start_date < self.due_date
    end
end
