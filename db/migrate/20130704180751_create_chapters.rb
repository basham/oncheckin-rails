class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :location
      t.string :timezone
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
