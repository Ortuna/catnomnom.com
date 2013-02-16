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

for(var i = 0 ; i < 5; i++) {
  var index =  Math.round(Math.random()*3);
  view = Nomnom.catView.create();
  view.classNames = [classes[index]];
  view.append();
  images.push(view);
}

Nomnom.setupPositions = function() {
  var docWidth  = $(document).width();
  var docHeight = $(document).height();
  for(var i = 0; i < images.length; i ++) {
    var $el = $("#" + images[i].get('elementId'));
    var left = Math.round(Math.random() * docWidth  - $el.width());
    var top  = Math.round(Math.random() * docHeight - $el.height());
    $el.css("left", left);
    $el.css("top", top);
  }
}


Nomnom.moveImages = function(){
  for(var i = 0; i < images.length; i ++){
    var $el = $("#" + images[i].get('elementId'));
    var duration = 1000;

    if($el.hasClass('large'))
      duration = duration * 9;
    else if($el.hasClass('medium'))
      duration = duration * 9.5;
    else if($el.hasClass('small')) 
      duration = duration * 10;

    $el.animate({
        top: "-" + $el.height() + "px",
      },{
        duration: duration
      });
  }
}

$(document).ready(function(){
  var moveInterval = setTimeout(Nomnom.setupPositions, 500);
  var moveTimeout  = setInterval(Nomnom.moveImages, 1000);
});

