window.Nomnom = Ember.Application.create();

/* This is all defaulted (Dont need to be explicit) */
// Nomnom.IndexController = Ember.Controller.extend({});

// Nomnom.Router.map(function(){
//   this.route("index", { path: "/" });
// });

Nomnom.IndexRoute = Ember.Route.extend({
  setupController: function(controller){},
  renderTemplate: function(){
    this.render('containerView');
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

    if(left < 0)
      left = 0;
    if(top < 0)
      top = 0;

    $el.css("left", left);
    $el.css("top", top);
    this.applyTransition(top, $el, docWidth, docHeight);
  },
  applyTransition: function(top, $el, docWidth, docHeight) {
      var duration = Math.round(Math.random() * 10000) + 5000;
      $el.transition({ 
            y: (docHeight - top) + 10,
            easing: 'in-out',
            duration: duration,
            complete: $.proxy(function(){
              /*Redo!*/
              var $el = $("#" + this.get('elementId'));
              var left = Math.round(Math.random() * docWidth  - $el.width());

              $el.css('-webkit-transform', 'none');
              $el.css('top', '-' + $el.height() + 'px');
              $el.css('left', left + 'px');
              this.applyTransition(-($el.height()), $el, docWidth, docHeight);
            }, this),
      });
  }
});

Nomnom.containerView = Ember.View.extend({
  types: ['large', 'small', 'medium'],
  templateName: 'container',
  catLimit: 10,
  init: function(){
    self = this;
    this.getCats();
    return this._super();
  },
  gotCats: function(jsonCats) {
    for(var i = 0 ; i < jsonCats.length; i++) {
      var index =  Math.round(Math.random()*2);
      view = Nomnom.catView.create();
      view.src = jsonCats[i].url;
      view.classNames = [self.types[index]];
      view.append();
    }
  },
  getCats: function(){
    self = this;
    $.ajax({
      url: '/cats?limit=' + this.get('catLimit'),
      dataType: 'json',
      success: this.gotCats
    });
  }
});



$(document).ready(function(){
  cats = Nomnom.containerView.create();
}); 