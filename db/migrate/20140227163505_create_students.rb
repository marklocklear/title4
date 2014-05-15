class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
			t.integer :person_id
			t.string :first_name
			t.string :last_name
			t.string :start_date
			t.string :end_date
			t.string :last_attend_date
			t.string :total_days
			t.string :days_attended
			t.string :total_days_minus_break
			t.string :total_attended_minus_break
      t.timestamps
    end
  end
end
