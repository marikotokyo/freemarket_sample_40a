$(document).on('turbolinks:load',function() {
  $('.scate').on("click", function(){
    var val = $('.mcate option:selected').val();

    $.ajax({
      type: 'GET',
      url: '/categories/select_mid',
      data: {id: val},
      dataType: 'json'
    })
    .done(function(data){
      i = 0
      data.forEach(function(one) {
        $('.scate option').attr('data-size', one.size_pulldown);
        i++;
      });
    })
    .fail(function() {
      alert('error');
    })

  });
});
