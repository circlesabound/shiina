class CreateJoinTableKeywordsSkills < ActiveRecord::Migration
  def change
    create_join_table :keywords, :skills do |t|
      t.index [:keyword_id, :skill_id]
      t.integer :raw_weighting
    end
  end
end
