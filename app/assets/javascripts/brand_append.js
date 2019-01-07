$(document).on('turbolinks:load',function() {

  function buildHTML() {
    var html = `<div class = "form-group form-suggest-container">
                  <label>
                    ブランド
                      <span class = "form-arbitrary">任意</span>
                  </label>
                  <div>
                    <input class = "input-new
                    " value placeholder="例）シャネル">
                  </div>
                </div>`
    return html;
  }

    $(document).on('click','.scate', function() {
      var count_class = $(".form-suggest-container").length;
      if (count_class == 0){
        $('.brand-box').append(buildHTML);
      }
    })

});
