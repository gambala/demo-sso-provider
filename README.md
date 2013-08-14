# Setup

- Clone and run this app with `rails s -p 3000`
- Clone [demo-sso-client](https://github.com/gambala/demo-sso-client) repo
- In provider:
	- Log in
	- Create application with redirect_uri `localhost:4000/auth/accounts/callback`
	- Get application id and secret
- In client:
	- Generate figaro ENV variables file with `rails generate figaro:install`
	- Input id and secret keys (`ACCOUNTS_API_ID` and `ACCOUNTS_API_SECRET` values)
	- Input site_url if you run site locally or on your own server
	- Run app with `rails s -p 4000`

### omniauth.rb init example

	provider :accounts, ENV['ACCOUNTS_API_ID'], ENV['ACCOUNTS_API_SECRET'],
		client_options: {
			site: ENV['ACCOUNTS_API_SITE']
		}
