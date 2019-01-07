$(document).on('turbolinks:load',function() {

  $(document).on('click','#modal-open',function(){
    $('.modal').css('display','block');
    return false;
  });

  $(document).on('click','.modal-btn-cancel, .modal',function(){
    $('.modal').css('display','none');
  });

});
