class Joke < ApplicationRecord
    validates :content, presence: true
    validates :source, presence: true
  
    has_and_belongs_to_many :standup_sets
  end
