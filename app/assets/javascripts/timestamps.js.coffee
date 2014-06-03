jQuery ->

  $interval = (ms, func) -> setInterval func, ms

  $interval 1000, ->
    $.each $("time"), ->
      $(this).text moment.unix( $(this).data("timestamp") ).fromNow()
  