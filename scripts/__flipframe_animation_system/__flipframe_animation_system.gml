function __flipframe_animation_system()
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
	
	var _animname = "__" + string(_uniqueid)
	
    var frames = sprite_get_number(_spr) - 1;
	var names = sprite_get_name(_spr);
    var speeds = sprite_get_speed(_spr);
    var speedtype = sprite_get_speed_type(_spr);

	if (FLIPFRAME_DEBUG)
		flipframe_log(string(_uniqueid) + "_frame: " + string(cur_frame))
	
	if (_animtype != FLIPFRAME_ANIMTYPE.PINGPONG)
		_sprstruct.animcurframe += _animspeed;
	else
	{
		if (!_sprstruct.animreversed)
		{
			_sprstruct.animcurframe += _animspeed;
			if (_sprstruct.animcurframe >= frames)
				_sprstruct.animreversed = true;
		}
		else
		{
			_sprstruct.animcurframe -= _animspeed;
			if (_sprstruct.animcurframe <= frames)
				_sprstruct.animreversed = false;
		}
	}
	
	#region Animation types handling
	if (_animtype == FLIPFRAME_ANIMTYPE.FRAMELOOPED)
	{
		if (_sprstruct.animcurframe >= _loopend)
			_sprstruct.animcurframe = _loopstart;
	}
			
	if (_animtype == FLIPFRAME_ANIMTYPE.TRANSITIONTO)
	{
		if (_sprstruct.animcurframe >= frames)
		{
			_sprstruct.animcurframe = 0;
			_sprstruct.animtype = 0;
			_sprstruct.animsprite = _toloop;
			_spr = _toloop;
			frames = sprite_get_number(_spr) - 1;
		}
	}
	
	if (_sprstruct.animcurframe >= frames && _animtype != FLIPFRAME_ANIMTYPE.FRAMELOOPED && _animtype != FLIPFRAME_ANIMTYPE.TRANSITIONTO)
	{
		_sprstruct.animfinished = true;
		if (_animtype == FLIPFRAME_ANIMTYPE.ONESHOT)
		{
			_sprstruct.animcurframe = frames;
		}
		else
			_sprstruct.animcurframe = 0;
	}
	#endregion
	
	for (var i = 0; i < array_length(_callback); i++) 
	{
		var __callback = _callback[i];
		var __calledback = _sprstruct.animcalledback[i];
		var __callbackframe = _sprstruct.animcallbackframe[i];
		
		if (!__calledback && _sprstruct.animcurframe == __callbackframe)
		{
			_sprstruct.animcalledback = true;
			__callback()
			flipframe_log("Callback activated : ", __callback, " for frame : ", __callbackframe);
		}
	}
	
	cur_frame = _sprstruct.animcurframe;
    draw_sprite_ext(_spr, floor(cur_frame), argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7]);
}
