class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :chapter

      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.text :description
      t.text :notes

      t.timestamps
    end

    add_index :events, :chapter_id
  end
end
