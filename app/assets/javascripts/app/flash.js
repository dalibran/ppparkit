flashHandler = function(e, params) {
	Materialize.toast(params.message, 4000, 'toast-flash', function() {
    $("#toast-container").hide();
  });
};

$(window).bind('rails:flash', flashHandler);
