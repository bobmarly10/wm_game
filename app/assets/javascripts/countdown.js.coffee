jQuery ->

  $delay = (ms, func) -> setTimeout func, ms

  time_is_up = ->
    $delay 1000, ->
      $.ajax
        url: $("#games").data('url'),
        type: "get",
        dataType: "html",
        success: (data)->
          $("#games ol.games").html(data)
      $.ajax
        url: $("#current_games_container").data('url'),
        type: "get",
        dataType: "html",
        success: (data)->
          $("#next_game").hide();
          $("#current_games_container").show().html(data)

  $("#countdown").livequery ->
    cd = $(this)
    cd.jCountdown
      timeText: cd.data("timestamp"),
      timeZone: cd.data("timezone"),
      style:"flip",
      color:"black",
      width:0,
      textGroupSpace:10,
      textSpace:0,
      reflection:false,
      reflectionOpacity:10,
      reflectionBlur:0,
      dayTextNumber:2,
      displayDay:true,
      displayHour:true,
      displayMinute:true,
      displaySecond:true,
      displayLabel:false,
      onFinish: time_is_up
    cd.find('.group.day').append $('<div />').addClass('lbl').text(cd.data('days'))
    cd.find('.group.hour').append $('<div />').addClass('lbl').text(cd.data('hours'))
    cd.find('.group.minute').append $('<div />').addClass('lbl').text(cd.data('minutes'))
    cd.find('.group.second').append $('<div />').addClass('lbl').text(cd.data('seconds'))
