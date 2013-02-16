window.Nomnom = Ember.Application.create();

Nomnom.IndexController = Ember.Controller.extend({
  baseURL: '/'
});

Nomnom.Router.map(function(){
  this.route("index", { path: "/" });
});

Nomnom.IndexRoute = Ember.Route.extend({
  setupController: function(controller){
    this.controllerFor('index').set('baseURL', 'zzz');
  },
  renderTemplate: function(){
    this.render('cats');
  }
});