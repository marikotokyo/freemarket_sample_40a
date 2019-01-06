$(function() {
  $(document).on('click','#payjp_checkout_box input:button', function() {
    // console.log('777');

    var iframe = $('#payjp-checkout-iframe').contents().find('html').html();
    console.log(iframe)

  })
});
