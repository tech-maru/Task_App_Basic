class Task < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :note, presence: true
end
