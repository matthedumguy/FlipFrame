function __flipframe_struct() constructor{
	static starting_frame = function(argument0)
	{
		__sprite_struct.animcurframe = argument0
	}
	
	static frame_callback = function(argument0, argument1)
	{
		array_push(__sprite_struct.animcallbackframe, argument0)
		array_push(__sprite_struct.animcalledback, false)
		array_push(__sprite_struct.animcallback, argument1)
	}
	
	static on_started = function(argument0)
	{
		array_push(__sprite_struct.animcallbackframe, 0)
		array_push(__sprite_struct.animcalledback, false)
		array_push(__sprite_struct.animcallback, argument0)
	}
	
	static on_finished = function(argument0)
	{
		array_push(__sprite_struct.animcallbackframe, sprite_get_number(__sprite_struct.animsprite))
		array_push(__sprite_struct.animcalledback, false)
		array_push(__sprite_struct.animcallback, argument0)
	}
}