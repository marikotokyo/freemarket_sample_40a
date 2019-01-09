$(document).on('turbolinks:load',function() {
  $('.new-itembox__create-btn').click(function(e){
  e.preventDefault();

    var input = $('.incremental-form').val();

    $.ajax({
      url: '/brands/submit',
      type: 'GET',
      data: ('keyword=' + input),
      processData: false,
      contentType: false,
      dataType: 'json'
    })

    .done(function(data){

      //送信ボタンを押した時に不必要なサイズプルダウンと配送の方法を消去して、サイズのないものにはサイズs0を入れる
      if ($('#sw-in').css('display') != 'block') {
        $('#sw-in').remove();
      }
      if ($('#sw-out').css('display') != 'block') {
        $('#sw-out').remove();
      }
      if (!($('.size-box').length)) {
        $('.size-hidden').append('<input type = "hidden" name = "item[size_id]" value = "0">');
      }

      if (data != null){
        brand_id = data[0].id
        $('.new-header').append('<input type = "hidden" name = "item[brand_id]" value = "' + brand_id +  '">')
        $('form').submit();
      }else{
        $('.new-header').append('<input type = "hidden" name = "item[brand_id]" value = "" >')
        $('form').submit();
      }
    })

    .fail(function() {
      alert("失敗しました！");
    })
  });

});
