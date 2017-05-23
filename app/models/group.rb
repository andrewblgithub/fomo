class Group < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :chats, dependent: :destroy
  validates_presence_of :name, :created_by
end
