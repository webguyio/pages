# frozen_string_literal: true

class Page < ActiveRecord::Base
	self.table_name = 'pages'

	belongs_to :user

	validates :title, presence: true, length: { maximum: 255 }
	validates :slug, presence: true, length: { maximum: 255 },
		format: { with: /\A[a-z0-9\-]+\z/ },
		uniqueness: true
	validates :content, presence: true
	validates :meta_title, length: { maximum: 255 }, allow_blank: true
	validates :meta_description, length: { maximum: 500 }, allow_blank: true

	before_validation :generate_slug, on: :create

	RESERVED_SLUGS = %w[
		admin categories latest new unread top tags users badges
		login signup about faq privacy tos guidelines
		my u g c t search uploads posts notification-alert
		session email user-api-key finish-installation invites
	].freeze

	validate :slug_not_reserved

	private

	def generate_slug
		return if slug.present?
		self.slug = title.parameterize[0..254]
	end

	def slug_not_reserved
		if slug.present? && RESERVED_SLUGS.include?(slug)
			errors.add(:slug, 'is reserved and cannot be used')
		end
	end
end