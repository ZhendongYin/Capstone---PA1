class CreateSegments < ActiveRecord::Migration[6.1]
  def change
    create_table :segments do |t|
      t.string :name

      t.timestamps
    end
    create_join_table :subjects, :segments
  end
end
