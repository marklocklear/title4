class StudentsController < ApplicationController
  def index
    @students = Student.all
    respond_to do |format|
      format.html
      format.csv { send_data @products.to_csv }
      #format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end
  end

  def import
    Student.import(params[:file])
    redirect_to root_url, notice: "Students imported."
  end
end
