class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :kennel

      t.string :name
      t.datetime :start_time
      t.text :description
      t.text :notes

      t.timestamps
    end

    add_index :events, :kennel_id
  end
end
