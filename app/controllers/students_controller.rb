class StudentsController < ApplicationController
  def index
    @students = Student.all
		if session[:break_from_date] != "" && session[:break_to_date] != ""
			@break_from_date = session[:break_from_date]
			@break_to_date = session[:break_to_date]
			break_from_date = Date.strptime(session[:break_from_date],'%Y-%m-%d')
			break_to_date = Date.strptime(session[:break_to_date],'%Y-%m-%d')
			@total_days = break_to_date - break_from_date + 1
		end
    respond_to do |format|
      format.html
      format.csv { send_data @products.to_csv }
      #format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end
  end

  def import
    Student.import(params[:file], params[:break_from_date], params[:break_to_date])
		session[:break_from_date] = params[:break_from_date]
		session[:break_to_date] = params[:break_to_date]
    redirect_to root_url, notice: "Students imported."
  end
end
