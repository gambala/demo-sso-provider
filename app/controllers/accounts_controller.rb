class AccountsController < ApplicationController
	before_filter :check_authentication

	def index
		@account = Account.find(session[:account_id])
	end

	protected

	def check_authentication
		if !session[:account_id]
			redirect_to login_path, notice: t('login.purpose')
		end
	end
end
