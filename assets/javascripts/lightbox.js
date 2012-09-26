(function($) {

  $(function() {
    var options = {
    		'transitionIn'	:	'elastic',
    		'transitionOut'	:	'elastic',
    		'speedIn'		:	600,
    		'speedOut'		:	200
  		}

    $("div.attachments a.lightbox, div.attachments a.swf").fancybox(options);
    $.extend(
      options,
      {
        'width': '100%', // or whatever
        'height': '100%',
        'autoDimensions': false,
        'showNavArrows': false,
        'onClosed': function() {
          $("#fancybox-inner").empty();
        }
      }
    )
    $("div.attachments a.pdf").each(function() {
       if(is_chrome()) {
         var inline_link = this.href.replace(/\/attachments\//, "/attachments/download_inline/");
         options.content = '<embed src="' + inline_link + '" type="application/pdf" class="chrome"/>';
       }
       else {
         options.content = '<embed src="' + this.href + '#nameddest=self&page=1&view=FitH, 0&zoom=80,0,0" type="application/pdf" height="100%" width="100%" />';
       }
       $(this).fancybox(options);
    })

    function is_chrome() {
      return navigator.userAgent.indexOf("Chrome") >= -1
    }

  })

})(jQuery)
