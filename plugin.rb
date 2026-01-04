# frozen_string_literal: true
# name: pages
# about: Create custom SEO-friendly pages within Discourse's layout
# version: 0.1
# authors: Web Guy
# url: https://github.com/webguyio/pages
# required_version: 3.1.0

enabled_site_setting :pages_enabled

register_asset 'stylesheets/common.scss'

after_initialize do
	require_relative 'lib/pages/engine'

	module ::Pages
		def self.enabled_slugs
			@enabled_slugs ||= Page.where(enabled: true).pluck(:slug).to_set
		end

		def self.refresh_slugs!
			@enabled_slugs = nil
		end
	end

	Discourse::Application.routes.append do
		get '/admin/plugins/pages' => 'pages/admin#index'
		get '/admin/plugins/pages/list' => 'pages/admin#list'
		get '/admin/plugins/pages/new' => 'pages/admin#new'
		post '/admin/plugins/pages' => 'pages/admin#create'
		get '/admin/plugins/pages/:id/edit' => 'pages/admin#edit'
		put '/admin/plugins/pages/:id' => 'pages/admin#update'
		delete '/admin/plugins/pages/:id' => 'pages/admin#destroy'
		get '/:slug' => 'pages/pages#show', constraints: lambda { |req|
			slug = req.path.sub('/', '')
			Pages.enabled_slugs.include?(slug)
		}
	end

	add_admin_route 'pages.title', 'pages', use_new_show_route: true
end