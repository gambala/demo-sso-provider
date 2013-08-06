class AccountsController < ApplicationController
	before_filter :check_authentication, except: :get
	before_filter :check_grant, only: [:index]
	skip_before_filter :verify_authenticity_token, only: :get

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

	def get
		hash = {
			session: session
			# provider: 'josh_id',
			# :id => current_user.id.to_s,
			# :info => {
			# 	:email => current_user.email,
			# },
			# :extra => {
			# 	:first_name => current_user.first_name,
			# 	:last_name  => current_user.last_name
			# }
		}

		render :json => hash.to_json
	end

	private

	def check_grant
		if session[:grants_orders]
			if session[:grants_orders].length == 1
				# redirect_to order_path(session[:grants_orders].keys[0])
			end
		end
	end
end
