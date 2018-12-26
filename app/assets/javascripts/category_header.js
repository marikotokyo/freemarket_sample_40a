$(document).on('turbolinks:load',function() {

  function buildHTML() {
    var html = `<div class = "top-parent">
                  <ul class = "top-nav">
                    <li class = "top-nav-parent-wrap">
                      <ul class = "top-nav-parent">
                      </ul>
                    </li>
                    <li class = "top-nav-child-wrap">
                      <ul class = "top-nav-child">
                      </ul>
                    </li>
                    <li class = "top-nav-grand-child-wrap" >
                      <ul class = "top-nav-grand-child" >
                      </ul>
                    </li>
                  </ul>
                </div>`
    return html;
  }

  function addLarge(id,name) {
    var html = `<li class = large_category data-headid = ${id}><a href = "/categories/${id}" >${name}</a></li>`;
    return html;
  }

  function addMedium(id,name) {
    var html = `<li class = medium_category data-headid = ${id}><a href = "/categories/${id}">${name}</a></li>`;
    return html;
  }

  function addSmall(id,name) {
    var html = `<li class = small_category data-headid = ${id}><a href = "/categories/${id}">${name}</a></li>`;
    return html;
  }

  $(document).on('mouseenter','.search-category',function() {
    $('.top-parent').css('display','block');
  }).on('mouseleave','.search-category',function(){
    $('.top-parent').css('display','none');
  });

  $(document).one('mouseenter','.search-category',function() {
    $('.large_category').remove();
    $('.medium_category').remove();
    $('.small_category').remove();
    $('.search-category').append(buildHTML);

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

      large_categories.forEach( function(value) {
        var addLargeCategory = addLarge(value.id,value.name)
        $('.top-nav-parent').append(addLargeCategory);
      });

      $(document).on('mouseenter','.large_category',function() {
        $('.medium_category').remove();
        $('.small_category').remove();
        var result_child = $(this).data('headid');
        var result_child = String(result_child);

        $('.large_category').removeClass('active');
        large_index = $('.large_category').index(this) ;
        $(this).addClass('active');

        medium_categories.forEach( function(value) {
          if(result_child == value.depth){
            var addMediumCategory = addMedium(value.id,value.name)
            $('.top-nav-child').append(addMediumCategory);
          }
        });

        $(document).on('mouseenter','.medium_category',function() {
          $('.small_category').remove();
          var result_g_child = $(this).data('headid');
          var result_g_child = String(result_g_child);
          var result = result_child + '/' + result_g_child

          $('.medium_category').removeClass('active');
          medium_index = $('.medium_category').index(this) ;
          $('.large_category').eq(large_index).addClass('active');
          $(this).addClass('active');

          small_categories.forEach( function(value) {
            if( result == value.depth){
              var addSmallCategory = addSmall(value.id,value.name)
              $('.top-nav-grand-child').append(addSmallCategory);
            }
          });

          $(document).on('mouseenter','.small_category',function() {
            $('.medium_category').eq(medium_index).addClass('active');
            $(this).addClass('active');

          }).on('mouseleave','.small_category',function(){
            $(this).removeClass('active');
          });

        }).on('mouseleave','.medium_category',function(){
          $(this).removeClass('active');
        });

      }).on('mouseleave','.large_category',function(){
        $(this).removeClass('active');
      });
    })

    .fail(function() {
      alert('error');
    })

  }).mouseleave(function(){

  });
});
