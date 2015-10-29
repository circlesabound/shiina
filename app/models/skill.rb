class Skill < ActiveRecord::Base
  has_many :weightings
  has_many :keywords, :through => :weightings
end
