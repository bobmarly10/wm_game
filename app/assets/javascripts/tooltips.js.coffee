
jQuery ->

  $('a[title], div[title], span[title]').livequery ->
    $(this).tipsy
      fade: true,
      gravity: 'n',
      html: true