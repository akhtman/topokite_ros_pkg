(function($){
	function Timeline(placeholder, options) {
		var placeholder = placeholder,
			droneId = options.id,
			data = [ [0,0] ],
			t = 0,
			readyFlags = { timeline: true },
			dataset = [ { data: this.data, color: '#f00' } ],
			plot = $.plot($('#'+placeholder), dataset, {
						series: { lines: { show: true, lineWidth: 2 } },
						xaxis: { min: 0, max: 1000 },
						yaxis: { min: -10, max: 200 },
						crosshair: { mode: "x", color: '#888' },
						grid: { borderWidth: 0.5, labelMargin: 0, backgroundColor: null,
							 			hoverable: true, clickable: true, autoHighlight: false },
						legend: {	labelBoxBorderColor: 0,
									noColumns: 1,
									position: 'nw',
									margin: [-19, 0], 
									backgroundColor: null,
									backgroundOpacity: 0     } 
			});
		sync = function(s) {
			if (s.id == droneId && s.position)
				data.push([++t, s.position.agl]);
			if (readyFlags.timeline) {
				readyFlags.timeline = false;
				plot.setData([data]);
        		// since the axes don't change, we don't need to call plot.setupGrid()
        		plot.draw();
        		setTimeout(function(){ readyFlags.timeline = true }, 100)
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