(function($){
	function FTDataLoader(placeholder, options) {
		load = function(options) {
			if (options.type == 'FT') {
				// load data from fusion table
				var datasets = [];
				$(datasets).each( function(){ $.gis.add(this) })
			}
		}
		return {
			sync: sync
		}
	}
	
	$.gis.timeline = function(placeholder, options) {
		var timeline = new Timeline(placeholder, options);
		$.gis.plugins.push(timeline);
		return timeline
	}
	$.gis.timeline.version = 0.1;

})(jQuery);