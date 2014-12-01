class Vote < ActiveRecord::Base
  belongs_to :user
  has_many :propositions

  validates_presence_of :user_id, :proposition_id
end