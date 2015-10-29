class Keyword < ActiveRecord::Base
  has_many :weightings
  has_many :skills, :through => :weightings
end
