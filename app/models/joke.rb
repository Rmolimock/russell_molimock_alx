class Joke < ApplicationRecord
    validates :content, presence: true
    validates :source, presence: true
  end
  