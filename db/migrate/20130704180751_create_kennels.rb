class CreateKennels < ActiveRecord::Migration
  def change
    create_table :kennels do |t|
      t.string :name
      t.string :location
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
