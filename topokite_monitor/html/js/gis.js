/*!
 * CoWGIS v1.0. Open source Collaborative WebGIS platform for environmental data analysis
 * Copyright © 2012 Yosef Akhtman (yosef.akhtman@epfl.ch) and Lorenzo Martelletti (lorenzo.martelletti@gmail.com)
 * http://wiki.epfl.ch/elemo/
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details. 
 *
 * For more information about GNU General Public License, see <http://www.gnu.org/licenses/>.
 *
 * Date: Fri Jan 6 2012, 14h30
 */
 
//charging api
var logged = false;
google.load('swfobject', '2.2');
google.load('visualization', '1');

//initialisation gis object
var gis = {};
gis.plugins = [];
gis.map = [];

	//check what is used or not any more
	gis.updateLegendTimeout = null;
	gis.latestPosition = null;
	gis.dates = []; 
	gis.data = []; 
	gis.d = -1; 
	gis.m = -1;
	gis.mir=[];
	gis.dayData = []; 
	gis.dayDataReady = false;
	gis.plots = [[],[],[],[],[]];
	gis.samples = []; 
	gis.observations = [];
	gis.markers = []; 
	gis.positions = [];
	gis.colors = [['red','rgba(255,0,0,0.2)'],['blue','rgba(0,0,255,0.2)']];
	gis.plotPrevColors = ['rgba(150,80,80,0.2)','rgba(150,80,80,0.5)']; //added for different coloring of [0] non-indexed OR [1] indexed video plotPreview
	gis.plotPrevLabels = ['?','']; //added for different labeling of [0] non-indexed OR [1] indexed video plotPreview	
	gis.sampleTypes = ['water','sediment','discrete'];
	gis.observationTypes = ['feature','structure'];
	gis.markerIcons = ['img/reddot9.png','img/bluedot9.png','img/marker11-11px.png','img/marker14-11px.png','img/marker13-11px.png','img/marker12-11px.png','img/marker15-11px.png'];

	gis.observationClasses = []; 
	gis.lengthsample=[];
	gis.activeTags = []; 
	gis.overlays = [];
	gis.formDisplay = false;
	gis.equipment = []; 
	gis.overview=0;
	/*eq = $('#equip-xml').html().split(';');	
	for (i in eq) elemo.equipment.push(eq[i].split(',')); */
	var today = new Date();
	gis.today = today.getFullYear().toString() + "-" + (today.getMonth()+1).toString() + "-" + today.getDate().toString() + "@" + today.getHours() + ":" + today.getMinutes();
	gis.allData = true;	
	
	gis.visObjects=[]; //for visualisation of object (points, sample, polyline)
	
	var queryText=[];
  	var query=[];
	
$(document).ready(function(){
	//load xml data for mir data
	$('#ctddata-xml').load('data/xml/ctddata.xml') //add callback funct?? plotCTD?
	$('#mirdata-xml').load('data/xml/mirdata.xml', loadData); //callback function in LoadData trigger dataready

	/* // SAMPLE data now in DataBrowser
	queryText = encodeURIComponent('SELECT date, mir, time, location, type, subtype, pi FROM 2302523');// 2374714
  	query = new google.visualization.Query('http://www.google.com/fusiontables/gvizdata?tq=' + queryText);
  	query.send(getFTSampleData); // trigger dataready2
	*/
	
		//Plugins initialization
	$(document).one('dataready', function() {
		
		// maybe wait until loaded, trigger a new function for next plugins?
		gis.DataBrowser.init('DataBrowser'); 
		gis.calendar.init('Calendar');
		gis.MissionInfo.init('MissionInfo');	
		gis.ElemoIntranet.init('ElemoIntranet');
		gis.NavData.init('NavData');
		gis.CTD.init('CTD');
		gis.VideoLog.init('VideoLog');
		gis.Sample.init('Sample');
		gis.legend.init('Legend');
		gis.TimeLine.init('TimeLineMir1',1);
		gis.TimeLine.init('TimeLineMir2',2);
	});
});


function loadData() {
	$('#mirdata-xml data[mir=1]').each(function(){ gis.dates.push($(this).attr('date').substring(5,10)) });
	for (var d=0;d<gis.dates.length;d++) {
		gis.data[d] = getDayData('#mirdata-xml',gis.dates[d] );
		}
	 $(document).trigger('dataready');// says when data are ready
}

function getDayData(xml, date) {
	var data = [[],[]];
	for (var m=0;m<2;m++) {
		d1 = $(xml+' data[date=2011-'+date+'][mir='+(m+1)+']').html().split(';'); //each measurement record splitted by ;  
		//console.log(d1);
		data[m].time = []; data[m].coords = []; data[m].nav = [[],[],[]]; data[m].ctd = [[],[],[]]; data[m].ctd2 = [[],[],[]];
		for (var i=0; i<d1.length; i++){
			d2 = d1[i].split(',');
			data[m].time.push(parseFloat(d2[0]));
			data[m].coords.push(new google.maps.LatLng(parseFloat(d2[1]), parseFloat(d2[2])));
			//load depth and bottom depth
			for (var j=0;j<2;j++) data[m].nav[j].push([parseFloat(d2[0]), 400-parseFloat(d2[3+j])]);
			//load heading and speed
			data[m].nav[2].push([parseFloat(d2[5]), parseFloat(d2[6])]);
			//load STD data
			for (var j=0;j<3;j++) data[m].ctd[j].push([(parseFloat(d2[7+j]))?parseFloat(d2[7+j]):null, -parseFloat(d2[3])]);
			for (var j=0;j<3;j++) data[m].ctd2[j].push([(parseFloat(d2[5+j]))?parseFloat(d2[5+j]):null, -parseFloat(d2[3])]); //load d2(5) d2(6) d2(7) with each time the depth of submarine
		}
	}
	//console.log('create data.ctd');
	//console.log(data[0].ctd);
	return data;
}

function loadAux() { 
  	
	processArgs();
	if (gis.d<0) {
		$('#ctddata-xml').load('/data/xml/ctddata.xml', plotCTD)
	}
}

function WGStoCH(latLng) {
	// Axiliary values (% Bern)
  var lat = (latLng.lat()*3600 - 169028.66)/10000;
  var lng = (latLng.lng()*3600 - 26782.5)/10000;
	// Process X and Y
	x = 200147.07 + 308807.95 * lat + 3745.25 * Math.pow(lng,2) 
		+ 76.63 * Math.pow(lat,2) - 194.56 * Math.pow(lng,2) * lat + 119.79 * Math.pow(lat,3);
	y = 600072.37 + 211455.93 * lng - 10938.51 * lng * lat
	  - 0.36 * lng * Math.pow(lat,2) - 44.54 * Math.pow(lng,3);
	return [x, y];
}

function WGStoString(latLng) {
	var deg = [Math.floor(latLng.lat()), Math.floor(latLng.lng())];
	return [sprintf('%d&deg;%.3f\'',deg[0],60*(latLng.lat()-deg[0])),
					sprintf('%d&deg;%.3f\'',deg[1],60*(latLng.lng()-deg[1]))];
}

function interp(xx, yy, x) {
	return yy[0] + (x-xx[0])*(yy[1]-yy[0])/(xx[1]-xx[0])
}

function date2str(date) {
	var month = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
	return month[parseInt(date.slice(0,2),10)-1]+' '+parseInt(date.slice(3,5),10)+', 2011';
}

function time2sec(time) {
	var hms = time.split(':');
	return parseInt(hms[0],10)*3600 + parseInt(hms[1],10)*60 + ((hms.length>2)?parseInt(hms[2],10):0);
}

function sec2time(sec) {
	var h = Math.floor(sec/3600);
	var m = Math.floor((sec-3600*h)/60);
	return sprintf('%02d:%02d:%02d', h, m, sec-3600*h-60*m);
}

function time2latlng(d, m, sec) {
	var data = (gis.dayDataReady) ? data = gis.dayData[m] : gis.data[d][m];
	var pp = gis.data[d][m].polyline.getPath().b;
	for (var i=1; i<data.time.length-1; i++) if (sec < data.time[i]) break;
	var xx = [data.time[i-1], data.time[i]];
	return new google.maps.LatLng(interp(xx,[pp[i-1].lat(),pp[i].lat()],sec),
														    interp(xx,[pp[i-1].lng(),pp[i].lng()],sec));
}

function time2depth(d, m, sec) {
	var data = (gis.dayDataReady) ? data = gis.dayData[m] : gis.data[d][m];
	for (var i=1; i<data.time.length-1; i++) if (sec < data.time[i]) break;
	var xx = [data.time[i-1], data.time[i]];
	return [400-interp(xx,[data.nav[0][i-1][1],data.nav[0][i][1]],sec),
	 				400-interp(xx,[data.nav[1][i-1][1],data.nav[1][i][1]],sec)]
}

function hsla2rgba(h, s, l, a){
    var r, g, b;
    if(s == 0){
        r = g = b = l; // achromatic
    }else{
        function hue2rgb(p, q, t){
            if(t < 0) t += 1;
            if(t > 1) t -= 1;
            if(t < 1/6) return p + (q - p) * 6 * t;
            if(t < 1/2) return q;
            if(t < 2/3) return p + (q - p) * (2/3 - t) * 6;
            return p;
        }
        var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
        var p = 2 * l - q;
        r = hue2rgb(p, q, h + 1/3);
        g = hue2rgb(p, q, h);
        b = hue2rgb(p, q, h - 1/3);
    }
    //return [r * 255, g * 255, b * 255];
		return vsprintf('rgba(%d,%d,%d,%.2f)',[r*255, g*255, b*255, a]);
}

function strcmp(a, b)
{   
    return (a<b?-1:(a>b?1:0));  
}


