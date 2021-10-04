class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :code
      t.string :name
      t.string :description
      t.boolean :independent_study
      t.json :requirements

      t.timestamps
    end
    create_join_table :subjects, :courses
  end
end
