$(document).on('turbolinks:load',function() {

  function buildHTML() {
    var html = `<div class = "form-group form-suggest-container">
                  <label>
                    ブランド
                      <span class = "form-arbitrary">任意</span>
                  </label>
                  <div>
                    <input class = "incremental-form"  placeholder="例）シャネル" name = "item[brand_name]">
                  </div>
                </div>

                <div>
                  <ul class = "incremental-result">
                  </ul>
                </div>`
    return html;
  }

    $(document).on('click','.scate', function() {
      var count_class = $(".form-suggest-container").length;
      if (count_class == 0){
        $('.incremental-result').remove();
        $('.brand-box').append(buildHTML);
      }
    })

});
