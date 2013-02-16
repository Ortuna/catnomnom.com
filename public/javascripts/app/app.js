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
  src: 'http://placehold.it/150x150'
});

var classes = ['large', 'small', 'medium'];
var images = [];

for(var i = 0 ; i < 15; i++) {
  var index =  Math.round(Math.random()*3);
  view = Nomnom.catView.create();
  view.classNames = [classes[index]];
  view.append();
  images.push(view);
}

setupPositions();
var timeout = setTimeout(moveImages, 1000);


function setupPositions() {
  var docWidth  = $("document").width();
  var docHeight = $("document").height();
  for(var i = 0; i < images.length; i ++) {
    $el = $("#" + images[i].get('elementId'));
    $el.hide
    $el.css("left", Math.round(Math.random() * docWidth));
    $el.css("top", Math.round(Math.random() * docHeight));
  }
}


function moveImages(){
  for(var i = 0; i < images.length; i ++){
    
  }
}
