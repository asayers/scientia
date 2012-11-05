jQuery ->
  $(".alert").hide().fadeIn()
  $(".alert").click( ->
    $(this).fadeOut()
  )
  
  setTimeout ( ->
    $(".alert").fadeOut()
  ), 3000
  
  $(".modal").hide()
  $(".modal-toggle").click (event) ->
    id = $(this).attr("id")
    $("#" + id + "-modal").slideToggle(100)
    event.preventDefault()
