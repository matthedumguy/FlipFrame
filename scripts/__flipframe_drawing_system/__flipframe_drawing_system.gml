function __flipframe_drawing_system(_sprite, _frame, _x, _y, _xscale, _yscale, _rot, _blend, _alpha) constructor
{
	__sprite = _sprite;
	__frame = _frame;
	__xAxis = _x;
	__yAxis = _y;
	__xScale = _xscale;
	__yScale = _yscale;
	__widthSprite = sprite_get_width(_sprite);
	__heightSprite = sprite_get_height(_sprite);
	__angleRot = _rot;
	__colorBlend = _blend;
	__alpha = _alpha;
	
	__frame = clamp(_frame, -1, sprite_get_number(_sprite) + 1)
	
	__drawingmode = flipframe_get_drawmode();
	
	__draw = function(_sprite, _frame, _x, _y, _xscale, _yscale, _rot, _blend, _alpha)
	{
		return draw_sprite_ext(_sprite, _frame, _x, _y, _xscale, _yscale, _rot, _blend, _alpha);
	}
	
	__draw_general = function(_width, _height, _c1, _c2, _c3, _c4)
	{
		var __width = sprite_get_width(__sprite);
		var __height = sprite_get_height(__sprite);
		var __realX = __xAxis - (sprite_get_xoffset(__sprite) * __xScale);
		var __realY = __yAxis - (sprite_get_yoffset(__sprite) * __yScale);
		
		return draw_sprite_general(__sprite, __frame, 0, 0, _width, _height, __realX, __realY, __xScale, __yScale, __angleRot, _c1, _c2, _c3, _c4, __alpha)
	}
	
	__draw_tiled = function(_axis)
	{
		var __camera = view_camera[view_camera];
		
		if (_axis)
		{
			var _sprH = sprite_get_height(__sprite)
			var _camH =	camera_get_view_height(__camera)
			var _max = ceil(_camH / _sprH)
			for (var i = 0; i < _max; i++)
			{
				var yy = _sprH * i;
				__draw(__sprite, __frame, __xAxis, yy, __xScale, __yScale, 0, __colorBlend, __alpha)
			}
		}
		else if (_axis == 0)
		{
			var _sprW = sprite_get_width(__sprite)
			var _camW =	camera_get_view_width(__camera)
			var _max = ceil(_camW / _sprW)
			for (var i = 0; i < _max; i++)
			{
				var xx = _sprW * i;
				__draw(__sprite, __frame, xx, __yAxis, __xScale, __yScale, 0, __colorBlend, __alpha)
			}
		}
		else if (_axis == 2)
		{
			draw_sprite_tiled_ext(__sprite, __frame, __xAxis, __yAxis, __xScale, __yScale, __colorBlend, __alpha);
		}
	}
	
	_Draw = function()
	{
		switch (__drawingmode)
		{
			case DM_NORMAL:
			__draw(__sprite, __frame, __xAxis, __yAxis, __xScale, __yScale, __angleRot, __colorBlend, __alpha);
			break;
			
			case DM_PART:
			__draw_general(__widthSprite, __heightSprite, __colorBlend, __colorBlend, __colorBlend, __alpha)
			break;
			
			case DM_TILEDH:
			__draw_tiled(0)
			break;
			
			case DM_TILEDV:
			__draw_tiled(1)
			break;
			
			case DM_TILED:
			__draw_tiled(2)
			break;
		}
	}
	
	static _Fog = function(_color)
	{
		gpu_set_fog(true, _color, 0, 1000);
		var prevCol = __colorBlend;
		var prevAlpha = __alpha;
		__colorBlend = c_white;
		__alpha = 1;
		_Draw()
		__colorBlend = prevCol;
		__alpha = prevAlpha;
		gpu_set_fog(false, _color, 0, 1000);
	}
	
	static _Outline = function(_color, _size = 1) // Unused because it felt too blocky and didn't draw around the sprite
	{
		gpu_set_fog(true, _color, 0, 1000);
		for (var i = -_size; i <= _size; i++) 
		{
			for (var j = -_size; j <= _size; j++) 
			{
				__draw(__sprite, __frame, __xAxis + i, __yAxis + j, __xScale, __yScale, __angleRot, c_white, __alpha);
			}
		}
		gpu_set_fog(false, _color, 0, 1000);
		_Draw();
	}
	
	static _SmoothOutline = function(_color, _size)
	{
		if (__drawingmode == DM_TILEDH || __drawingmode == DM_TILEDV || __drawingmode == DM_TILED)
			flipframe_throw("Do not outline sprites using the drawmode 'DM_TILED(H|V)'")
		
		var _sw = surface_get_width(application_surface);
		var _sh = surface_get_height(application_surface);
		var _surf = surface_create(_sw, _sh);
		
		surface_set_target(_surf);
		draw_clear_alpha(c_black, 0);
		gpu_set_fog(true, _color, 0, 1000);
		var outlineDir = 16;
		var prevCol = __colorBlend;
		var prevAlpha = __alpha;
		__colorBlend = c_white;
		__alpha = 1;
		for (var i = 0; i < outlineDir; i++) 
		{
			var __angle = (i / outlineDir) * 360;
			for (var j = 1; j <= _size; j++) 
			{
				var ox = lengthdir_x(j, __angle);
				var oy = lengthdir_y(j, __angle);
			
				__draw(__sprite, __frame, __xAxis + ox, __yAxis + oy, __xScale, __yScale, __angleRot, c_white, 1);
			}
		}
		gpu_set_fog(false, _color, 0, 1000);
		gpu_set_blendmode_ext(bm_zero, bm_inv_src_alpha);
		_Draw();
	    gpu_set_blendmode(bm_normal);
	    surface_reset_target();
	    draw_surface(_surf, 0, 0);
	    surface_free(_surf);
		__colorBlend = prevCol;
		__alpha = prevAlpha;
	}
	
	static _Gradient4 = function(_c1, _c2, _c3, _c4)
	{
		__draw_general(__widthSprite, __heightSprite, _c1, _c2, _c3, _c4);
	}

}