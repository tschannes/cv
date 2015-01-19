bigScreenLimit = 1200;

function makeAdSticky() {
	function checkAdHeight() {
		var distance = "";
		if (document.getElementsByClassName('intro').length > 0) {
			distance = document.getElementsByClassName('intro')[0].offsetHeight + 20;
			return distance;
		} else {
			distance = 0;
			return distance;
		}
	}

	window.addEventListener("scroll", function(evt) {

		// This value is your scroll distance from the top
		var distance_from_top = (document.documentElement.scrollTop || document.body.scrollTop);
		var ad = document.getElementsByClassName('ad')[0];


		// The user has scrolled to the tippy top of the page. Set appropriate style.
		if (distance_from_top < checkAdHeight()) {
			ad.removeAttribute("style");
		}

		// The user has scrolled down the page.
		if (distance_from_top > checkAdHeight()) {
			ad.style.position = "fixed";
			ad.style.top = "5em";
			ad.style.right = (window.innerWidth) - bigScreenLimit / 2;
		}
	});
}

function watchWidth() {
	var w = window.innerWidth;
	if (w > bigScreenLimit) {
		makeAdSticky();
	}
	window.addEventListener("resize", function(evt) {
		if (w > bigScreenLimit) {
			makeAdSticky();
		} else {
			location.reload();
		}
	});
}

/*Calling functions*/
watchWidth();