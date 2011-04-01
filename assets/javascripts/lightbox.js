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
        'width': '80%', // or whatever 
        'height': '100%', 
        'autoDimensions': false,         
        'onClosed': function() { 
          $("#fancybox-inner").empty(); 
        }
      }
    )
    $("div.attachments a.pdf").each(function() {
       options.content = '<embed src="' + this.href + '#nameddest=self&page=1&view=FitH, 0&zoom=80,0,0" type="application/pdf" height="100%" width="100%" />';
       $(this).fancybox(options);
    })
    
    	
  })
  
})(jQuery)