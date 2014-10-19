$( window ).scroll(function() {
 if ($(this).scrollTop() > 400) {
      $('.navbar-inverse').addClass('fill').removeClass('nofill');
      $('.navbar-inverse form').fadeIn('slow');
 } else {
      $('.navbar-inverse').removeClass('fill').addClass('nofill');
      $('.navbar-inverse form').fadeOut('slow');
  }
});


$(window).ready(function() {
	$("th").removeClass("tooltip");
});

$(window).ready(function() {
	$('#search').keyup(function() {
		$('.panel').removeClass('hidden');
	});
	$('#search').keyup(function() {
		$('.chevron.bottom').fadeIn();
	});
});

$(document).ready(function() {	
	  $('a[href*=#]:not([href=#])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top-70
        }, 1000);
        return false;
      }
    }
  });
});

