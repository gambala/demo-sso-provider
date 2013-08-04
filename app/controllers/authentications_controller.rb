class AuthenticationsController < ApplicationController
	def login
		@unlinkedProviders = ['facebook', 'vkontakte', 'twitter', 'yandex', 'google_oauth2']
	end
	def logout
		session[:account_id] = nil
		redirect_to login_path, flash: {success: t('logout.success')}
	end
	def callback
	end
	def failure
		redirect_to login_path, flash: {error: t('login.failure')}
	end
end
