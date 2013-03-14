if (gis.online) (function ($) {
	function GMap(placeholder, options) {
	    var vis = [],
	    	latlng = new google.maps.LatLng(46.523, 6.569),
	    	options = {
		        zoom: 18,
		        center: latlng,
				scaleControl: true,
				streetViewControl: false,
				mapTypeId: google.maps.MapTypeId.SATELLITE,
				mapTypeControl: false,
				draggableCursor: 'crosshair'
	    	},
			map = new google.maps.Map($('#'+placeholder)[0], options),
			add = function(obj) {
				if (obj.type=='point') {
					vis[obj.id] = new google.maps.Marker({
						position: (obj.position) ? obj.position : map.center, 
						visible: (obj.visible) ? obj.visible : true,
						map: map,
						icon: (obj.icon) ? obj.icon : { url: gis.markerIcons.reddot, anchor: new google.maps.Point(4.5, 4.5) }
					})
				}
				else if (obj.type=='polygon') {
					var path = [];
					$(obj.path).each(function(){ path.push(new google.maps.LatLng(this.lat, this.lng)) }); 
					vis[obj.id] = new google.maps.Polygon({
						paths: path,
						strokeColor: (obj.color) ? obj.color : "#00f",
		        		strokeOpacity: (obj.strokeOpacity) ? obj.strokeOpacity : 0.2,
		        		strokeWeight: (obj.strokeWeight) ? obj.strokeWeight : 1,
		        		fillColor: (obj.color) ? obj.color : "#00f",
		        		fillOpacity: (obj.fillOpacity) ? obj.fillOpacity : 0.15,
		        		map: map
					})
				}
			},
			sync = function(s) {
				if (vis[s.id]) {
					if (s.type == 'point' && s.position)
						vis[s.id].setPosition(new google.maps.LatLng(s.position.lat,s.position.lng));
					else if (s.type == 'region' && s.path) {
						var path = [];
						for (p in s.path) path.push(new google.maps.LatLng(s.path[p].lat, s.path[p].lng));
						vis[s.id].setPath(path)
					}
				}
			};
		return {
			map: map,
			sync: sync,
			add: add
		}
	}
	$.gis.gmap = function(placeholder, options) {
		var gmap = new GMap(placeholder, options);
		$.gis.plugins.push(gmap);
		return gmap
	};
	$.gis.gmap.version = 0.1
})(jQuery);