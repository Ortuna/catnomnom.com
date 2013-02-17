window.Nomnom = Ember.Application.create();

Nomnom.IndexController = Ember.Controller.extend({});

Nomnom.Router.map(function(){
  this.route("index", { path: "/" });
});

Nomnom.IndexRoute = Ember.Route.extend({
  setupController: function(controller){},
  renderTemplate: function(){
    this.render('cats');
  }
});

Nomnom.catView = Ember.View.extend({
  tagName: 'img',
  classNames: ['movable', 'large'],
  attributeBindings: ['src'],
  src: 'http://placehold.it/150x150',
  didInsertElement: function(){
    this.setupPosition();
  },
  setupPosition: function() {
    var docWidth  = $(document).width();
    var docHeight = $(document).height();
    var $el = $("#" + this.get('elementId'));
    var left = Math.round(Math.random() * docWidth  - $el.width());
    var top  = Math.round(Math.random() * docHeight - $el.height());

    $el.css("left", left);
    $el.css("top", top);

    var duration = 1000;
    if($el.hasClass('large'))
      duration = duration * 10;
    else if($el.hasClass('medium'))
      duration = duration * 9.5;
    else
      duration = duration * 9;

    $el.transition({ y: - (top + docHeight), duration: duration });
  }
});

Nomnom.catContainer = Ember.View.extend({
  types: ['large', 'small', 'medium'],
  templateName: 'cats',
  init: function(){
    this.populateImages();
    return this._super();
  },
  populateImages: function(){
    for(var i = 0 ; i < 10; i++) {
      var index =  Math.round(Math.random()*2);
      view = Nomnom.catView.create();
      view.classNames = [this.types[index]];
      view.append();
      this.get('childViews').pushObject(view);
    }
  }
});



$(document).ready(function(){
  var cats = Nomnom.catContainer.create();
});