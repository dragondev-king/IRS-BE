class Recipient < ApplicationRecord
    has_many :filings, class_name: "filing", foreign_key: "reference_id"
end
