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
		application = Application.where(uid: params[:client_id], secret: params[:client_secret]).first
		if application.nil?
			render json: {error: t('application.wrong_params')}
			return
		end

		grant = Grant.where(code: params[:code], application_id: application.id).first
		if grant.nil?
			render json: {error: t('grant.wrong_params')}
			return
		end

		render json: {
			access_token: grant.access_token,
			refresh_token: grant.refresh_token,
			expires_in: grant.access_token_expires_at.to_i
		}
	end
end