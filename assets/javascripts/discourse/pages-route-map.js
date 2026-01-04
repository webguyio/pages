export default {
	resource: "admin.adminPlugins",
	map() {
		this.route("pages");
		this.route("pages-new", { path: "/pages/new" });
		this.route("pages-edit", { path: "/pages/:id/edit" });
	},
};