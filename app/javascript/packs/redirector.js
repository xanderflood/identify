import * as Cookies from "js-cookie";

// TODO learn the idiomatic webpack way to do this
window.identifyRedirector = window.identifyRedirector || (function() {
	var _redirectToReferrerURLOr = function(defaultDestination, cookieName) {
		var target_url = Cookies.get(cookieName) || defaultDestination;

		window.location.href = target_url;
		Cookies.remove(cookieName)
	};

	return {
		redirectToReferrerURLOr: _redirectToReferrerURLOr,
	};
})();
