# frozen_string_literal: true

module Pages
	class Engine < ::Rails::Engine
		engine_name 'pages'
		isolate_namespace Pages
	end
end

Pages::Engine.routes.draw do
	get '/' => 'admin#index'
	get '/list' => 'admin#list'
	get '/new' => 'admin#new'
	post '/' => 'admin#create'
	get '/:id/edit' => 'admin#edit'
	put '/:id' => 'admin#update'
	delete '/:id' => 'admin#destroy'
end

require_relative 'page'
require_relative 'page_serializer'
require_relative 'pages_controller'
require_relative 'admin_controller'