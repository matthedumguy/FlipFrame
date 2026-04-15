function __flipframe_data(argument0, argument1, argument2, argument3, argument4) constructor
{
	if (argument4 != FLIPFRAME_INTERNAL_TOKEN)
		flipframe_throw("Do not return new __flipframe_data directly use flipframe_init")
	
	_struct =  {
		animsprite: asset_get_index(argument0),
		animcurframe: 0,
		animfinished: false,
		animtype: argument1,
		animloopstart: undefined,
		animloopend: undefined,
		animtoloop: undefined,
		animcallbackframe: [0],
		animcallback: [function(){}],
		animcalledback: [true],
		animspeed: undefined,
		animpxtoframes: FLIPFRAME_PIXELTOFRAMES,
		animxscale: 1,
		animyscale: 1,
		animuniqueid: flipframe_id_creator(),
	}
	
	if (argument1 == ANIM_TYPE.ONESHOT && argument2 != noone)
	{
		array_push(_struct.animcallbackframe, get_number())
		array_push(_struct.animcalledback, false)
		array_push(_struct.animcallback, argument2)
	}
	if (argument1 == ANIM_TYPE.FRAMELOOPED)
	{
		_struct.animloopstart = argument2
		_struct.animloopend = argument3
	}
	if (argument1 == ANIM_TYPE.TRANSITIONTO)
		_struct.animtoloop = argument2
	
	/// @param {Asset.GMSprite | string} sprite Sprite (or string) to animate
	/// @param {Enum.ANIM_TYPE} animation-type The animation type (LOOP, ONESHOT, FRAMELOOPED, TRANSITIONTO)
	/// @param {any} argument2 ONESHOT: Callback function | FRAMELOOPED: Loop start frame | TRANSITIONTO: Target sprite name
	/// @param {real} loop-end FRAMELOOPED only: loop end frame
	static animate = function(argument0, argument1, argument2 = noone, argument3 = noone)
	{
		var isToloop = ((_struct.animtoloop != argument2 || _struct.animsprite != _struct.animtoloop) && _struct.animtoloop != ANIM_TYPE.TRANSITIONTO)
		var notPlaying = _struct.animsprite != argument0 && isToloop
	
		if (notPlaying)
		{
			_struct.animsprite = asset_get_index(argument0)
			_struct.animcurframe = 0
			_struct.animfinished = false
			_struct.animtype = argument1
			_struct.animloopstart = undefined
			_struct.animloopend = undefined
			_struct.animtoloop = undefined
			_struct.animcallbackframe = [0]
			_struct.animcallback = [function(){}]
			_struct.animcalledback = [true]
			_struct.animspeed = undefined
			_struct.animpxtoframes = FLIPFRAME_PIXELTOFRAMES
			_struct.animxscale = 1
			_struct.animyscale = 1

	
			if (argument1 == ANIM_TYPE.ONESHOT && argument2 != noone)
			{
				array_push(_struct.animcallbackframe, get_number())
				array_push(_struct.animcalledback, false)
				array_push(_struct.animcallback, argument2)
			}
			if (argument1 == ANIM_TYPE.FRAMELOOPED)
			{
				_struct.animloopstart = argument2
				_struct.animloopend = argument3
			}
			if (argument1 == ANIM_TYPE.TRANSITIONTO)
				_struct.animtoloop = argument2
		}
	}
	
	/// @param animation_speed The speed to set
	/// @param pixels_to_speed Pixels to speed ratio 
	/// @param [delta_time] Delta time toggle in animation speed
	/// @return {real}
	static animation_speed = function(argument0 = -555, argument1 = FLIPFRAME_PIXELTOFRAMES, argument2 = false)
	{
		_struct.animspeed = (argument0 == -555) ? undefined : argument0
		_struct.animpxtoframes = argument1
	}
	
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
		array_push(_struct.animcallbackframe, get_number())
		array_push(_struct.animcalledback, false)
		array_push(_struct.animcallback, argument0)
	}
	
	/// @returns {Asset.GMSprite}
	static get_sprite = function()
	{
		return _struct.animsprite
	}
	
	static get_subimage = function()
	{
		return _struct.animcurframe
	}
	
	static get_number = function()
	{
		return sprite_get_number(_struct.animsprite) - 1
	}
}