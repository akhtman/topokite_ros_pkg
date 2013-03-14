(function ($) {
	function Mission(placeholder, options) {
		this.placeholder = placeholder;
		this.droneId = options.id;
		$('head').append('<link rel="stylesheet" type="text/css" href="css/topokite.mission.css"/>');
		$('#'+placeholder).load("js/topokite.mission.html", function(){
			$(document).trigger('mission-ready');
			$('.next-wpt').on('click',function(){ $.spoofPosition = true })
		})
	}
	$.gis.mission = function(placeholder, options) {
		var mission = new Mission(placeholder, options);
		$.gis.plugins.push(mission);
		return mission
	}
	$.gis.mission.version = 0.1;
})(jQuery);