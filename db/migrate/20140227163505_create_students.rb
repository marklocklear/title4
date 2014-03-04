class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
			t.integer :person_id
			t.string :first_name
			t.string :last_name
			t.string :start_date
			t.string :end_date
			t.string :last_attend_date
      t.timestamps
    end
  end
end