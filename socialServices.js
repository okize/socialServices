$(window).on('load', function() {
	
	'use strict';
	
	// servicesCache? stores loaded scripts?
	
	var getSocialServices = {

		serviceScripts: {
			plusone: {
				url: 'https://apis.google.com/js/plusone.js',
				isLoaded: false
			},
			twitter: {
				url: 'http://platform.twitter.com/widgets.js',
				isLoaded: false
			},
			facebook: {
				url: 'http://static.ak.fbcdn.net/connect.php/js/FB.Share',
				isLoaded: false
			},
			linkedin: {
				url: 'http://platform.linkedin.com/in.js',
				isLoaded: false
			},
			addthis: {
				url: 'http://s7.addthis.com/js/250/addthis_widget.js',
				isLoaded: false
			}
		},

		getDeferreds: function(arr) {

			var deferreds = [];

			for (var i = 0, length = arr.length; i < length; i++) {

				if (!this.serviceScripts[arr[i]].isLoaded) {
					deferreds.push( this.loadScript(arr[i]) );
				} else {
					console.log('script already loaded', 'info');
				}

			}

			return deferreds;

		},

		loadScript: function (type) {

			return $.ajax({
				url: this.serviceScripts[type].url,
				dataType: 'script',
				cache: true
			}).success(
				function () {
					getSocialServices.serviceScripts[type].isLoaded = true;
				});

		}

	};
		
	var someButtons = ['twitter', 'plusone', 'facebook', 'linkedin', 'addthis'];
	
	$.when.apply($, getSocialServices.getDeferreds(someButtons)).done(
		
		function(args1) {
			if (console.group) {
				console.group('google:');
				console.log(window.gapi);
				console.groupEnd();
				console.group('twitter:');
				console.log(window.twttr);
				console.groupEnd();
				console.group('facebook:');
				console.log(window.FB);
				console.groupEnd();
				console.group('linkedin:');
				console.log(window.IN);
				console.groupEnd();
				console.group('addthis:');
				console.log(window.addthis);
				console.groupEnd();
			}

	});

});