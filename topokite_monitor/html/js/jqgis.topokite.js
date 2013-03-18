(function ($) {
	var self = this;
	function ROS(placeholder, options) {
		var status = {}, position = {}, orientation = {}, control = {},
			droneId = options.id,
			timeout = 100,
			url = (options.rosURL) ? options.rosURL : 'ws://'+gis.baseURL+':9090';
		var connection = new ros.Connection(url);
		connection.setOnClose(function (e) {
			$('#ros-link').css('fill', '#aaa', 'stroke', '#aaa');
		});
		connection.setOnError(function (e) {
			$('#ros-link').css('stroke', 'red');
		});
		connection.setOnOpen(function (e) {
			$('#ros-link tspan').css('stroke', '#0f0');
			try {
				connection.addHandler('/topokite/monitor_slow', function(msg) {
					$.gis.sync({
						id: droneId, type: 'point',
						status: msg,
						position: {
							lat: msg.latitude,
							lng: msg.longitude,
							alt: msg.altitude,
							agl: msg.pressure_height,
							spd: Math.sqrt(Math.pow(msg.velocity_x,2)+Math.pow(msg.velocity_y,2))
						}
					})
				});
				connection.callService('/rosjs/subscribe', '["/topokite/monitor_slow",-1]', function(e) {
					console.log('Registering service "/topokite/monitor_slow": '+e)
				});
			} catch (error) {
			  	console.error('Problem registering handler! 2');
			  	return;
			}
			try {
				connection.addHandler('/topokite/monitor_fast', function(msg) {
					$.gis.sync({
						id: droneId, type: 'point',
						control: {
							roll: msg.control_axes[0],
							pitch: msg.control_axes[1],
							yaw: msg.control_axes[2],
							thrust: msg.control_axes[3]
						}
					})
				});
				connection.callService('/rosjs/subscribe', '["/topokite/monitor_fast",-1]', function(e) {
					console.log('Registering service "/topokite/monitor_fast": '+e)
				});
			} catch (error) {
			  	console.error('Problem registering handler! 2');
			  	return;
			}
		});
		$.gis.connection = connection;
		$.gis.sensors = { position: position, orientation: orientation }
		return {
			connection: connection
		}
	}
	$.gis.ros = function(placeholder, options) {
		var ros = new ROS(placeholder, options);
		$.gis.plugins.push(ros);
		return ros
	}
	$.gis.ros.version = 0.1
})(jQuery);

(function ($) {
	function PFD(placeholder, options) {
		var droneId = options.id,
			readyFlags = { roll: true, horizon: true, agl: true, speed: true, controlCross: true },
			zeroX, zeroY, battery, cpu,
			animTimeout = 80;
		$('#'+placeholder).load("topokite.pfd.svg", function(){
			$(this).wrapInner('<svg><g id="pfd-box" transform="scale(1 1)">');
			zeroX = $('#zero').attr('x');
			zeroY = $('#zero').attr('y');
			battery = { name: 'battery',
				Y: parseFloat($('#battery-bar').attr('y'))+parseFloat($('#battery-bar').attr('height')),
				max: 12.5, min: 9.0, thrY: 11, thrR: 10, s: 1, format: '%.1f' };
			battery.H = parseFloat($('#battery-bar').attr('height'))/(battery.max-battery.min);
			cpu = { name: 'cpu',
				Y: parseFloat($('#cpu-bar').attr('y'))+parseFloat($('#cpu-bar').attr('height')),
				max: 100, min: 0, thrY: 60, thrR: 80, s: -1, format: '%d' };
			cpu.H = parseFloat($('#cpu-bar').attr('height'))/(cpu.max-cpu.min);
			gps = { name: 'gps',
					states:   [ { status: 'GPS fix', label: 'GPS', color: '#00ff00' },
					 			{ status: 'GPS no fix', label: 'GPS', color: 'red'},
								{ status: 'default', label: 'GPS', color: 'red'} ] };
			flight_mode = { name: 'flight-mode',
					states:   [ { status: 'Acc', label: 'Acc', color: '#f00' },
								{ status: 'Height', label: 'Height', color: '#ff0' },
								{ status: 'GPS', label: 'GPS', color: '#0f0'} ] };
			serial_control = { name: 'serial-control',
					states:   [ { status: true, label: 'CTRL', color: '#aaa' },
								{ status: false, label: 'CTRL', color: '#f00' } ] }
		});
		function setBar(bar, value) {
			$('#'+bar.name+'-value tspan').text(sprintf(bar.format, value));
			var fill = (bar.s*value<bar.s*bar.thrR)?'#ff0000':(bar.s*value<bar.s*bar.thrY)?'#ffff00':'#00ff00';
			$('#'+bar.name+'-bar').css({ fill: fill });
			var h = bar.H*(value-bar.min);
			$('#'+bar.name+'-bar').attr('height', h).attr('y', bar.Y-h)
		}
		function setStatus(indicator, status, param) {
			$(indicator.states).each(function() {
				if (this.status==status) {
					var label = this.label;
					if (param) label = label+'('+param+')';
					$('#'+indicator.name+'-status').text(label).css({ fill: this.color, stroke: this.color })
				}
			})
		}
		sync = function(s) {
			// LL Status
			if (s.status) {
				if (s.status.battery_voltage) setBar(battery, s.status.battery_voltage);
				if (s.status.cpu_load) setBar(cpu, s.status.cpu_load);
				if (s.status.gps_status) setStatus(gps, s.status.gps_status, s.status.gps_num_satellites);
				if (s.status.flight_mode_ll) setStatus(flight_mode, s.status.flight_mode_ll);
				setStatus(serial_control, s.status.serial_interface_enabled)
			}
			// Position
			if (s.position) {
				try {
					$('#lat').html(sprintf('%.5f \'N', s.position.lat));
					$('#lon').html(sprintf('%.5f \'E', s.position.lng));
				} catch(e) {}
				if (readyFlags.speed) try {
					readyFlags.speed = false;
					$('#speed-value tspan').text(sprintf('%.1f', s.position.spd));
					$('#speed').animate({ svgTransform: 'translate(0,'+ s.position.spd*50+')' }, animTimeout,
						function(){ readyFlags.speed = true })
				} catch(e) {}
				if (readyFlags.agl) try {
					readyFlags.agl = false;
					$('#alt-value tspan').text(sprintf('%.1f', s.position.alt));
					$('#agl-value tspan').text(sprintf('%.1f', s.position.agl));
					$('#alt-scale').animate({ svgTransform: 'translate(0,'+ s.position.agl*5 +')' }, animTimeout,
						function(){ readyFlags.agl = true });
				} catch (e) {}
			}
			// Orientation
			if (s.orientation) {
				if (readyFlags.roll) {
					readyFlags.roll = false;
					$('#roll').animate({ svgTransform: 'rotate('+ s.orientation.roll+' '+zeroX+' '+zeroY+')' }, 
						animTimeout, function(){ readyFlags.roll = true });
				}
				if (readyFlags.horizon) {
					readyFlags.horizon = false;
					$('#horizon').animate({ svgTransform: 'translate(0,'+ -s.orientation.pitch*4+') '+
						'rotate('+s.orientation.roll+' '+zeroX+' '+zeroY+')' }, animTimeout,
																			function(){ readyFlags.horizon = true });
				}
			}
			// Control
			if (s.control) {
				if (readyFlags.controlCross) {
					readyFlags.controlCross = false;
					$('#control-arrow').animate({ svgTransform: 'translate(0,'+ (s.control.pitch-2048)/30+') '+
						'rotate('+(-s.control.roll+2048)/50+' '+zeroX+' '+zeroY+')' }, animTimeout,
																			function(){ readyFlags.controlCross = true });
				}
			}
		}
		return {
			sync: sync
		}
	}
	$.gis.pfd = function(placeholder, options) {
		var pfd = new PFD(placeholder, options);
		$.gis.plugins.push(pfd);
		return pfd
	}
	$.gis.pfd.version = 0.1
})(jQuery);

(function ($) {
	function Compass(placeholder, options) {
		var droneId = options.id,
			readyFlags = { compass: true, control: true },
			cmpssX, cmpssY,
			animTimeout = 100,
			lastMag = -999;
		$('#'+placeholder).load("topokite.pfd.compass.svg", function(){
			$(this).wrapInner('<svg><g id="compass-box" opacity=1 transform="scale(1 1)">');
				cmpssX = $('#compass-disk').attr('sodipodi:cx');
				cmpssY = $('#compass-disk').attr('sodipodi:cy');
		});
		var sync = function(s) {
			if (s.id == droneId && readyFlags.compass && s.orientation && s.orientation.mag) {
				if (readyFlags.compass) {
					readyFlags.compass = false;
					var mag;
					if (lastMag == -999) mag = s.orientation.mag;
					else if (s.orientation.mag - lastMag > 180) mag = s.orientation.mag - 360;
					else if (lastMag - s.orientation.mag > 180) mag = s.orientation.mag + 360;
					else mag = s.orientation.mag;
					$('#compass-value tspan').text(sprintf('%d', s.orientation.mag));
					$('#compass-scale').animate({ svgTransform: 'rotate('+ -mag +' '+cmpssX+' '+cmpssY+')' }, 
						animTimeout, function(){ readyFlags.compass = true });
					lastMag = mag;
				}
				if (readyFlags.control) {
					readyFlags.control = false;
					$('#compass-control').animate({ svgTransform: 'rotate('+ -(s.control.yaw-2048)/20 +' '+cmpssX+' '+cmpssY+')' }, 
						animTimeout, function(){ readyFlags.control = true });
				}
			}
		}
		return {
			sync: sync
		}
	}
	$.gis.compass = function(placeholder, options) {
		var compass = new Compass(placeholder, options);
		$.gis.plugins.push(compass);
		return compass
	}
	$.gis.compass.version = 0.1
})(jQuery);

(function ($) {
	function Camera(placeholder, options) {
		var camId = options.id,
			camIdx = (options.idx) ? options.idx : 0,
			idx = 0,
			rosTopic = (options.rosTopic) ? options.rosTopic : 'http://topoquad:8080/stream?topic=/ueyecam/preview';
		$('#'+placeholder).append('<img src="' + rosTopic + '?width=320?height=240"/>');
		$(document).on('mission-ready', function(){ 
			$('.save-image').css('background-color','#8f8').on('click', function(){
				$.gis.connection.callService('/ueyecam/save_image', '["auto"]', function(rsp) {
					var imageId = camId + '-frame' + (idx++);
					$.gis.add({ id: imageId, type: 'polygon', options: { color: 'red' },
							path: gis.camProjection.getProjection($.gis.sensors) })
				})
			})
		});
		$('#' + placeholder + ' img').on('error', function(){ 
			$('.save-image').css('background-color','#f88') 
			$(placeholder).css('background-color','#faa').html('<span class="error">IMAGE NOT AVAILABLE</span>');
		})
	}
	$.gis.camera = function(placeholder, options) {
		var camera = new Camera(placeholder, options);
		$.gis.plugins.push(camera);
		return camera
	}
	$.gis.camera.version = 0.1
})(jQuery);

(function ($) {
	function CamProjection(placeholder, options) {
		var droneId = (options.droneId) ? options.droneId : 'drone',
			camId = (options.camId) ? options.camId : 'cam',		
			getProjection = function(cam) {
				var path = [],
					corners = [[15,-20],[15,20],[-15,20],[-15,-20]],
					pitch = cam.orientation.pitch;
				for (p in corners) {
					var agl = 50 + cam.position.agl;
					a = cam.position.agl / Math.cos((cam.orientation.roll+corners[p][1])/180*Math.PI)
										* Math.tan((pitch+corners[p][0])/180*Math.PI);
					b = cam.position.agl / Math.cos((pitch+corners[p][0])/180*Math.PI) 
										* Math.tan((cam.orientation.roll+corners[p][1])/180*Math.PI);
					yaw = cam.orientation.mag/180*Math.PI;
					x = (a * Math.cos(yaw) + b * Math.sin(yaw))/100000 + cam.position.lat;
					y = (a * Math.sin(yaw) - b * Math.cos(yaw))/100000 + cam.position.lng;
					path.push({ lat: x, lng: y });
				}
				return path
			},
			sync = function(s) {
				if (s.id == droneId && s.position && s.orientation) {
					$.gis.sync({ id: droneId+'-'+camId, type: 'polygon', path: getProjection(s) })
				}
			}
		return {
			sync: sync
		}
	}
	$.gis.camProjection = function(placeholder, options) {
		var projection = new CamProjection(placeholder, options);
		$.gis.plugins.push(projection);
		return projection
	}
	$.gis.camProjection.version = 0.1
})(jQuery);
