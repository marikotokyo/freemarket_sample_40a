$(document).on('turbolinks:load',function() {
  $('.owl-dot').mouseover(function(){
    var i = $(this).index();
    $('.owl-dot').removeClass('active');
    $(this).addClass('active');
    $('.owl-stage').css( { left: -300 * i + "px" } )
  });

  // 住所とかが無いと購入できない
  $('.buy-red').on('click', function() {
    if (!(gon.address)) {
      alert('住所など、基本情報を登録してください');
    }
  });
});
