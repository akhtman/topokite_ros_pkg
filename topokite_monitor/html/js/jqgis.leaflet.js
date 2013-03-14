(function($){
	function LMap(placeholder, options) {
		if (typeof(options)=='undefined') {
			options = {
				center: new L.LatLng(46.523, 6.569),
				zoom: 15,
				minZoom: 7,
				maxZoom: 16
			}
		}
		var map = new L.Map(placeholder, options);

		var RedDot9 = L.Icon.extend({
	    		iconUrl: 'img/reddot9.png',
	    		shadowUrl: 'img/reddot9.png',
	    		iconSize: new L.Point(9, 9),
	    		shadowSize: new L.Point(9, 9),
	    		iconAnchor: new L.Point(5, 5),
	    		popupAnchor: new L.Point(5, 5)
			}),
			reddot9 = new RedDot9();

		//this.map.setView(new L.LatLng(46.523, 6.569), 15);		
		// create a CloudMade tile layer (or use other provider of your choice)
		/*
		this.cloudmade = new L.TileLayer('http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/997/256/{z}/{x}/{y}.png', {
		    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
		    maxZoom: 18
		});
		// add the CloudMade layer to the map set the view to a given center and zoom
		this.map.addLayer(this.cloudmade).setView(new L.LatLng(46.523, 6.569), 15);
		*/
		
		var tilesets = ['pk25_1242', 'pk25_1243', 'pk50_261', 'pk200-500'];
		
		/*
		$(tilesets).each( function(){
			var layer = new L.TileLayer('../national/'+this+'/{z}/{x}/{y}.png', {
			    attribution: 'SwissTopo',
			    errorTileUrl: 'img/blank.gif',
			    scheme: 'tms',
			    minZoom: 7,
			    maxZoom: 16
			});
			map.addLayer(layer)
		});
		*/
		
		var layer = new L.TileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
		});
		map.addLayer(layer);
		
		function extend(vis) {
			vis.visible = false;
			vis.hide = function(){ if (this.visible) { this.visible = false; map.removeLayer(this) } };
			vis.show = function(){ if (!this.visible) { this.visible = true; map.addLayer(this) } }
		}
		
		var add = function(obj) {
			obj.tags = (obj.tags) ? obj.tags : '';
			if (obj.type=='point' && obj.id) {
				var pos = (obj.position) ? obj.position : { lat: 46.523, lng: 6.569 };
				var vis = new L.Marker(new L.LatLng(pos.lat, pos.lng), { icon: reddot9 });
				extend(vis);
				vis.show()
			}
			else if (obj.type=='polygon') {
				var path = [];
				$(obj.path).each(function(){ path.push(new L.LatLng(this.lat, this.lng)) });
				vis = new L.Polygon(path, { color: obj.options.color, weight: 1 });
				extend(vis);
				vis.show()
			}
			else return;
			$.gis.visElements[obj.id] = vis;
			$.gis.visElementsDescription = $($.gis.visElementsDescription)
				.append('<element id="'+obj.id+'" type="'+obj.type+'" tags="'+obj.tags+'">')
		},
		sync = function(s) {
			if (s.id && $g.visElements[s.id]) {
				if (s.type == 'point') if (s.position) if (s.position.lat)
					$g.visElements[s.id].setLatLng(new L.LatLng(s.position.lat, s.position.lng));
				else if (s.type == 'polygon' && s.path && $g.visElements[s.id]) {
					var path = []; console.log(this.lat);
					$(s.path).each(function(){ path.push(new L.LatLng(this.lat, this.lng)) });
					$g.visElements[s.id].setLatLngs(path)
				}
			}
		};
		
		//map.on('zoomend', function(e){ alert('zoomend') });
		
		// create a marker in the given location and add it to the map
		//this.marker = new L.Marker(new L.LatLng(46.523, 6.569));
		//this.map.addLayer(this.marker);
		return {
			map: map,
			add: add,
			sync: sync
		}	
	}
	
	$.gis.lmap = function(placeholder, options) {
		var lmap = new LMap(placeholder, options);
		$.gis.plugins.push(lmap);
		return lmap
	}
	$.gis.lmap.version = "0.1";
	
	/*
	var MyIcon = L.Icon.extend({
	    iconUrl: '/topokite/css/images/marker.png',
	    shadowUrl: '/topokite/css/images/marker-shadow.png',
	    iconSize: new L.Point(38, 95),
	    shadowSize: new L.Point(68, 95),
	    iconAnchor: new L.Point(22, 94),
	    popupAnchor: new L.Point(-3, -76)
	});
	$.lmap.marker = new MyIcon();
	*/
	
})(jQuery)
