flashHandler = function(e, params) {
	Materialize.toast(params.message, 4000);
};

$(window).bind('rails:flash', flashHandler);