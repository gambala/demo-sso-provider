#encoding: utf-8
class AuthenticationsController < ApplicationController
	def login
		@unlinkedProviders = ['facebook', 'vkontakte', 'twitter', 'yandex', 'google_oauth2']
	end
	def logout
		session[:account_id] = nil
		redirect_to root_path, success: "Вы успешно вышли из системы"
	end
	def callback
	end
	def failure
		redirect_to login_path, error: "Извините, но на стороне сервиса произошла непредвиденная ошибка. Попробуйте использовать другой сервис."
	end
end
