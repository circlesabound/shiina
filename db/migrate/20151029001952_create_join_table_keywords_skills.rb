class CreateJoinTableKeywordsSkills < ActiveRecord::Migration
  def change
    create_table :weightings do |t|
      t.belongs_to :keyword, index: true
      t.belongs_to :skill, index: true
      t.integer :raw_weighting
    end
  end
end
