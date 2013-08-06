class GrantsController < ApplicationController
	before_filter :check_authentication

	def order
		@account = Account.find(session[:account_id])
		@grant_order = session[:grants_orders][params[:order_id]]
		if !@grant_order
			redirect_to account_path, flash: {error: 'Grant order id parameter error'}
		end
	end

	def show
		@account = Account.find(session[:account_id])
		@grant = @account.grants.find(params[:id])
	end

	def create
		# grant = application.grants.create({:account_id => session[:account_id]}, :without_protection => true)
	end

	def accept
		account = Account.find(session[:account_id])
		grant = account.grants.find(params[:id])

		if grant.update_attributes(accepted: true)
			render text: 'Yes'
		    # redirect_to access_grant.redirect_uri_for(params[:redirect_uri])
		else
			redirect_to grant_path(grant), notice: t('grant.accept_error')
		end
	end

	def destroy
		account = Account.find(session[:account_id])
		grant = account.grants.find(params[:id])
		grant.destroy
		session[:grants_orders] = nil

		redirect_to account_path, notice: t('grant.denied_full')
	end
end
