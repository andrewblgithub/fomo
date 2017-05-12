class Event < ApplicationRecord
  belongs_to :group
  validates_presence_of :title, :description, :created_by, :expires_at
end
