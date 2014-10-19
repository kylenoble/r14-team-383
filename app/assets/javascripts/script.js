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

$(document).ready(function() {
	$('#search').keyup(function() {
		$('.panel').removeClass('hidden');
	});
});

// $(document).ready(function() {
	
// 	if ($('#search').val().length > 0 {
// 		$('.panel').show();
// 	});
	

// });
