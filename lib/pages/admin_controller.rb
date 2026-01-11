# frozen_string_literal: true

module Pages
	class AdminController < ::Admin::AdminController
		requires_plugin 'pages'

		def index
			render json: success_json
		end

		def list
			pages = Page.order(created_at: :desc)
			render json: { pages: serialize_data(pages, PageSerializer) }
		end

		def new
			render json: success_json
		end

		def create
			page = Page.new(page_params)
			page.user_id = current_user.id

			if page.save
				Pages.refresh_slugs!
				render json: PageSerializer.new(page).as_json
			else
				render json: { errors: page.errors.full_messages }, status: :unprocessable_entity
			end
		end

		def edit
			page = Page.find(params[:id])
			render json: PageSerializer.new(page).as_json
		end

		def update
			page = Page.find(params[:id])

			if page.update(page_params)
				Pages.refresh_slugs!
				render json: PageSerializer.new(page).as_json
			else
				render json: { errors: page.errors.full_messages }, status: :unprocessable_entity
			end
		end

		def destroy
			page = Page.find(params[:id])
			page.destroy
			Pages.refresh_slugs!
			render json: success_json
		end

		private

		def page_params
			params.require(:page).permit(:title, :slug, :content, :meta_title, :meta_description, :enabled, :themed)
		end
	end
end