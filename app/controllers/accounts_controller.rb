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
		application = Application.find_by_uid(params[:client])
		grant = application.grants.find_by_access_token(params[:access_token])
		data_hash = grant.account.info
		hash = Hash.new
		hash['id'] = grant.account.id
		data_hash.each do |key, value|
			if value.kind_of?(Array)
				hash[key] = value[0]
			else
				hash[key] = value
			end
		end
		render :json => hash.to_json
	end

	private

	def check_grant
		if session[:grants_orders]
			if session[:grants_orders].length == 1
				redirect_to order_path(session[:grants_orders].keys[0])
			end
		end
	end
end
