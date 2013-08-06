class GrantsController < ApplicationController
	before_filter :check_authentication, except: :token
	skip_before_filter :verify_authenticity_token, only: :token

	def show
		@account = Account.find(session[:account_id])
		@grant = @account.grants.find(params[:id])
	end

	def destroy
		account = Account.find(session[:account_id])
		grant = account.grants.find(params[:id])
		grant.destroy

		redirect_to account_path, notice: t('grant.denied_full')
	end

	def token
		# if !session[:account_id]
			# render :json => {:error => "User is not signed in"}
		# else
    		application = Application.where(uid: params[:client_id], secret: params[:client_secret])
    		if !application
				render :json => {:error => "Could not find application"}
			else
				render :json => {:error => "All ok"}
			end
		# end
	end
end
