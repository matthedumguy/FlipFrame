function flipframe_log()
{
	var _message = "FlipFrame " + FLIPFRAME_VERSION + " Debug Log: "
	
	for (var i = 0; i < argument_count; i++)
		_message += string(argument[i])

	return show_debug_message(_message)
}

function flipframe_throw()
{
	var _error = "FlipFrame " + FLIPFRAME_VERSION + " : "
	
	for (var i = 0; i < argument_count; i++)
		_error += string(argument[i])

	clipboard_set_text(_error)
	game_end()
	show_message(_error)
}