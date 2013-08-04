class AuthenticationsController < ApplicationController
	def login
		@unlinkedProviders = ['facebook', 'vkontakte', 'twitter', 'yandex', 'google_oauth2']
	end
	def logout
		session[:account_id] = nil
		redirect_to login_path, flash: {success: t('logout.success')}
	end
	def callback
		auth_hash = request.env['omniauth.auth']
		data_hash = get_data_hash auth_hash
		render json: data_hash
	end
	def failure
		redirect_to login_path, flash: {error: t('login.failure')}
	end

	private

	def get_data_hash auth_hash
		data_hash = Hash.new

		case auth_hash["provider"]
		when 'facebook'
			data_hash['email'] = auth_hash['info']['email']
			data_hash['name'] = auth_hash['info']['name']
			data_hash['nickname'] = auth_hash['info']['nickname']
			data_hash['first_name'] = auth_hash['info']['first_name']
			data_hash['last_name'] = auth_hash['info']['last_name']
			data_hash['image'] = auth_hash['info']['image']
			data_hash['urls'] = {'Facebook' => auth_hash['info']['urls']['Facebook']}
			data_hash['location'] = auth_hash['info']['location']
			data_hash['sex'] = auth_hash['extra']['raw_info']['gender']
		when 'vkontakte'
			data_hash['name'] = auth_hash['info']['name']
			data_hash['nickname'] = auth_hash['info']['nickname']
			data_hash['first_name'] = auth_hash['info']['first_name']
			data_hash['last_name'] = auth_hash['info']['last_name']
			data_hash['born_date'] = auth_hash['extra']['raw_info']['bdate']
			data_hash['image'] = auth_hash['extra']['raw_info']['photo_big']
			data_hash['urls'] = {'Vkontakte' => auth_hash['info']['urls']['Vkontakte']}
			data_hash['location'] = auth_hash['info']['location']
		when 'twitter'
			data_hash['name'] = auth_hash['info']['name']
			data_hash['nickname'] = auth_hash['info']['nickname']
			data_hash['image'] = auth_hash['info']['image']
			data_hash['location'] = auth_hash['info']['location']
			data_hash['urls'] = {'Website' => auth_hash['info']['urls']['Website'], 'Twitter' => auth_hash['info']['urls']['Twitter']}
			data_hash['about'] = auth_hash['info']['description']
		when 'yandex'
			data_hash['email'] = auth_hash['info']['email']
			data_hash['name'] = auth_hash['info']['name']
			data_hash['nickname'] = auth_hash['info']['nickname']
			data_hash['born_date'] = auth_hash['extra']['raw_info']['birthday']
			data_hash['sex'] = auth_hash['extra']['raw_info']['sex']
		when 'google_oauth2'
			data_hash['email'] = auth_hash['info']['email']
			data_hash['name'] = auth_hash['info']['name']
			data_hash['first_name'] = auth_hash['info']['first_name']
			data_hash['last_name'] = auth_hash['info']['last_name']
			data_hash['image'] = auth_hash['info']['image']
			data_hash['urls'] = {'Google Plus' => auth_hash['extra']['raw_info']['link']}
			data_hash['born_date'] = auth_hash['extra']['raw_info']['birthday']
			data_hash['sex'] = auth_hash['extra']['raw_info']['gender']
		else
			data_hash = auth_hash['info']
		end
		return data_hash
	end
end
