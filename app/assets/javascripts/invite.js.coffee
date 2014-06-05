jQuery ->

  FB.init
    appId: $("body").data('appid'),
    status: true,
    cookie: true,
    xfbml: true

  $(document).on 'click', '#invite_friends', (event)->
    link = $(this)
    console.log(link.data('message'))
    console.log($('body').data('invitation-url'))
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