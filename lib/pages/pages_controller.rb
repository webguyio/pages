# frozen_string_literal: true

module Pages
	class PagesController < ::ApplicationController
		requires_plugin 'pages'
		skip_before_action :check_xhr, :preload_json, only: [:show]

		def show
			page = Page.find_by!(slug: params[:slug], enabled: true)

			respond_to do |format|
				format.html do
					@page_title = page.meta_title.presence || page.title
					@page_description = page.meta_description
					render html: view_context.content_tag(:div, page.content.html_safe, class: 'custom-page-content')
				end
				format.json { render json: PageSerializer.new(page) }
			end
		rescue ActiveRecord::RecordNotFound
			raise Discourse::NotFound
		end
	end
end