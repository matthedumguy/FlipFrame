function __flipframe_struct() constructor{
	static starting_frame = function(argument0)
	{
		_struct.animcurframe = argument0
	}
	
	static frame_callback = function(argument0, argument1)
	{
		array_push(_struct.animcallbackframe, argument0)
		array_push(_struct.animcalledback, false)
		array_push(_struct.animcallback, argument1)
	}
	
	static on_started = function(argument0)
	{
		array_push(_struct.animcallbackframe, 0)
		array_push(_struct.animcalledback, false)
		array_push(_struct.animcallback, argument0)
	}
	
	static on_finished = function(argument0)
	{
		array_push(_struct.animcallbackframe, sprite_get_number(_struct.animsprite))
		array_push(_struct.animcalledback, false)
		array_push(_struct.animcallback, argument0)
	}
}