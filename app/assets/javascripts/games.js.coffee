jQuery ->

  $game_has_ended = ->
    if $("#current_games_container .game").length > 1
      $.ajax
        url: $("#current_games_container").data('url'),
        type: "get",
        dataType: "html",
        success: (data)->
          $("#current_games_container").html(data)
    else
      $.ajax
        url: $("#next_game").data('url'),
        type: "get",
        dataType: "html",
        success: (data)->
          $("#current_games_container").addClass("hidden")
          $("#next_game").removeClass("hidden").html(data)
    $.ajax
      url: $("#past_games").data('url'),
      type: "get",
      dataType: "html",
      success: (data)->
        $("#past_games").removeClass("hidden").html(data)
    $("#ranking").data "dirty", "yes"

  pusher = new Pusher('491056d6d06d1a84e5d5')
  channel = pusher.subscribe('games')
  channel.bind 'score', (data)->
    $.each data, ->
      $game = this
      $games_ended = 0
      if $game.ended
        $games_ended += 1
      else
        $("#game_#{$game.game_id} .goals_a .value").text $game.team_a
        $("#game_#{$game.game_id} .goals_b .value").text $game.team_b
      $game_has_ended() if $games_ended > 0