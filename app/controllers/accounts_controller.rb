#encoding: utf-8
class AccountsController < ApplicationController
	before_filter :check_authentication

	def index
		@account = Account.find(session[:account_id])
	end

	protected

	def check_authentication
		if !session[:account_id]
			redirect_to login_path, notice: 'Вам необходимо войти в систему, используя один из вариантов.'
		end
	end
end
