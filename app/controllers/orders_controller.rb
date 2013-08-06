class OrdersController < ApplicationController
	def register
		if params[:client_id].nil? ||
				params[:redirect_uri].nil? ||
				params[:state].nil? ||
				params[:response_type].nil? ||
				session['omniauth.params'].nil? ||
				session['omniauth.origin'].nil? ||
				session['omniauth.state'].nil?

			redirect_to root_path, flash: {error: t('order.no_omniauth_params')}
		else
			session[:grants_orders] = Hash.new if !session[:grants_orders]
			session[:grants_orders].merge!(
				params[:client_id] => {
					redirect_uri: params[:redirect_uri],
					state: params[:state],
					response_type: params[:response_type],
					'omniauth.params' => session['omniauth.params'],
					'omniauth.origin' => session['omniauth.origin'],
					'omniauth.state' => session['omniauth.state']
				}
			)
			redirect_to order_path(params[:client_id])
		end
	end

	def show
		@order = session[:grants_orders][params[:id]]
		if !@order
			redirect_to root_path, flash: {error: 'Grant order id parameter error'}
		end
		@account = Account.find(session[:account_id]) if session[:account_id]
		@application = Application.find_by_uid(params[:id])
		if @account and @application
			@grant = @application.grants.find_by_account_id(@account.id)
		end
	end
end
