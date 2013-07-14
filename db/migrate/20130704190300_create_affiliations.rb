class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
      t.belongs_to :participant
      t.belongs_to :chapter
      
      t.integer :recorded_attendance_count
      t.integer :recorded_host_count
      t.date :recorded_since

      t.integer :unrecorded_attendance_count
      t.integer :unrecorded_host_count

      t.integer :attendance_count
      t.integer :host_count

      t.timestamps
    end

    add_index :affiliations, :participant_id
    add_index :affiliations, :chapter_id
  end
end
