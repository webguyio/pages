import Route from '@ember/routing/route';
import { ajax } from 'discourse/lib/ajax';

export default class AdminPluginsPagesEditRoute extends Route {
	model(params) {
		return ajax(`/pages-admin/${params.id}/edit`).then(response => {
			return response.page || response;
		});
	}
}