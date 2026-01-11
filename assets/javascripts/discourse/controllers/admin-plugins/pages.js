import Controller from '@ember/controller';
import { action } from '@ember/object';
import { service } from '@ember/service';

export default class AdminPluginsPagesIndexController extends Controller {
	@service toasts;
	@service session;

	@action
	async deletePage(page) {
		if (confirm('Delete this page?')) {
			try {
				const response = await fetch(`/pages-admin/${page.id}`, {
					method: 'DELETE',
					headers: {
						'Accept': 'application/json',
						'X-CSRF-Token': this.session.get('csrfToken')
					}
				});
				if (!response.ok) {
					this.toasts.error('Failed to delete page');
					return;
				}
				this.model.pages.removeObject(page);
				this.toasts.success('Page deleted');
			} catch (error) {
				console.error('Delete error:', error);
				this.toasts.error(error.message || 'An error occurred');
			}
		}
	}
}