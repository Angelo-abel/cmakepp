function(log_default_handler)
  event_addhandler(on_log_message "[](msg) message(FORMAT '{msg.function}> {msg.message}') ")
  ans(handler)
  return(${handler})
endfunction()