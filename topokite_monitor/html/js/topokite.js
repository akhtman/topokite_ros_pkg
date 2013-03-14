//initialisation gis object
var gis = {
	map: [],
	markerIcons: { reddot: 'img/reddot9.png' },
	online: (typeof(google)!='undefined')
}

//loading apis
if (gis.online) {
	google.load('swfobject', '2.2');
	google.load('visualization', '1');
}

$(document).ready(function(){
	gis.baseURL = /http:\/\/(.*?)\//.exec(document.location.href)[1];
	gis.mapplug = (gis.online) ? $g.gmap('map') : $g.lmap('map');
	gis.map = gis.mapplug.map;
	gis.mission = $g.mission('mission', { id: 'topokite' });
	gis.ros = $g.ros('', { id: 'topokite', rosURL: 'ws://'+gis.baseURL+':9090' }); 
	// rosURL: 'ws://topopc27:9090' });
	//gis.cam_front = $g.camera('cam-front', { id: 'cam-front', rosTopic: 'http://'+gis.baseURL+':8080/stream?topic=/image_raw' });
	gis.pfd = $g.pfd('pfd', { id: 'topokite'});
	//gis.cam_down = $g.camera('cam-down', { id: 'cam-down', rosTopic: 'http://'+gis.baseURL+':8080/stream?topic=/ueyecam/preview' });
	gis.compass = $g.compass('compass', { id: 'topokite' });
	
	gis.proj = $g.camProjection('', { droneId: 'topokite', camId: 'down-cam' })
	gis.timeline = $g.timeline('timeline', { id: 'topokite' });
	
	$.gis.add({ type: 'point', id: 'topokite' });
	//gis.add({ type: 'point', id: 'down-cam-proj-tl', icon: { url: 'img/bluedot9.png' } })
	$.gis.add({ type: 'polygon', id: 'topokite-down-cam', options: { color: 'blue' } })
});

gis.getMapCenter = function() {
	return (gis.online) ? { lat: gis.map.center.lat(), lng: gis.map.center.lng() } : gis.map.getCenter()
}
