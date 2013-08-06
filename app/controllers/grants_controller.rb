class GrantsController < ApplicationController
	before_filter :check_authentication

	def show
		@account = Account.find(session[:account_id])
		@grant = @account.grants.find(params[:id])
	end

	def destroy
		account = Account.find(session[:account_id])
		grant = account.grants.find(params[:id])
		grant.destroy
		session[:grants_orders] = nil

		redirect_to account_path, notice: t('grant.denied_full')
	end
end
