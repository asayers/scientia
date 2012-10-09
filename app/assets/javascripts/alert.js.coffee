jQuery ->
  $(".alert").hide().fadeIn()
  
  $(".alert").click( ->
    $(this).fadeOut()
  )
