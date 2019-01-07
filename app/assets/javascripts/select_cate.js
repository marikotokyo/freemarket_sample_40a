$(function() {
  $(document).on('turbolinks:load', function() {
    //中カテゴリのプルダウン生成
    //前編
    function mBuildPd1() {
      var mHtml1 = `
                    <select class="select-new mcate" method="post" name="item[category_id]">
                    <option value=""> --- </option>
                    `
    $('.cate').append(mHtml1);
    }
    //中編
    function mBuildPd2(mc) {
      var mHtml2 = `<option value="${mc.id}">${mc.name}</option>`
      $('.mcate').append(mHtml2);
    }
    //後編
    function mFormEnd() {
      var mHtml3 = `</select>`
      $('.mcate').append(mHtml3);
    }

    //小カテゴリのプルダウン生成
    //前編
    function sBuildPd1() {
      var sHtml1 = `
                    <select class="select-new scate" method="post" name="item[category_id]">
                    <option value=""> --- </option>
                    `
    $('.cate').append(sHtml1);
    }
    //中編
    function sBuildPd2(sc) {
      var sHtml2 = `<option value="${sc.id}" data-size="${sc.size_pulldown}">${sc.name}</option>`
      $('.scate').append(sHtml2);
    }
    //後編
    function sFormEnd() {
      var sHtml3 = `</select>`
      $('.scate').append(sHtml3);
    }

    //プルダウンが重複しないようにする
    //大カテゴリを選び直したとき
    function mRemovePD() {
      $('.size-box').hide();
      if ($('.mcate').length != 0) {
        $('.mcate, .scate').remove();
      }
    }
    //中カテゴリを選び直したとき
    function sRemovePD() {
      $('.size-box').hide();
      if ($('.scate').length != 0) {
        $('.scate').remove();
      }
    }

    // 大カテゴリをチョイス
    $("#item_category").on('change', function() {
      var val = $(this).val();
      mRemovePD();
      $('.size-box').hide();
      if (val.length != 0) {
        $.ajax({
          type: 'GET',
          url: '/categories/select_top',
          data: {id: val},
          dataType: 'json'
        })
        // 成功した時
        .done(function(data) {
          mRemovePD();
          mBuildPd1('mcate');
          data.forEach(function(mc) {
            mBuildPd2(mc)
            mFormEnd('.mcate')
          });
        })
        // 失敗した時
        .fail(function() {
          alert('ちょっとごめん、もう一回更新してやり直して');
        })
        .always(function() {
          $('#item_category').prop("disabled", false);
        })
      }
    })

    // 中カテゴリチョイス
    $(document).on('change','.mcate', function() {
      var val = $(this).val();
      sRemovePD();
      if (val.length != 0) {
        $.ajax({
          type: 'GET',
          url: '/categories/select_mid',
          data: {id: val},
          dataType: 'json'
        })
        // 成功した時
        .done(function(data) {
          sRemovePD();
          if(data.length != 0) {
            sBuildPd1('scate');
            data.forEach(function(sc) {
              sBuildPd2(sc)
              sFormEnd('.scate')
            });
          }
        })
        // 失敗した時
        .fail(function() {
          alert('ちょっとごめん、もう一回更新してやり直して');
        })
        .always(function() {
          $('.mcate').prop("disabled", false);
        })
      }
    })

  });
});
