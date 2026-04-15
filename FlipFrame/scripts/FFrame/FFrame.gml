//Testing an animation system made by me(MatTheDumGuy)

#macro FLIPFRAME_PIXELTOFRAMES 2.5
#macro FLIPFRAME_DEBUG false
#macro FLIPFRAME_INTERNAL_TOKEN "ÑÇ¡"

enum FLIPFRAME_ANIMTYPE
{
	LOOP = 0,
	ONESHOT,
	FRAMELOOPED,
	TRANSITIONTO
}

function flipframe(sprite_index, x, y)
{
	__flipframe_animated_system(sprite_index, x, y, 1, 1, 0, c_white, 1);
}

function flipframe_ext(sprite_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
{
	__flipframe_animated_system(sprite_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha) 
}

function __flipframe_animated_system()
{
	var _sprstruct = argument[0]._struct
	
	if (!is_struct(_sprstruct))
		flipframe_throw("argument0 in the FlipFrame draw function is not a FlipFrame struct but is ", _sprstruct)
		
	var _spr = sprite_exists(_sprstruct.animsprite) ? _sprstruct.animsprite : undefined
	var _callback = _sprstruct.animcallback
	var _animtype = _sprstruct.animtype
	var _loopstart = _sprstruct.animloopstart
	var _loopend = _sprstruct.animloopend
	var _toloop = _sprstruct.animtoloop
	var _animxscale = _sprstruct.animxscale
	var _animyscale = _sprstruct.animyscale
	var _animspeed = _sprstruct.animspeed
	var cur_frame = _sprstruct.animcurframe
	var _uniqueid = _sprstruct.animuniqueid
	var _pixelstoframes = _sprstruct.animpxtoframes
	
	var _animname = "__" + string(_uniqueid)
	
    var frames = sprite_get_number(_spr) - 1;
	var names = sprite_get_name(_spr)
    var speeds = sprite_get_speed(_spr);
    var speedtype = sprite_get_speed_type(_spr);

	if (FLIPFRAME_DEBUG)
		flipframe_log(string(_uniqueid) + "_frame: " + string(cur_frame))
	
    if (speeds > 0)
    {
			if (is_undefined(_animspeed))
				_sprstruct.animcurframe += (speedtype == 1) ? speeds : speeds / game_get_speed(gamespeed_fps);
			else
				_sprstruct.animcurframe += _animspeed / (_animspeed * _pixelstoframes)
				
			if (_animtype == FLIPFRAME_ANIMTYPE.FRAMELOOPED)
			{
				if (_sprstruct.animcurframe >= _loopend)
					_sprstruct.animcurframe = _loopstart
			}
			
			if (_animtype == FLIPFRAME_ANIMTYPE.TRANSITIONTO)
			{
				if (_sprstruct.animcurframe >= frames)
				{
					_sprstruct.animcurframe = 0
					_sprstruct.animtype = 0
					_sprstruct.animsprite = _toloop
					_spr = _toloop
					frames = sprite_get_number(_spr) - 1
				}
			}
			if (_sprstruct.animcurframe >= frames && _animtype != FLIPFRAME_ANIMTYPE.FRAMELOOPED && _animtype != FLIPFRAME_ANIMTYPE.TRANSITIONTO)
			{
				_sprstruct.animfinished = true
				if (_animtype == FLIPFRAME_ANIMTYPE.ONESHOT)
				{
					_sprstruct.animcurframe = frames
				}
				else
					_sprstruct.animcurframe = 0
			}
			
			for (var i = 0; i < array_length(_callback); i++) 
			{
				var __callback = _callback[i]
				var __calledback = _sprstruct.animcalledback[i]
				var __callbackframe = _sprstruct.animcallbackframe[i]
				if (!__calledback && _sprstruct.animcurframe == __callbackframe)
				{
					_sprstruct.animcalledback = true
					__callback()
					flipframe_log("Callback activated : ", __callback, " for frame : ", __callbackframe)
				}
			}
    }
	cur_frame = _sprstruct.animcurframe
    draw_sprite_ext(_spr, floor(cur_frame), argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7]);
}

function flipframe_init(argument0, argument1, argument2 = noone, argument3 = noone)
{
	return new __flipframe_data(argument0, argument1, argument2, argument3, FLIPFRAME_INTERNAL_TOKEN)	
}

function flipframe_log()
{
	var _message = "FlipFrame Debug Log: "
	
	for (var i = 0; i < argument_count; i++)
		_message += string(argument[i])

	return show_debug_message(_message)
}

function flipframe_throw()
{
	var _error = "FlipFrame : "
	
	for (var i = 0; i < argument_count; i++)
		_error += string(argument[i])

	clipboard_set_text(_error)
	game_end()
	show_message(_error)
}

function flipframe_id_creator()
{
	static _flipframe_id = 1000000;
	
	return _flipframe_id++
	
}