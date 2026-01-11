# frozen_string_literal: true

module Pages
	class PagesController < ::ApplicationController
		requires_plugin 'pages'
		skip_before_action :check_xhr, :preload_json, only: [:show]

		def show
			page = Page.find_by!(slug: params[:slug], enabled: true)

			respond_to do |format|
				format.html do
					@title = page.meta_title.presence || page.title
					@description = page.meta_description
					@content = page.content.html_safe
					if page.themed
						render 'pages/show', layout: 'application'
					else
						render html: @content.html_safe, layout: false
					end
				end
				format.json { render json: PageSerializer.new(page) }
			end
		rescue ActiveRecord::RecordNotFound
			raise Discourse::NotFound
		end
	end
end