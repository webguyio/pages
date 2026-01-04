import Controller from '@ember/controller';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { getCsrfToken } from 'discourse/lib/ajax';

export default class AdminPluginsPagesIndexController extends Controller {
	@service toasts;

	@action
	async deletePage(page) {
		if (confirm('Delete this page?')) {
			try {
				const response = await fetch(`/admin/plugins/pages/${page.id}`, {
					method: 'DELETE',
					headers: { 'X-CSRF-Token': getCsrfToken() }
				});

				if (!response.ok) {
					this.toasts.error('Failed to delete page');
					return;
				}

				this.model.pages.removeObject(page);
				this.toasts.success('Page deleted');
			} catch (error) {
				this.toasts.error('An error occurred');
			}
		}
	}
}