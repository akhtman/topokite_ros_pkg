(function (g) {
		
	var placeholder_ = 'map';
	
	function init(placeholder) {
	
	placeholder_ = placeholder;
	
        var latlng = new google.maps.LatLng(46.45, 6.72);
        var options = {
        zoom: 11,
        center: latlng,
	scaleControl: true,
	streetViewControl: false,
	mapTypeId: google.maps.MapTypeId.TERRAIN,
	mapTypeControl: false,
	draggableCursor: 'crosshair'
        };

	g.map = new google.maps.Map($('#'+placeholder)[0], options);
	
	for (var d=0;d<g.dates.length;d++) {
		for (var m=0;m<2;m++) {
			g.data[d][m].polyline = new google.maps.Polyline({
				map: g.map, path: g.data[d][m].coords, date: g.dates[d],
				strokeColor: g.colors[m][0], strokeOpacity: 0.3, strokeWeight: 2 
			});
			g.data[d][m].activearea = new google.maps.Polyline({
				map: g.map, path: g.data[d][m].coords, date: g.dates[d],
				strokeColor: g.colors[m][0], strokeOpacity: 0.05, strokeWeight: 8 
			});
			
			google.maps.event.addListener(g.data[d][m].activearea,'mouseover', function(){ $(document).trigger("highlight",{date: this.date}) });
			google.maps.event.addListener(g.data[d][m].activearea,'mouseout', function(){ $(document).trigger("highlight",{date: this.date, mouseout: 1}) });
			google.maps.event.addListener(g.data[d][m].activearea,'click', function(){ $(document).trigger("sync",{date: this.date});  })
		}
	}

	queryText = encodeURIComponent('SELECT date, mir, time, location, type, subtype, pi FROM 2302523');// 2374714
  	query = new google.visualization.Query('http://www.google.com/fusiontables/gvizdata?tq=' + queryText);
  	query.send(getFTSampleData); // trigger sampleready
	
	//load observation data
	queryText = encodeURIComponent('SELECT id, date, mir, time, location, type, subtype, author, notes, tags, wikilink FROM 2313889');
  	query = new google.visualization.Query('http://www.google.com/fusiontables/gvizdata?tq=' + queryText);
  	query.send(getFTObservationData);
	//load observation classes
	queryText = encodeURIComponent('SELECT type, subtype, tags, help FROM 2413548');
  	query = new google.visualization.Query('http://www.google.com/fusiontables/gvizdata?tq=' + queryText);
  	query.send(getFTObservationClasses);	 
	
	
	
		/*for (var m=0;m<2;m++) g.positions[m] = new MarkerWithLabel({
		position: latlng, visible: false, map: g.map,
		icon: { url: g.markerIcons[m], anchor: new google.maps.Point(5, 5) },
		sample: { classidx: -1, typeidx: -1 }*/

	
	g.map.controls[google.maps.ControlPosition.TOP_RIGHT].push($('#position')[0]);
	//setZindex
	//console.log((g.map.controls[google.maps.ControlPosition.TOP_RIGHT]).getZindex());
	
	g.map.controls[google.maps.ControlPosition.BOTTOM_RIGHT].push($('#copyright')[0]);
	g.map.copyright = '';
	g.map.latlng=latlng;
	
	$('#'+placeholder).hover(function(){ $('#position').fadeIn('fast') }, function(){ $('#position').fadeOut('slow') });
	google.maps.event.addListener(g.map, 'mousemove', updatePosition);
	google.maps.event.addListener(g.map, 'idle', function(){ $('#copyright').html(g.map.copyright) });
	
};


	$(document).on('sync', function(a,obj){ //on click
		
		// unselect other polyline
		for (var day=0; day<g.dates.length; day++) { 
			for (var m=0;m<2;m++) {
				polylineSet(g.data[day][m].polyline, 0.3, 2);
			}
		};
		//select this polyline
		g.d = $.inArray(obj.date,g.dates); //if (mir) g.m = mir-1;
		for (var m=0;m<2;m++) { 
			polylineSet(g.data[g.d][m].polyline, 0.8, 2);
		}
	});
	
	$(document).on('highlight', function(a,obj){
	if (!obj.overview||obj.overview==0) { // obj.overview=0 only if click from overview. If already day data plot, no more click allowed
		
		if (obj.mouseout){// unselect polyline that we just mouseout
			unhoverPath(obj.date);
		};
		
		if (!obj.mouseout){ // on mouseover
			//select this polyline
			var d = $.inArray(obj.date,g.dates);
			$(g.data[d]).each(function(){ polylineSet(this.activearea, 0.15, 8) });
		}
	}
	
	});
					
			
	

function getFTSampleData(response) {
	numRows = response.getDataTable().getNumberOfRows();
	
	for (var d=0; d<g.dates.length;d++) {
		for (var m=0;m<2;m++) {
		g.data[d][m].samples = [[],[],[]]; 
		$(g.data[d][m].samples).each(function(){ this.data = [] });
			}
	}
	for (var i=0;i<numRows;i++) {
		if (response.getDataTable().getValue(i, 0)) {
			var date = response.getDataTable().getValue(i,0).substr(5,5);
			var d = $.inArray(date,g.dates);
			var m = response.getDataTable().getValue(i, 1)-1;
			var sec = time2sec(response.getDataTable().getValue(i,2));
			var typeidx = $.inArray(response.getDataTable().getValue(i,4),g.sampleTypes);
			var name = response.getDataTable().getValue(i,5);
			var pi = response.getDataTable().getValue(i,6);
			var sample = {
				classidx: 0, typeidx: typeidx, name: name, d: d, m: m, sec: sec,
				latlng: time2latlng(d,m,sec),
				depth: time2depth(d,m,sec), pi: pi
			};
			sample.marker = new google.maps.Marker({
				position: sample.latlng, visible: true, map: g.map,
				icon: { url: g.markerIcons[sample.typeidx+2], anchor: new google.maps.Point(6, 11) },
				sample: sample
			});
			google.maps.event.addListener(sample.marker,'click',function(){ $(document).trigger("sync",{date: g.dates[this.sample.d], sample: this.sample})});
			google.maps.event.addListener(sample.marker,'mouseover',function(){ $(document).trigger("highlight",{date: g.dates[this.sample.d], sample: this.sample}) });
			google.maps.event.addListener(sample.marker,'mouseout',function(){ $(document).trigger("highlight",{date: g.dates[this.sample.d], mouseout: 1})  });
			g.data[d][m].samples[typeidx].push(sample);
			g.data[d][m].samples[typeidx].data.push([sample.sec,400-time2depth(d,m,sample.sec)[0]]);
			;
			}
	}
}	

function getFTObservationData(response) {
	numRows = response.getDataTable().getNumberOfRows();
	
	for (var d=0; d<g.dates.length;d++) {
		for (var m=0;m<2;m++) {
		g.data[d][m].observations = [[],[]]; 
		$(g.data[d][m].observations).each(function(){ this.data = [] });
			}
	}
	
	
	for (var i=0;i<numRows;i++) {
		if (response.getDataTable().getValue(i, 0)) {
			var obsid = response.getDataTable().getValue(i, 0);
			var d = $.inArray(response.getDataTable().getValue(i,1).substr(5,5),g.dates);
			var m = response.getDataTable().getValue(i, 2)-1;
			var sec = time2sec(response.getDataTable().getValue(i,3));
			var typeidx = $.inArray(response.getDataTable().getValue(i,5),g.observationTypes);
			var name = response.getDataTable().getValue(i,6); //subtype
			var author = response.getDataTable().getValue(i,7);
			var notes = response.getDataTable().getValue(i,8);
			var tags = response.getDataTable().getValue(i,9);
			var observation = {
				classidx: 1, obsid: obsid, typeidx: typeidx, name: name, d: d, m: m, sec: sec,
				latlng: time2latlng(d,m,sec),
				depth: time2depth(d,m,sec), author: author, notes: notes, tags: tags
			};
			observation.marker = new google.maps.Marker({
				position: observation.latlng, visible: true, map: g.map,
				icon: { url: g.markerIcons[observation.typeidx+5], anchor: new google.maps.Point(6, 11) },
				sample: observation, observation: observation
			});
			g.observationClasses.currentSubtype = name;
			google.maps.event.addListener(observation.marker,'click',function(){ showUpdateObservation(this.observation) });
			g.markers.push(observation.marker);
			//google.maps.event.addListener(observation.marker,'mouseover',function(){ refreshUpdateObservation(this.observation) });
			g.data[d][m].observations[typeidx].push(observation);
			g.data[d][m].observations[typeidx].data.push([observation.sec,400-time2depth(d,m,observation.sec)[0]])	
		}
	}
}

function getFTObservationClasses(response) {
	var classTable = response.getDataTable();
	numRows = classTable.getNumberOfRows();
	for (var i=0;i<numRows;i++) {
		if (classTable.getValue(i, 0)) {
			g.observationClasses.push({type : classTable.getValue(i, 0),
										subtype : classTable.getValue(i, 1),
										tags    : classTable.getValue(i, 2),
										help    : classTable.getValue(i, 3)
			});
		}
	}
	//populateFormClasses($('#obs_subtype'));
}



function polylineSet(pl, opacity, weight) {
	pl.strokeOpacity = opacity;
	pl.strokeWeight = weight;
	pl.setMap(g.map);
}


function unhoverPath(date) {
	$(g.data[$.inArray(date,g.dates)]).each(function(){
		polylineSet(this.activearea, 0.05, 8);
	});
}

function updatePosition(e) {
	$('#position .wgs').html(vsprintf('%sN, %sE', WGStoString(e.latLng)));
	$('#position .ch').html(vsprintf('%d N, %d E', WGStoCH(e.latLng)));
	//console.log(vsprintf('%sN, %sE', WGStoString(e.latLng)));
}

   g.DataBrowser = {
        init: init,
        name: 'DataBrowser',
        version: '1.0',
        placeholder: placeholder_
    };
	
	g.plugins.push(g.DataBrowser);
		
})(gis);