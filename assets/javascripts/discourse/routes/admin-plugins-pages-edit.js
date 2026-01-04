import Route from '@ember/routing/route';
import { ajax } from 'discourse/lib/ajax';

export default class AdminPluginsPagesEditRoute extends Route {
	model(params) {
		return ajax(`/admin/plugins/pages/${params.id}/edit`);
	}
}