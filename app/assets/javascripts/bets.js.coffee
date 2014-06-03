jQuery ->

  $(".game.pending .button a").live "click", (event)->
    $(this).closest(".button").hide().next().show()
    event.preventDefault()

  $(".game.pending .bet_form form").on "submit", (event)->
    $(this).css
      opacity: .5
