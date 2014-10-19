$( window ).scroll(function() {
 if ($(this).scrollTop() > 400) {
      $('.navbar-inverse').addClass('fill').removeClass('nofill');
      $('.navbar-inverse form').show();
 } else {
      $('.navbar-inverse').removeClass('fill').addClass('nofill');
      $('.navbar-inverse form').hide();
  }
});


if ($('nav').hasClass('fill')) {
	$('.navbar-inverse form').show();
}

$(window).ready(function() {
	$("th").removeClass("tooltip");
})