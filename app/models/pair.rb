class Pair < ApplicationRecord
  belongs_to :user
  belongs_to :partner, foreign_key: :partner_id, class_name: 'User'
end
