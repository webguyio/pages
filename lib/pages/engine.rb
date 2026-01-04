# frozen_string_literal: true

module Pages
	class Engine < ::Rails::Engine
		engine_name 'pages'
		isolate_namespace Pages
	end
end

require_relative 'page'
require_relative 'page_serializer'
require_relative 'pages_controller'
require_relative 'admin_controller'