class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.integer :author
      
      t.references :book, index: true, foreign_key: true
      t.references :club, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
