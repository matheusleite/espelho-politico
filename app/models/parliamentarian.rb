class Parliamentarian < ActiveRecord::Base
  has_many :propositions
  validates :id, presence: true, length: {maximum: 11}

  def self.search(search)
    if search
# :nocov:
      where(['name LIKE ?', "%#{search}%"])
# :nocov:    
    else
      take(600)
    end
  end
end
