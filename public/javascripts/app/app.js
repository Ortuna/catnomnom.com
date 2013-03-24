$(document).ready(function(){

  $container = $('.container');
  cats = [];

  $.get('/cats?limit=20', function(data) {
    cats = data;
    appendCats(data);
    applyMasonry($container);
  }, 'json');
  $('.load-more').click(function(){
    appendNewCats(5);
    return false;
  });

  function appendCats(items){
    for(var i = 0; i < items.length; i++) {
      $container.append(catElement(items[i]));
    }
  }

  function catElement(item) {
    var url   = item.url;
    var title = item.title.substr(0,60);
    $element = $("<div class='cat'><img /><span>" + title + "</span></div>");
    $element.find("img").attr('src', url);
    return $element;
  }

  function appendElement($el) {
    $container.append( $el );
    $container.masonry('reload');
  }

  function appendNewCats(count) {
    if(cats.length < 5) {
      $.get('/cats?limit=20' + limit, function(data) {
        for(var i = 0; i < data.length;i++) {
          cats.push(data[i]);
        }
      });
    }
    
    for(var i =0; i < count; i++){
      cat = cats.pop();
      appendElement(catElement(cat.url));
    }
    $container.masonry('reload');
  }

  function applyMasonry($el, subSelector) {
    $el.imagesLoaded( function(){
      $el.masonry({
        itemSelector: subSelector,
        isAnimatedFromBottom: true,
        isAnimated: true,
      });
    });
  }
});
