# Setup

## Change database.yml

Give databases your own names.

## Install figaro .yml-file

	rails generate figaro:install

If using Heroku for deployment:

	rake figaro:heroku

# Changelogs

## Created template

	rails new demo-template-rails --skip-test-unit
	cd demo-template-rails

Runned:

	git init

Inserted into .gitignore:

	.DS_Store
	*.sublime-project
	*.sublime-workspace

Runned:

	git add . ; git commit -m "Initial commit"


## Installed sugars

Into development.rb:

	config.sass.preferred_syntax = :sass


Into config.rb:

	preferred_syntax = :sass
	# CSS output style - :nested, :expanded, :compact, or :compressed
	output_style = :compressed

Into gemfile:

	gem 'haml-rails'

	group :assets do
	  gem 'compass-rails'
	end

Runned:

	bundle

## Installed Twitter Bootstrap

Into gemfile:

	group :assets do
	  gem 'compass_twitter_bootstrap'
	end

Runned:

	bundle

Into application.html.erb:

	<meta name="viewport" content="width=device-width, initial-scale=1.0">

Created `custom.css.sass`. Filled it with:

	@import "bootstrap"
	@import "bootstrap-responsive"

And insert into application.css (with `*= require_tree .` deleting):

	 *= require 'custom'

## Changed templates and layouts

Deleted standard Rails index template.

Changed application layout into haml:

	!!!
	%html
	  %head
	    %title CmsFromTheFuture
	    = stylesheet_link_tag    "application", :media => "all"
	    = javascript_include_tag "application"
	    = csrf_meta_tags
	    %meta{:content => "width=device-width, initial-scale=1.0", :name => "viewport"}/
	  %body
	    = yield

## Installed figaro gem

	gem "figaro"
	bundle install
	rails generate figaro:install

