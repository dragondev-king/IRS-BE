class Filing < ApplicationRecord
  belongs_to :filer
  belongs_to :recipient
  has_many :awards
end
