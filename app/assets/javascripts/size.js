$(function() {
  //プルダウン作成前編
  function appendPullDownHead() {
    var pullDown1 = `<div class="new-itembox__right--group size-box">
                     <span>サイズ
                    <div class="require">必須</div>
                    </span>
                    <select class="select-new size-pd" method="post" name="item[size_id]">
                    <option value=""> --- </option>`
    $('.cate').after(pullDown1);
  }
  //中編
  function appendPullDownBody(size) {
    var pullDown2 = `<option value="${size.id}">${size.name}</option>`
    $('.size-pd').append(pullDown2);
  }
  //後編
  function appendPullDownBottom() {
    var pullDown3 = `</select>
                   </div>`
    $('.size-pd').append(pullDown3);
  }

    // サイズプルダウンの出現、小カテゴリをチョイス
  $(document).on('change','.scate', function(event) {
    var sizeVal = $('.scate option:selected').data('size');
    $('.size-box').remove();
    if (sizeVal != 0) {
      $.ajax({
        type: 'GET',
        url: '/sizes',
        data: {id: sizeVal},
        dataType: 'json'
      })
      .done(function(sizeData) {
        appendPullDownHead();
        sizeData.forEach(function(size) {
          appendPullDownBody(size);
        })
        appendPullDownBottom();
      })
      .fail(function() {
        alert('ちょっとごめん、もう一回更新してやり直して');
      })
      .always(function() {
        $('.mcate').prop("disabled", false);
      })
    }
  })
});
