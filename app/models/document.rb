class Document < ApplicationRecord
  belongs_to :user

  validates :content, length: { minimum: 200 }
end
