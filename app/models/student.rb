class Student < ActiveRecord::Base
	require 'date'
  attr_accessible :person_id, :first_name, :last_name, :start_date, :end_date, :last_attend_date, :total_days,
									:days_attended
	def self.import(file)
		Student.delete_all
		students = Hash.new {|hsh, key| hsh[key] = Hash.new {|inner_hsh, inner_key| inner_hsh[inner_key] = [] } }
		#builds array of students based on person_id
		CSV.foreach(file.tempfile, :headers => true) do |row|
			students[row["person_id"]]["first_name"] << row["first_name"]
			students[row["person_id"]]["last_name"] << row["last_name"]
			students[row["person_id"]]["start_dates"] << Date.strptime(row["start_date"], '%m/%d/%Y')
			students[row["person_id"]]["end_dates"] << Date.strptime(row["end_date"], '%m/%d/%Y')
			if row["last_attend_date"] == nil #if last_attend_date is blank, use end_date
				students[row["person_id"]]["last_attend_dates"] << Date.strptime(row["end_date"], '%m/%d/%Y')
			else
				students[row["person_id"]]["last_attend_dates"] << Date.strptime(row["last_attend_date"], '%m/%d/%Y')
			end
			students[row["person_id"]]["final_grades"] << row["final_grade"]
		end
		
		#loop through each student
		students.each do |s|
			end_dates = s[1]['end_dates']
			final_grades = s[1]['final_grades']
			earliest_start_date = s[1]['start_dates'].min
			latest_end_date = s[1]['end_dates'].max
			latest_last_attend_date = s[1]['last_attend_dates'].max
			total_days = latest_end_date - earliest_start_date
			days_attended = latest_last_attend_date -earliest_start_date
			if get_valid_students(end_dates, final_grades) #only write student to DB if return true from this method
				Student.create! person_id: s[0], first_name: s[1]['first_name'].first, last_name: s[1]['last_name'].first,
												start_date: earliest_start_date, end_date: latest_end_date,
												last_attend_date: latest_last_attend_date, total_days: total_days.to_i.to_s,
												days_attended: days_attended.to_i.to_s
			end
		end
	end

	#this method handles logic for making sure latest_end_dates all have final grades of W, U, F, & R
	#also if there are multiple latest_end_dates that are the same all grades have to be W, U, F, or R
	def self.get_valid_students(end_dates, grades)
		valid_end_dates= Array.new
		valid_grades = Array.new
		max_date = end_dates.max #gets latest end date
		end_dates.each_with_index do |ed, index| #loop through each end_date and see if it matches latest_end_date
			if ed == max_date												#if it does we added the date and its grade to arrays
				valid_end_dates << ed #add this date to valid_end_dates array
				valid_grades << grades[index] #add the grade associated with the end_date above to valid_grades array
			end
		end
		grade_set = ['U','W','F','R'] #only show students if latest_end_date(s) are these grades
		if (valid_grades - grade_set).empty? then return true else return false end
	end
end
