setTimeout(function() {
	$('#thewheel').removeClass('disabled');
	console.log('Wheel Enabled');
}, 1000);


$('#isi').on('touchstart', function(){
	console.log('ISI Clicked'); 
	window.location = "veeva:gotoSlide(ruconest_isi.zip, RUCONEST_PRES001)";
});

$('#pi').on('touchstart', function(){
	console.log('PI Clicked'); 
	window.location = "veeva:gotoSlide(ruconest_pi.zip, RUCONEST_PRES001)";
});

$('#hamburger').on('touchstart', function(){
	$('#wheelnav, #thewheel').addClass('on');
});

$('#homelogo').on('touchstart', function(){
	window.location = "veeva:gotoSlide(ruconest_0_home.zip, RUCONEST_PRES001)";
});

$('#wheelnav').on('touchstart', function(e){
	var x = window.event.changedTouches[0].pageX;
	var y = window.event.changedTouches[0].pageY;
	
	var sliceclicked = sliceDetection(x,y);
	
	console.log(sliceclicked);
	
	switch (sliceclicked) {
		case -3:
			$('#wheelnav, #thewheel').removeClass('on');
		break;
		case -4:
			window.location = "veeva:gotoSlide(ruconest_1_2.zip, RUCONEST_PRES001)";
		break;
		case -5:
			window.location = "veeva:gotoSlide(ruconest_2_0.zip, RUCONEST_PRES001)";
		break;
		case 4:
			window.location = "veeva:gotoSlide(ruconest_3_1.zip, RUCONEST_PRES001)";
		break;
		case 3:			
			window.location = "veeva:gotoSlide(ruconest_4_0.zip, RUCONEST_PRES001)";
		break;
		case 2:
			window.location = "veeva:gotoSlide(ruconest_ref.zip, RUCONEST_PRES001)";
		break;
	}
}); 

sliceDetection = function(x, y) {
	//Where the user clicked
	var clickx = x;
	var clicky = y;

	//The center of the wheel if it was a full circle
	var centerx = 1017;
	var centery = 369;

	//Knowing Deltas are required for finding out distance!
	var deltax = clickx - centerx;
	var deltay = clicky - centery;

	//Now we know how far the tap was from the center of the circle
	var distance = Math.sqrt(((deltax) * (deltax)) + ((deltay) * (deltay)));
	console.log(distance);

	//If the tap is somewhere inside of the button area in the circle
	if (distance > 170 && distance < 400) {
		
		var angle = Math.atan2(deltay, deltax) * 180 / Math.PI;	
		angle = angle - 0; //Change this 0 to something else to adjust circle offset if necessary

		var number_of_slices = 10;
		var sliceweight = 360/number_of_slices;

		var slice = Math.floor(angle / sliceweight);
		slice = slice - 0; //Change this 0 to something else to adjust circle offset if necessary
		
		return slice;
	}
	
	else if (distance > 55 && distance < 170) {
		window.location = "veeva:gotoSlide(ruconest_0_home.zip, RUCONEST_PRES001)";
	}
	
	//If it's outside of the circle or too close to the middle do nothing
	else {
		$('#wheelnav, #thewheel').removeClass('on');
	}
}
