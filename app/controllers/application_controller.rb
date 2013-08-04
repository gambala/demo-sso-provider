class ApplicationController < ActionController::Base
	protect_from_forgery

	protected

	def check_authentication
		if !session[:account_id]
			redirect_to auth_path, notice: t('login.purpose')
		end
	end
end
