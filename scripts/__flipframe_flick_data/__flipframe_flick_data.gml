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
		animtransicallback: undefined,
		animtransicallbackon: true,
		animspeed: flipframe_get_speed(asset_get_index(argument0)),
		animdeltatimeon: false,
		animxscale: 1,
		animyscale: 1,
		animpaused: false,
		animreversed: false,
		animsyncwith: noone,
		animuniqueid: flipframe_id_creator(),
	}
	
	/// @param {Asset.GMSprite} sprite Sprite to animate
	/// @param {Enum.FLIPFRAME_ANIMTYPE} animation-type The animation type (LOOP, ONESHOT, ONESHOTB, FRAMELOOPED, TRANSITIONTO)
	static animate = function(_sprite, _animtype)
	{
		var Playing = (__sprite_struct.animogsprite == asset_get_index(_sprite) && __sprite_struct.animtype == _animtype)
		
		if (!Playing)
		{
			__sprite_struct.animsprite = asset_get_index(_sprite);
			__sprite_struct.animtype = _animtype;
			__sprite_struct.animcurframe = 0;
			__sprite_struct.animfinished = false;
			__sprite_struct.animogsprite = asset_get_index(_sprite);
			__sprite_struct.animloopstart = undefined;
			__sprite_struct.animloopend = undefined;
			__sprite_struct.animtoloop = undefined;
			__sprite_struct.animcallbackframe = [];
			__sprite_struct.animcallback = [];
			__sprite_struct.animcallbackon = [];
			__sprite_struct.animtransicallback = undefined;
			__sprite_struct.animtransicallbackon = true;
			__sprite_struct.animspeed = flipframe_get_speed(asset_get_index(_sprite));
			__sprite_struct.animreversed = false;
			__sprite_struct.animxscale = 1;
			__sprite_struct.animyscale = 1;
			__sprite_struct.animsyncwith = noone;
			
			return self;
		}
	}
	
	/// @param {Real} speed The speed to set
	/// @param ratio Pixels to speed ratio (Keep undefined for default ratio)
	/// @return {real}
	static animation_speed = function(_speed, _ratio = FLIPFRAME_PIXELTOFRAMES)
	{
		if (!is_undefined(_speed))
			__sprite_struct.animspeed = abs(_speed) / _ratio;
		else
			__sprite_struct.animspeed = flipframe_get_speed(__sprite_struct.animsprite);
			
		return self;
	}
	
	/// @param {Bool} [toggle] Delta time toggle in animation speed
	static deltatime_toggle = function(_bool)
	{
		__sprite_struct.animdeltatimeon = _bool;
		
		return self;
	}
	
	/// @param animation_speed The speed to set
	static transition_into = function(_sprite)
	{
		__sprite_struct.animtype = FLIPFRAME_ANIMTYPE.TRANSITIONTO;
		__sprite_struct.animtoloop = _sprite;
		
		return self;
	}
	
	static frame_looping = function(_loopstart, _loopend)
	{
		__sprite_struct.animtype = FLIPFRAME_ANIMTYPE.FRAMELOOPED;
		
		__sprite_struct.animloopstart = _loopstart;
		__sprite_struct.animloopend = _loopend;
		
		return self;
	}
	
	/// @param name Label name to play
	static play_label = function(_name)
	{
		if (flipframe_is_label(_name))
		{
			var __mapstruct = LABEL_MAP[? _name];
			var __sprite = __mapstruct.sprite;
			var __animtype = __mapstruct.animtype;
			var __arg2 = __mapstruct.arg2;
			var __loopend = __mapstruct.loopend;
			var __speed = __mapstruct.sprspeed;
			
			animate(__sprite, __animtype);
			animation_speed(__speed);
			
			switch (__animtype)
			{
				case FLIPFRAME_ANIMTYPE.FRAMELOOPED:
				__sprite_struct.animloopstart = __arg2;
				__sprite_struct.animloopend = __loopend;
				break;
				
				case FLIPFRAME_ANIMTYPE.TRANSITIONTO:
				__sprite_struct.animtoloop = __arg2;
				break;
			}
			
			return self;
		}
		else
			flipframe_throw("The animation label ''", _name, "'' does not exist, please make sure you typed it right or defined the label")
	}
	
	/// @param subimage
	static flip_to = function(_subimage)
	{
		__sprite_struct.animcurframe = _subimage;
		
		return self;
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
		
		return self;
	}
	
	/// @param sprite_struct
	static sync_with = function(_spritestruct)
	{
		var _otherstruct = _spritestruct;
		
		if (_otherstruct.animuniqueid != __sprite_struct.animuniqueid)
		{
			__sprite_struct.animcurframe = _otherstruct.animcurframe;
			__sprite_struct.animspeed = _otherstruct.animspeed;
			__sprite_struct.animsyncwith = _otherstruct.animuniqueid;
		}
		
		return self;
	}
	
	tempCallbackFrame = function(argument0, argument1)
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
	
	/// @param subimage
	/// @param callback
	static frame_callback = function(_index, _callback)
	{
		tempCallbackFrame(_index, _callback);
		
		return self;
	}
	
	/// @param callback
	static on_started = function(_callback)
	{
		tempCallbackFrame(0, _callback);
		
		return self;
	}
	
	/// @param callback
	static on_finished = function(_callback)
	{
		tempCallbackFrame(sprite_get_number(__sprite_struct.animsprite) - 1, _callback);
		return self;
	}
	
	/// @param callback
	static on_transitioned = function(_callback)
	{
		if (__sprite_struct.animtype == FLIPFRAME_ANIMTYPE.TRANSITIONTO)
		{
			__sprite_struct.animtransicallback = _callback;
			__sprite_struct.animtransicallbackon = false;
		}
		
		return self;
	}
	
	static pause = function()
	{
		__sprite_struct.animpaused = true;
		
		return self;
	}
	
	static resume = function()
	{
		__sprite_struct.animpaused = false;
		
		return self;
	}
	
	static is_playing = function(_sprite)
	{
		return __sprite_struct.animogsprite == _sprite;
		
	}
	
	/// @returns {Asset.GMSprite}
	static get_sprite = function()
	{
		return __sprite_struct.animsprite;
	}
	
	/// @returns {Real}
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
	
	static get_texture = function()
	{
		return sprite_get_texture(__sprite_struct.animsprite, __sprite_struct.animcurframe)
	}
	
	static get_uvs = function()
	{
		var _tex = sprite_get_uvs(__sprite_struct.animsprite, __sprite_struct.animcurframe);
		
		return {
			left: _tex[0],
			top: _tex[1],
			right: _tex[2],
			bottom: _tex[3],
			trimmed_pixelsL: _tex[4],
			trimmed_pixelsT: _tex[5],
			saved_width: _tex[6],
			saved_height: _tex[7]
		}
	}
}
