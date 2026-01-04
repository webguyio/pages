export default function () {
	this.route('adminPlugins.pages', { path: '/plugins/pages' }, function () {
		this.route('index', { path: '/' });
		this.route('new');
		this.route('edit', { path: '/:id/edit' });
	});
}