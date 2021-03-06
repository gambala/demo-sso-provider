class OrdersController < ApplicationController
	def register
		if params[:client_id].nil? ||
				params[:redirect_uri].nil? ||
				params[:state].nil? ||
				params[:response_type].nil?

			redirect_to root_path, flash: {error: t('order.no_omniauth_params')}
		else
			if session['omniauth.state'].nil?
				myUri = URI.parse(params[:redirect_uri])
				session['omniauth.origin'] = params[:redirect_uri][0..myUri.path.length-2]
			end
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
			session.delete('omniauth.params')
			session.delete('omniauth.origin')
			session.delete('omniauth.state')

			redirect_to order_path(params[:client_id])
		end
	end

	def show
		@order = session[:grants_orders][params[:id]]
		if !@order
			redirect_to root_path, flash: {error: t('order.wrong_id')}
		end
		@account = Account.find(session[:account_id]) if session[:account_id]
		@application = Application.find_by_uid(params[:id])
		if @account and @application
			grant = @application.grants.find_by_account_id(@account.id)
			if grant
				if grant.access_token_expires_at < Time.now
					grant.destroy
				else
					accept()
				end
			end
		end
	end

	def accept
		order = session[:grants_orders][params[:id]]
		account = Account.find(session[:account_id]) if session[:account_id]
		application = Application.find_by_uid(params[:id])
		if account and application
			session[:grants_orders].delete(params[:id])
			grant = application.grants.find_by_account_id(account.id)
			if !grant
				grant = application.grants.create({:account_id => account.id}, :without_protection => true)
			end
			if !grant.access_token_expires_at
				grant.start_expiry_period!
			end

			params = {
				client_id: order[:client_id],
				redirect_uri: order[:redirect_uri],
				state: order[:state],
				response_type: order[:response_type],
			}
			session['omniauth.params'] = order['omniauth.params']
			session['omniauth.origin'] = order['omniauth.origin']
			session['omniauth.state'] = order['omniauth.state']

			# нужен code но grant я тут ведь удаляю?
			redirect_to "#{params[:redirect_uri]}?code=#{grant.code}&response_type=code&state=#{params[:state]}"
		end
	end

	def deny
		redirect_uri = session[:grants_orders][params[:id]]['omniauth.origin']
		session[:grants_orders].delete(params[:id])
		redirect_to redirect_uri, flash: {error: t('authentication.error')}
	end
end
