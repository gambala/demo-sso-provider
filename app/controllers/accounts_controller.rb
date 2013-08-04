class AccountsController < ApplicationController
	before_filter :check_authentication

	def index
		@account = Account.find(session[:account_id])
	end

	protected

	def check_authentication
		if !session[:account_id]
			render text: 'You are not logged in'
			# redirect_to auth_path, notice: 'Вам необходимо войти в систему, используя один из вариантов.'
		end
	end
end
