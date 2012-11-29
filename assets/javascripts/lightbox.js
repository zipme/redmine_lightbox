(function($) {

  $(function() {
    var options = {
    		'transitionIn'	:	'elastic',
    		'transitionOut'	:	'elastic',
    		'speedIn'		:	600,
    		'speedOut'		:	200
  		}

    $("div.attachments a.lightbox, div.attachments a.swf, div.attachments a.image, div.attachments a.attachment_preview, ul.details a.swf, ul.details a.image, ul.details a.attachment_preview").fancybox(options)
    $.extend(
      options,
      {
        'width': '100%', // or whatever
        'height': '100%',
        'autoDimensions': false,
        'showNavArrows': false,
        'onClosed': function() {
          $("#fancybox-inner").empty()
        }
      }
    )

    $("div.attachments a.pdf, ul.details a.pdf").each(function() {
      if(is_chrome()) {
        var inline_link = this.href.replace(/\/attachments\//, "/attachments/download_inline/")
        options.content = embed_chrome_pdf(inline_link)
      }
      else {
        options.content = embed_pdf(this.href)
      }
      $(this).fancybox(options)
    })

    $("div.attachments a.attachment_preview, ul.details a.attachment_preview").each(function() {
      if(is_chrome()) {
        var inline_link = this.href.replace(/\/preview\//, "/preview_inline/")
        options.content = embed_chrome_pdf(inline_link)
      }
      else {
        options.content = embed_pdf(this.href)
      }
      $(this).fancybox(options)
    })


    function is_chrome() {
      return navigator.userAgent.indexOf("Chrome") >= -1
    }

    function embed_chrome_pdf(document_url) {
      return '<embed src="' + document_url + '" type="application/pdf" class="chrome"/>'
    }

    function embed_pdf(document_url) {
      return '<embed src="' + document_url + '#nameddest=self&page=1&view=FitH, 0&zoom=80,0,0" type="application/pdf" height="100%" width="100%" />'
    }

  })

})(jQuery)
