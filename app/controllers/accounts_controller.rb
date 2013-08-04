class AccountsController < ApplicationController
	before_filter :check_authentication

	def index
		@account = Account.find(session[:account_id])
	end

	def update
		@account = Account.find(session[:account_id])

		# if @account.update_attributes(params[:account])
		# 	format.html { redirect_to account_path, notice: 'Application was successfully updated.' }
		# else
		# 	format.html { render action: "index" }
		# end
	end

	protected

	def check_authentication
		if !session[:account_id]
			redirect_to login_path, notice: t('login.purpose')
		end
	end
end
