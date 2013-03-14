(function($){

	$g = $.g = $gis = $.gis = function(selector) {
		return $($.gis.visElementsDescription).find(selector)
	};
	$.extend($.gis, {
		plugins: [], 
		visElements: [], 
		visElementsDescription: '<xml></xml>', 
		dataSets: [],
		sync: function(s) {
			$(this.plugins).each(function(){ if (this.sync) this.sync(s) })
		},
		add: function(obj) {
			$(this.plugins).each(function(){ if (this.add) this.add(obj) })
		},
		remove: function(obj) {
			$(this.plugins).each(function(){ if (this.remove) this.remove(obj) })
		},
		load: function(options) {
			$(this.plugins).each(function(){ if (this.load) this.load(options) })
		}
	})

	$(['show','hide','highlight','unhighlight','select','deselect']).each( overload );
	
	function overload(fn_idx, fn_name) {
		var jq_fn = $.fn[fn_name];
		$.fn[fn_name] = function(a,b,c,d) {
			console.log(a,b,c,d);
			$(this).each(function(){
				if ($.gis.visElements[$(this).attr('id')]) return $.gis.visElements[$(this).attr('id')][fn_name]();
				else return jq_fn.apply(this, a,b,c,d)
			})
		}
	}

})(jQuery);

