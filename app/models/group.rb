class Group < ApplicationRecord
  has_many :events, dependent: :destroy
  validates_presence_of :name, :created_by
end
