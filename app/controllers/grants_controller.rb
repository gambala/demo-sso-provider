class GrantsController < ApplicationController
	def show
		@account = Account.find(session[:account_id])
		@grant = @account.grants.find(params[:id])
	end
end
