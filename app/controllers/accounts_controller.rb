class AccountsController < ApplicationController
	before_filter :check_authentication

	def index
		@account = Account.find(session[:account_id])
	end

	def update
		@account = Account.find(session[:account_id])
		data_hash = Psych.load params[:info]

		if @account.update_attributes(info: data_hash)
			redirect_to account_path, notice: t('account.updated')
		else
			redirect_to account_path, flash: {error: t('account.not_updated')}
		end
	end

	protected

	def check_authentication
		if !session[:account_id]
			redirect_to login_path, notice: t('login.purpose')
		end
	end
end
