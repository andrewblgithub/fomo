class Message < ApplicationRecord
  belongs_to :group
  validates_presence_of :content, :created_by
end
