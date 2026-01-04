import Route from '@ember/routing/route';
import { ajax } from 'discourse/lib/ajax';

export default class AdminPluginsPagesIndexRoute extends Route {
	model() {
		return ajax('/admin/plugins/pages/list');
	}
}