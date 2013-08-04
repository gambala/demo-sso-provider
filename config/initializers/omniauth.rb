Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, ENV['FB_API_ID'], ENV['FB_API_SECRET'], display: 'popup'
	provider :vkontakte, ENV['VK_API_ID'], ENV['VK_API_SECRET'], display: 'popup'
	provider :twitter, ENV['TWITTER_API_ID'], ENV['TWITTER_API_SECRET']
	provider :yandex, ENV['YANDEX_API_ID'], ENV['YANDEX_API_SECRET']
	provider :google_oauth2, ENV['GOOGLE_API_ID'], ENV['GOOGLE_API_SECRET'], { :approval_prompt => "auto" }
end
