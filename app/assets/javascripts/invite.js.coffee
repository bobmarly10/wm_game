jQuery ->

  FB.init
    appId: $("body").data('appid'),
    status: true,
    cookie: false,
    xfbml: true

  $('#invite_friends').click (event)->
    link = $(this)
    FB.ui {
      method: 'apprequests'
      message: link.data('message')
    }, (response)->
      $.ajax
        url: $('body').data('invitation-url')
        type: 'POST'
        data: { request_id: response.request, invited_users: response.to }
        dataType: 'script'

    event.preventDefault()
    #FB.ui {method: 'apprequests', message: 'My Great Request', }, (response)->
    #  $.ajax
    #    url: $('body').data('invitation-url'),
    #    type: 'POST',
    #    data: { request_id: response.request, invited_users: response.to },
    #    dataType: 'script'
    #return false