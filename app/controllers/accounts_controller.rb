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

	def authorize
		if params[:client_id].nil? ||
				params[:redirect_uri].nil? ||
				params[:state].nil? ||
				params[:response_type].nil? ||
				session['omniauth.params'].nil? ||
				session['omniauth.origin'].nil? ||
				session['omniauth.state'].nil?

			redirect_to root_path, flash: {error: t('account.no_omniauth_params')}
		else
			session[:auth_params] = {
				client_id: params[:client_id],
				redirect_uri: params[:redirect_uri],
				state: params[:state],
				response_type: params[:response_type],
				'omniauth.params' => session['omniauth.params'],
				'omniauth.origin' => session['omniauth.origin'],
				'omniauth.state' => session['omniauth.state']
			}
			redirect_to account_path
		end
	end

	protected

	def check_grant
		if session[:auth_params]
			application = Application.where(uid: session[:auth_params][:client_id]).first
			if !application
				render text: t('application.wrong_id')
			else
				# if Account.find(session[:account_id]).check_grant session[:auth_params]
					render text: 'Yes grant'
				# else
					# render text: 'No grant'
				# end
			end
		end
	end
end
