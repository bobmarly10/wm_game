jQuery ->

  Pusher.log = (message)->
    window.console.log(message) if window.console && window.console.log

  pusher = new Pusher('491056d6d06d1a84e5d5')
  channel = pusher.subscribe('chat')
  channel.bind 'message', (data)->
    $("#chat .messages").prepend $chat_message_json2html(data)
    $("#chat .messages").scrollTo '0%', 250




  $chat_message_json2html = (json)->
    $timestamp = $("<time />").data("timestamp", json.timestamp)
    if json.author_locale == 'sys'
      $author       = $("<span />").addClass("author").addClass(json.author_locale).text("#{json.author_name}, ").append($timestamp)
      $author_image = $("<img />").addClass("author_image").attr('src', $("#chat").data("sysimg"))
    else
      $author       = $("<span />").addClass("author").addClass(json.author_locale)
      $author.text("#{json.author_name} (#{json.author_points}), ").append($timestamp)
      $author_image = $("<img />").addClass("author_image").attr('src', json.author_image)
    $text         = $("<span />").addClass("text bubble").text json.html_body
    $("<div />").addClass("message").append($author).append($author_image).append($text)

  $("#chat").livequery ->
    $chat = $(this)
    $.each $chat.data("messages"), ->
      $("#chat .messages").append $chat_message_json2html(this)
    $("#chat .messages").scrollTo '0%', 250

  $("#chat .icons a").live "click", (e)->
    $text = $(this).attr "href"
    $("#chat form textarea").insertAtCaret $text
    e.preventDefault()

  $("#chat form").live "ajax:beforeSend", (e)->
    $(this).css
      opacity: 0.3

  $("#chat textarea").live "keydown", (e)->  
    if e.keyCode == 13 && !e.shiftKey
      $(this).closest("form").submit()
      e.preventDefault()


  #
  # helpers
  #

  jQuery.fn.extend
    insertAtCaret: (myValue)->
      this.each (i)->
        if document.selection
          # For browsers like Internet Explorer
          this.focus()
          sel = document.selection.createRange()
          sel.text = myValue
          this.focus()
        else if this.selectionStart || this.selectionStart == '0'
          # For browsers like Firefox and Webkit based
          startPos = this.selectionStart
          endPos = this.selectionEnd
          scrollTop = this.scrollTop
          this.value = this.value.substring(0, startPos)+myValue+this.value.substring(endPos,this.value.length)
          this.focus()
          this.selectionStart = startPos + myValue.length
          this.selectionEnd = startPos + myValue.length
          this.scrollTop = scrollTop
        else
          this.value += myValue
          this.focus()