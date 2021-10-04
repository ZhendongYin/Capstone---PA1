class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.string :s_id, index: true
      t.string :name
      t.string :abbreviation

      t.timestamps
    end

  end
end
