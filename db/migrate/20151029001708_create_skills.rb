class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.text :name
      t.text :description

      t.timestamps null: false
    end
  end
end
