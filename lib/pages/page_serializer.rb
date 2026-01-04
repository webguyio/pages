# frozen_string_literal: true

class PageSerializer < ApplicationSerializer
	attributes :id, :title, :slug, :content, :meta_title, :meta_description, :enabled, :created_at, :updated_at
end