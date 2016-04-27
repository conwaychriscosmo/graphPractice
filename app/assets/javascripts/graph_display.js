$(document).ready(function() {
	$('.basic-html-bar-chart').hide();
	$('.basic-svg-bar-chart').hide();
	$('.html-bar-toggle').click( function() {
		$('.basic-html-bar-chart').toggle();
	});
	$('.svg-bar-toggle').click( function() {
		$('.basic-svg-bar-chart').toggle();
	});
	$('.letter-bar-toggle').click( function() {
		$('.vertical-chart').toggle();
		$('.svg-circles').toggle();
		$('.description').toggle();
	});

});