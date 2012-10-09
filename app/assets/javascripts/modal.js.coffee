jQuery ->
  $(".modal").hide()
  $(".modal-toggle").click (event)->
    id = $(this).attr("id")
    $("#" + id + "-modal").slideToggle(100)
    event.preventDefault()
