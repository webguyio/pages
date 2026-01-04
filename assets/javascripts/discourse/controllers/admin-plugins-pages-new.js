import Controller from '@ember/controller';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { getCsrfToken } from 'discourse/lib/ajax';

export default class AdminPluginsPagesNewController extends Controller {
	@service router;
	@service toasts;

	@action
	async save() {
		const data = {
			page: {
				title: this.model.title,
				slug: this.model.slug,
				content: this.model.content,
				meta_title: this.model.meta_title,
				meta_description: this.model.meta_description,
				enabled: this.model.enabled
			}
		};

		try {
			const response = await fetch('/admin/plugins/pages', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json',
					'X-CSRF-Token': getCsrfToken()
				},
				body: JSON.stringify(data)
			});

			if (!response.ok) {
				const error = await response.json();
				this.toasts.error(error.errors?.join(', ') || 'Failed to create page');
				return;
			}

			this.toasts.success('Page created');
			this.router.transitionTo('adminPlugins.pages.index');
		} catch (error) {
			this.toasts.error('An error occurred');
		}
	}

	@action
	cancel() {
		this.router.transitionTo('adminPlugins.pages.index');
	}
}