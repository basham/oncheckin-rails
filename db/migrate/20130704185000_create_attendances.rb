class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.belongs_to :hasher
      t.belongs_to :event

      t.string :tags

      t.timestamps
    end

    add_index :attendances, :hasher_id
    add_index :attendances, :event_id
  end
end
