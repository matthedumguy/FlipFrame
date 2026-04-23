function __flipframe_flick_data(argument0) constructor
{
	
	__sprite_struct =  {
		animsprite: asset_get_index(argument0),
		animcurframe: 0,
		animfinished: false,
		animogsprite: asset_get_index(argument0),
		animtype: FLIPFRAME_ANIMTYPE.LOOP,
		animloopstart: undefined,
		animloopend: undefined,
		animtoloop: undefined,
		animcallbackframe: [],
		animcallback: [],
		animcallbackon: [],
		animspeed: flipframe_get_speed(asset_get_index(argument0)),
		animxscale: 1,
		animyscale: 1,
		animreversed: false,
		animsyncwith: noone,
		animuniqueid: flipframe_id_creator(),
	}
	
	/// @param {Asset.GMSprite | string} sprite Sprite (or string) to animate
	/// @param {Enum.FLIPFRAME_ANIMTYPE} animation-type The animation type (LOOP, ONESHOT, FRAMELOOPED, TRANSITIONTO)
	/// @param {any} arg2 FRAMELOOPED: Loop start frame | TRANSITIONTO: Target sprite name
	/// @param {real} loop-end FRAMELOOPED only: loop end frame
	static animate = function(argument0, argument1, argument2 = noone, argument3 = noone)
	{
		var isToloop = ((__sprite_struct.animtoloop != argument2 || __sprite_struct.animsprite != __sprite_struct.animtoloop) && __sprite_struct.animtype != FLIPFRAME_ANIMTYPE.TRANSITIONTO)
		var notPlaying = (__sprite_struct.animsprite != asset_get_index(argument0) || __sprite_struct.animtype != argument1) && isToloop;
		
		if (notPlaying)
		{
			__sprite_struct.animsprite = asset_get_index(argument0);
			__sprite_struct.animtype = argument1;
			__sprite_struct.animcurframe = 0;
			__sprite_struct.animfinished = false;
			__sprite_struct.animogsprite = asset_get_index(argument0);
			__sprite_struct.animloopstart = undefined;
			__sprite_struct.animloopend = undefined;
			__sprite_struct.animtoloop = undefined;
			__sprite_struct.animcallbackframe = [];
			__sprite_struct.animcallback = [];
			__sprite_struct.animcallbackon = [];
			__sprite_struct.animspeed = flipframe_get_speed(asset_get_index(argument0));
			__sprite_struct.animreversed = false;
			__sprite_struct.animxscale = 1;
			__sprite_struct.animyscale = 1;
			__sprite_struct.animuniqueid = noone;

			switch (argument1)
			{
				case FLIPFRAME_ANIMTYPE.FRAMELOOPED:
				__sprite_struct.animloopstart = argument2;
				__sprite_struct.animloopend = argument3;
				break;
				
				case FLIPFRAME_ANIMTYPE.TRANSITIONTO:
				__sprite_struct.animtoloop = argument2;
				break;
			}
		}
	}
	/// @param animation_speed The speed to set
	/// @param pixels_to_speed Pixels to speed ratio 
	/// @param [delta_time] Delta time toggle in animation speed (Currently Unused)
	/// @return {real}
	static animation_speed = function(argument0 = undefined, argument1 = FLIPFRAME_PIXELTOFRAMES)
	{
		if (!is_undefined(argument0))
			__sprite_struct.animspeed = abs(argument0) / argument1;
		else
			__sprite_struct.animspeed = flipframe_get_speed(__sprite_struct.animsprite)
	}
	
	/// @param frame
	static flip_to = function(argument0)
	{
		__sprite_struct.animcurframe = argument0;
	}
	
	static start_over = function()
	{
		__sprite_struct.animcurframe = 0;
		__sprite_struct.animreversed = false;
		if (__sprite_struct.animsprite != __sprite_struct.animogsprite)
		{
			__sprite_struct.animsprite = __sprite_struct.animogsprite
			__sprite_struct.animtype = FLIPFRAME_ANIMTYPE.TRANSITIONTO
		}
	}
	
	/// @param sprite-struct
	static sync_with = function(argument0)
	{
		var _otherstruct = argument0;
		
		if (_otherstruct.animuniqueid != __sprite_struct.animuniqueid)
		{
			__sprite_struct.animcurframe = _otherstruct.animcurframe;
			__sprite_struct.animspeed = _otherstruct.animspeed;
			__sprite_struct.animsyncwith = _otherstruct.animuniqueid;
		}
	}
	
	__callbackFrame = function(argument0, argument1)
	{
		var _i = array_length(__sprite_struct.animcallbackframe)
		if (_i != 0)
		{
			var _prevcallback = __sprite_struct.animcallback[_i - 1]
			var _prevcallbackframe = __sprite_struct.animcallbackframe[_i - 1]
			if (_prevcallbackframe != argument0 && _prevcallback != argument1)
			{
				array_push(__sprite_struct.animcallbackframe, argument0);
				array_push(__sprite_struct.animcallback, argument1);
				array_push(__sprite_struct.animcallbackon, 0);
			}
		}
		else
		{
			array_push(__sprite_struct.animcallbackframe, argument0);
			array_push(__sprite_struct.animcallback, argument1);
			array_push(__sprite_struct.animcallbackon, 0);
		}
	}
	
	/// @param frame
	/// @param callback
	static frame_callback = function(argument0, argument1)
	{
		__callbackFrame(argument0, argument1)
	}
	
	/// @param callback
	static on_started = function(argument0)
	{
		__callbackFrame(0, argument0)
	}
	
	/// @param callback
	static on_finished = function(argument0)
	{
		__callbackFrame(sprite_get_number(__sprite_struct.animsprite) - 1, argument0)
	}
	
	/// @returns {Asset.GMSprite}
	static get_sprite = function()
	{
		return __sprite_struct.animsprite;
	}
	/// @returns {Asset.GMSprite}
	static get_subimage = function()
	{
		return floor(__sprite_struct.animcurframe);
	}
	
	static get_number = function()
	{
		return sprite_get_number(__sprite_struct.animsprite) - 1;
	}
	
	static get_info = function()
	{
		return __sprite_struct
	}
}
