$(document).on('turbolinks:load',function() {

  function addGLarge(id,name) {
    var html = `<div class = "category-list-individual-box clearfix">
                  <div id = root_category-${id} class = "category-list-individual-box-root-category-name">
                    <h3> ${name} </h3>
                  </div>
                  <div class = "category-list-individual-box-inner-box">
                    <p>
                      <a href = "/categories/${id}/"> すべて </a>
                    </p>
                    <div class = "category-list-individual-box-sub-category-name" data-indexid = ${id}>
                    </div>
                  </div>
                </div>`
    return html;
  }

  function addGMedium(id,name,depth) {
    var html = `<h4> ${name} </h4>
                <div class = "category-list-individual-box-sub-sub-category-box clearfix" data-indexid = ${depth}/${id}>
                </div>`
    return html;
  }

  function addGSmall(id,name) {
    var html = `<div class = "category-list-individual-box-sub-sub-category-name" >
                <p><a href = "/categories/${id}"> ${name} </p>
                </div>`
    return html;
  }

  function addAll(id) {
    var html = `<div class = "category-list-individual-box-sub-sub-category-name" >
                <p><a href = "/categories/${id}"> すべて </p>
                </div>`
    return html;
  }

  $(document).one('mousemove','.category-index',function() {
    $.ajax({
      url: '/categories',
      dataType: 'json'
    })
    .done(function(data){

      var large_categories = data.filter(function(large){
        return large.depth == null;
      });

      var medium_categories = data.filter(function(medium){
        return /^[0-9]+$/.test(medium.depth);
      });

      var small_categories = data.filter(function(small){
        return /.+\/.+/.test(small.depth);
      });

      var medium_grouped = _.groupBy(medium_categories, 'depth')

      var small_grouped = _.groupBy(small_categories, 'depth')

      large_categories.forEach( function(value) {
        var addGLargeCategory = addGLarge(value.id,value.name)
        $('.category-list-box').append(addGLargeCategory);
      });

      Object.keys(medium_grouped).forEach( function(value) {
        this[value].forEach( function(array){
          var m_id = array.id
          var m_name = array.name
          var m_depth = array.depth

          if (value == m_depth) {
            var addGMediumCategory = addGMedium(m_id,m_name,m_depth)
            $('[data-indexid=' + value + ']').append(addGMediumCategory);
          }
        });
      }, medium_grouped)

      Object.keys(small_grouped).forEach( function(value) {
        this[value].forEach( function(array){
          var s_id = array.id
          var s_name = array.name
          var s_depth = array.depth

          if (value == s_depth) {
            var addGSmallCategory = addGSmall(s_id,s_name)
            $('[data-indexid=' + '"' + value + '"' + ']').append(addGSmallCategory);
          }
        });
      }, small_grouped)

      medium_categories.forEach( function(value) {
        var addAllGrouped = addAll(value.id)
        $('[data-indexid=' + '"' + value.depth + '/' + value.id + '"' + ']').prepend(addAllGrouped);
      });

      $(function(){
          $('a[href^="#"]').click(function(e){
              e.preventDefault();
              var speed = 500;
              var href= $(this).attr("href");
              var target = $(href == "#" || href == "" ? 'html' : href);
              var position = target.offset().top;
              console.log(target);
              $("html, body").animate({scrollTop:position}, speed, "swing");
              var scrollTargetId = target.attr("id");
              setTimeout(function(){
                  location.hash = scrollTargetId;
                  return false;
              },500);
          });
      });

    })
    .fail(function() {
      alert('error');
    })
  });



});
