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
		$('.carousel-content').css('height', '90%');
	});
	// $('#search').keyup(function() {
		
	// });
});

// $(document).ready(function() {	
// 	if ($('#search').val().length > 0) {
// 		$('.panel').removeClass('hidden');
// 	} else {
// 		$('.panel').addClass('hidden');
// 	}
// });

