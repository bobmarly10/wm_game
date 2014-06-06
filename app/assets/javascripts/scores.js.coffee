jQuery ->

  pusher = new Pusher('491056d6d06d1a84e5d5')
  channel = pusher.subscribe('scores')
  channel.bind 'update', (data)->
    $("#ranking").data "dirty", "yes"
