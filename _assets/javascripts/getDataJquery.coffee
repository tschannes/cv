$(document).ready ->

  ajaxCounter = 0
  stem = 'https://api.forecast.io/forecast/'
  key = '901f738ef524ecd81eafcead2fd6389b/'
  loc = ''#'47.0441453,8.2971598'
  params = '?lang=de&units=ca'
  url = stem + key + loc + params

  dateString = (dateObject) ->
    date = 
      fullDate: ''
      day: ''
    months = [
      'Januar'
      'Februar'
      'März'
      'April'
      'Mai'
      'Juni'
      'Juli'
      'August'
      'September'
      'Oktober'
      'November'
      'Dezember'
    ]
    days = [
      'Sonntag'
      'Montag'
      'Dienstag'
      'Mittwoch'
      'Donnerstag'
      'Freitag'
      'Samstag'
    ]
    date.fullDate = dateObject.getDate() + '. ' + months[dateObject.getMonth()] + ' ' + dateObject.getFullYear()
    date.day = days[dateObject.getDay()]
    date

  newURL = (loc) ->
    newLoc = loc
    url = stem + key + loc + params

  speedHelper = (num) ->
    color = "<span style='color:white;background-color:red'>" + num + "</span>" if num > 20
    color = "<span style='color:white;background-color:orange'>" + num + "</span>" if num > 10
    color = "<span style='color:white;background-color:green'>" + num + "</span>" if num > 0
    color

  directionHelper = (num) ->
    arrow = " </br>Wind: <img src='/images/arrow.svg' style='display:inline-block;color:purple;width:1em;height:1em;-ms-transform: rotate(" + num + "deg); /* IE 9 */-webkit-transform: rotate(" + num + "deg); /* Safari */transform: rotate(" + num + "deg);'></img> "

  handler = (data) ->
    console.log data
    date = new Date(data.hourly.data[0].time * 1000)
    dateSummary = data.hourly.summary
    forecast = ''
    daily = data.daily.data 
    i = 0
    while i <= daily.length - 1
      timestamp = new Date(daily[i].time * 1000)
      forecast = forecast.concat('<li><b>' + dateString(timestamp).day + '</b>: ' + daily[i].summary + directionHelper(daily[i].windBearing) + speedHelper(daily[i].windSpeed) + ' km\/h.' + '</li>')
      i++
    $('p.wetter').append '<ul>' + forecast + '</ul>'
    data.forecast = forecast
    window.data = data
  
  $('#tglBtn').on 'click', (e) ->

    getLocation = ->
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition (position) ->
          loc = position.coords.latitude + "," + position.coords.longitude
          makeRequest(newURL(loc))
      else
        alert 'Geolocation is not supported by this browser.'
      return
  
    makeRequest = (url) ->
      #CORS in vanilla javascript
      ###
      xhr = new XMLHttpRequest
      xhr.onreadystatechange = ->
        data = xhr.responseText
        alert xhr.responseStatus
        handler data
      xhr.open 'GET', url
      xhr.withCredentials = true
      xhr.setRequestHeader 'Content-Type', 'text/plain'
      xhr.send 'data'
      ajaxCounter += 1
      ###
      #JSONP in vanilla javascript
      ###
      window.myJsonpCallback = data ->
        alert data
        handler data
        ajaxCounter += 1
      scriptEl = document.createElement 'script'
      scriptEl.setAttribute('src', url + '?callback=myJsonpCallback')
      document.body.appendChild(scriptEl);
      ###
      #JSONP in jquery
      
      $.ajax
        url: url
        dataType: 'jsonp'
        success: (data) ->
          handler data 
          $('#loader').hide()
          return
        error: (exception) ->
          console.log 'Exeption: ' + exception
          return
        ajaxCounter += 1
      return
    getLocation() if ajaxCounter < 1

  return