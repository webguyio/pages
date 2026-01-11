import Controller from '@ember/controller';
import { action } from '@ember/object';
import { service } from '@ember/service';

export default class AdminPluginsPagesEditController extends Controller {
	@service router;
	@service toasts;
	@service session;

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
			const response = await fetch(`/pages-admin/${this.model.id}`, {
				method: 'PUT',
				headers: {
					'Content-Type': 'application/json',
					'X-CSRF-Token': this.session.get('csrfToken')
				},
				body: JSON.stringify(data)
			});
			if (!response.ok) {
				let errorMessage = 'Failed to update page';
				try {
					const error = await response.json();
					if (error.errors?.length) {
						errorMessage = error.errors.join(', ');
					}
				} catch (parseError) {
					errorMessage = `Server error: ${response.status} ${response.statusText}`;
				}
				this.toasts.error(errorMessage);
				return;
			}
			await response.json();
			this.toasts.success('Page updated');
			this.router.transitionTo('adminPlugins.pages');
		} catch (error) {
			console.error('Save error:', error);
			this.toasts.error(error.message || 'An error occurred');
		}
	}

	@action
	cancel() {
		this.router.transitionTo('adminPlugins.pages');
	}
}