$(document).on('turbolinks:load',function() {
  $(document).on('keyup', '.incremental-form', function(e){
    e.preventDefault();
    var input = $.trim($(this).val());

    $.ajax({
      url: '/brands/search',
      type: 'GET',
      data: ('keyword=' + input),
      processData: false,
      contentType: false,
      dataType: 'json'
    })

    .done(function(data){
      $('.incremental-result').find('li').remove();

      if (data.length !== 0){
        $(data).each(function(i, brand){
          $('.incremental-result').append('<li id =' + brand.id + '>' + brand.name + '</li>')
        });
      }

      if (input.length === 0) {
        $('.incremental-result').find('li').remove();
      }
    })

    .fail(function() {
      alert("失敗しました！");
    })
  });

  $(document).on('mouseenter','.incremental-result li',function(){
    $(this).css('background', '#1E90FF');
    $(this).css('color', 'white');
  });

  $(document).on('mouseleave','.incremental-result li',function(){
    $(this).css('background', '');
    $(this).css('color', '');
  });

  $(document).on('click','.incremental-result li',function(){
    var name = $(this).text();
    var id =  $(this).attr('id');
    $('.incremental-form').val(name);
    $('.incremental-result').find('li').remove();
  });
});
