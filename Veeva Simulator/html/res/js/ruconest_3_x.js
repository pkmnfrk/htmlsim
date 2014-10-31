function copyChange() {
	$('.copychange').toggleClass('on');
	console.log('dogee');
}

$('#copychangetaparea').on('touchend', copyChange);

$('#paginator1').on('touchend', function() {
	console.log('Paginator 1 Clicked');
	window.location = "veeva:gotoSlide(ruconest_3_1.zip, RUCONEST_PRES001)";
});
$('#paginator2').on('touchend', function() {
	console.log('Paginator 2 Clicked');
	window.location = "veeva:gotoSlide(ruconest_3_2.zip, RUCONEST_PRES001)";
});
$('#paginator3').on('touchend', function() {
	console.log('Paginator 3 Clicked');
	window.location = "veeva:gotoSlide(ruconest_3_3.zip, RUCONEST_PRES001)";
});
$('#paginator4').on('touchend', function() {
	console.log('Paginator 4 Clicked');
	window.location = "veeva:gotoSlide(ruconest_3_4.zip, RUCONEST_PRES001)";
});
