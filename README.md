# Setup

## Change database.yml

Give databases your own names.




# Changelogs

## Created template

	rails new demo-template-rails --skip-test-unit
	cd demo-template-rails


	git init

Inserted into .gitignore:

	.DS_Store
	*.sublime-project
	*.sublime-workspace


	git add . ; git commit -m "Initial commit"


## Installed sugars

In development.rb:

	config.sass.preferred_syntax = :sass


In config.rb:

	preferred_syntax = :sass
	# CSS output style - :nested, :expanded, :compact, or :compressed
	output_style = :compressed

In gemfile:

	gem 'haml-rails'

	group :assets do
	  gem 'compass-rails'
	end


	bundle