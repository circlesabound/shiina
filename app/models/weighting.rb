class Weighting < ActiveRecord::Base
  belongs_to :keywords
  belongs_to :skills
end
