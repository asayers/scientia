jQuery ->
  $(".alert").hide().fadeIn()
  
  setTimeout ( ->
    $(".alert").fadeOut()
  ), 3000
  
  $(".alert").click( ->
    $(this).fadeOut()
  )
