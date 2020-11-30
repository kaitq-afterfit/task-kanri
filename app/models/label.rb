class Label < ApplicationRecord
  has_and_belongs_to_many :tasks

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 140 }
end
