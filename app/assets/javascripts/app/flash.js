flashHandler = function(e, params) {
	$("#toast-container").show();
	Materialize.toast(params.message, 4000, 'toast-flash', function() {
    $("#toast-container").hide();
	});
};

$(window).bind('rails:flash', flashHandler);
