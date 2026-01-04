import Route from '@ember/routing/route';

export default class AdminPluginsPagesNewRoute extends Route {
	model() {
		return { title: '', slug: '', content: '', meta_title: '', meta_description: '', enabled: true };
	}
}