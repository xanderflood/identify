import * as Cookies from "js-cookie";

// TODO learn the idiomatic webpack way to do this
window.identifyRedirector = window.identifyRedirector || (function() {
	var _redirectToReferrerURLOr = function(defaultDestination) {
		var target_url = Cookies.get("_identify_referrer_url") || defaultDestination;

		console.log(target_url);
		window.location.href = target_url;
	}

	return {
		redirectToReferrerURLOr: _redirectToReferrerURLOr,
	}
})();
