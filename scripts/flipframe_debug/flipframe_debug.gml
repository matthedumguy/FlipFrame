function flipframe_log()
{
	var _message = "FlipFrame {0} Debug Log: "
	
	for (var i = 0; i < argument_count; i++)
		_message += string(argument[i])

	return show_debug_message(_message)
}

function flipframe_throw()
{
	var _error = "FlipFrame {0} : "
	
	for (var i = 0; i < argument_count; i++)
		_error += string(argument[i], FLIPFRAME_VERSION)

	clipboard_set_text(_error)
	game_end()
	show_message(_error)
}

function flipframe_id_creator()
{
	static _flipframe_id = 1000000;
	
	return _flipframe_id++
	
}