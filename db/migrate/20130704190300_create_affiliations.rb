class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
      t.belongs_to :hasher
      t.belongs_to :kennel
      
      t.integer :recorded_attendance_count
      t.integer :recorded_hare_count
      t.date :recorded_since

      t.integer :unrecorded_attendance_count
      t.integer :unrecorded_hare_count

      t.integer :attendance_count
      t.integer :hare_count

      t.timestamps
    end

    add_index :affiliations, :hasher_id
    add_index :affiliations, :kennel_id
  end
end
