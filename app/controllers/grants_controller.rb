class GrantsController < ApplicationController
	before_filter :check_authentication

	def show
		@account = Account.find(session[:account_id])
		@grant = @account.grants.find(params[:id])
	end

	def accept
		account = Account.find(session[:account_id])
		grant = account.grants.find(params[:id])

		if grant.update_attributes(accepted: true)
			render text: 'Yes'
		else
			render text: 'No'
		end
	end
end
