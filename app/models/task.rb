class Task < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { minimum: 2, maximum: 20}
  validates :note, presence: true, length: {minimum: 5}
end
