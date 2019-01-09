$(function() {
  // @paybtnをリンクっぽくする
  $('.order-item__pay-btn__box-paypay').on('mouseover', function() {
    $(this).css('text-decoration', 'underline');
  })
  $('.order-item__pay-btn__box-paypay').on('mouseout', function() {
    $(this).css('text-decoration', 'none');
  })

  // 支払いの一連の流れ
  $('.order-item__pay-btn__box-paypay').on('click', function() {
    Payjp.setPublicKey(gon.key);

    // payアクションのurlを取得
    var url = $('#paycard').attr('action')

    // 失敗した時のリダイレクト先
    var redidect = $('#order-show-go').attr('href')
    console.log(redidect);

    // フォームのカード情報を取得してcardにまとめる
    var num = $('.pay-num').val();
    var cvc = $('.pay-cvc').val();
    var exp_m = $('.pay-exp-m').val();
    var exp_y = "20" + $('.pay-exp-y').val();

    var card = {
      number: num,
      cvc: cvc,
      exp_month: exp_m,
      exp_year: exp_y
    };

    // payjp.jsを使ってトークンを作成
    Payjp.createToken(card, function(status, response) {
      if (status == 200) {
        var token = response.id;

        $.ajax({
          url: url,
          type: 'POST',
          data: {payjp_token: token},
        })
        .done(function(message) {
          alert('お支払いありがとうございます、出品者の発送をお待ちください！');
        })
        .fail(function() {
          alert('通信エラーで支払い失敗です！もう一度試してみてください！');
        })

      } else {
        alert('カードが使えないようです！残念！');
        $(location).attr('href', redidect);
      };
    });
  })
});
