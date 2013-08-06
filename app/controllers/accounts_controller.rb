class AccountsController < ApplicationController
	before_filter :check_authentication, except: [:authorize]
	before_filter :check_grant, only: [:index]

	def index
		@account = Account.find(session[:account_id])
	end

	def edit
		@account = Account.find(session[:account_id])
	end

	def update
		@account = Account.find(session[:account_id])
		# Checked hidden field and select, from what field save info
		if params[:update_from_json] == 'true'
			data_hash = JSON.parse(params[:info_json])
		else
			data_hash = Psych.load params[:info]
		end

		if @account.update_attributes(info: data_hash)
			redirect_to account_path, notice: t('account.updated')
		else
			redirect_to account_path, flash: {error: t('account.not_updated')}
		end
	end

	protected

	def check_grant
		if session[:grants_orders]
			application = Application.find_by_uid(session[:grants_orders][:client_id])
			if !application
				flash[:notice] = t('application.wrong_id')
			else
				grant = application.grants.find_by_account_id(session[:account_id])
				if !grant
					grant = application.grants.create({:account_id => session[:account_id]}, :without_protection => true)
					flash[:notice] = 'No grant'
				else
					flash[:notice] = grant.access_token_expires_at.to_s
				end
			end
		end
	end
end
