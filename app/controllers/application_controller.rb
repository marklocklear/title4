class ApplicationController < ActionController::Base
  protect_from_forgery
	before_filter :authenticate
  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      username == 'admin' && password == 'abtech'
    end
  end
end
