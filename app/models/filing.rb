class Filing < ApplicationRecord
  belongs_to :filer
  belongs_to :recipient
  has_many :awards, class_name: "award", foreign_key: "reference_id"
end
