class Topic < ApplicationRecord
  validates_presence_of :title

  belongs_to :user
  has_many :flashcards, dependent: :destroy
  accepts_nested_attributes_for :flashcards, allow_destroy: true
end
