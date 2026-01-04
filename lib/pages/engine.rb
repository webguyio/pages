# frozen_string_literal: true

module Pages
	class Engine < ::Rails::Engine
		engine_name 'pages'
		isolate_namespace Pages
	end
end

require_relative '../pages/page'
require_relative '../pages/page_serializer'
require_relative '../pages/pages_controller'
require_relative '../pages/admin_controller'