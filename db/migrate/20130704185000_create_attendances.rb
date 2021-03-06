class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.belongs_to :participant
      t.belongs_to :event

      t.string :tags

      t.timestamps
    end

    add_index :attendances, :participant_id
    add_index :attendances, :event_id
  end
end
