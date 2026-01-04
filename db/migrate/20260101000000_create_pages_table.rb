# frozen_string_literal: true

class CreatePagesTable < ActiveRecord::Migration[7.0]
	def change
		create_table :pages do |t|
			t.string :title, null: false
			t.string :slug, null: false
			t.text :content, null: false
			t.string :meta_title
			t.text :meta_description
			t.boolean :enabled, default: true, null: false
			t.integer :user_id, null: false
			t.timestamps
		end

		add_index :pages, :slug, unique: true
		add_index :pages, :enabled
		add_index :pages, :user_id
	end
end