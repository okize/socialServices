$(window).on "load", ->
  "use strict"
  
  # servicesCache? stores loaded scripts?
  getSocialServices =
    serviceScripts:
      plusone:
        url: "https://apis.google.com/js/plusone.js"
        isLoaded: false

      twitter:
        url: "http://platform.twitter.com/widgets.js"
        isLoaded: false

      facebook:
        url: "http://static.ak.fbcdn.net/connect.php/js/FB.Share"
        isLoaded: false

      linkedin:
        url: "http://platform.linkedin.com/in.js"
        isLoaded: false

      addthis:
        url: "http://s7.addthis.com/js/250/addthis_widget.js"
        isLoaded: false

    getDeferreds: (arr) ->
      deferreds = []
      i = 0
      length = arr.length

      while i < length
        unless @serviceScripts[arr[i]].isLoaded
          deferreds.push @loadScript(arr[i])
        else
          console.log "script already loaded", "info"
        i++
      deferreds

    loadScript: (type) ->
      $.ajax(
        url: @serviceScripts[type].url
        dataType: "script"
        cache: true
      ).success ->
        getSocialServices.serviceScripts[type].isLoaded = true


  someButtons = ["twitter", "plusone", "facebook", "linkedin", "addthis"]
  $.when.apply($, getSocialServices.getDeferreds(someButtons)).done (args1) ->
    if console.group
      console.group "google:"
      console.log window.gapi
      console.groupEnd()
      console.group "twitter:"
      console.log window.twttr
      console.groupEnd()
      console.group "facebook:"
      console.log window.FB
      console.groupEnd()
      console.group "linkedin:"
      console.log window.IN
      console.groupEnd()
      console.group "addthis:"
      console.log window.addthis
      console.groupEnd()


