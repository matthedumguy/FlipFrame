function __flipframe_drawing_system(_sprite, _frame, _x, _y, _xscale, _yscale, _rot, _blend, _alpha) constructor
{
	__sprite = _sprite
	__frame = _frame
	__xAxis = _x
	__yAxis = _y
	__xScale = _xscale
	__yScale = _yscale
	__angleRot = _rot
	__colorBlend = _blend
	__alpha = _alpha
	
	__draw = function(_sprite, _frame, _x, _y, _xscale, _yscale, _rot, _blend, _alpha)
	{
		return draw_sprite_ext(_sprite, _frame, _x, _y, _xscale, _yscale, _rot, _blend, _alpha)
	}
	
	__draw_gradient = function(_c1, _c2, _c3, _c4)
	{
		var __width = sprite_get_width(__sprite)
		var __height = sprite_get_height(__sprite)
		var __realX = __xAxis - (sprite_get_xoffset(__sprite) * __xScale)
		var __realY = __yAxis - (sprite_get_yoffset(__sprite) * __yScale)
		
		
		return draw_sprite_general(__sprite, __frame, 0, 0, __width, __height, __realX, __realY, __xScale, __yScale, __angleRot, _c1, _c2, _c3, _c4, __alpha)
	}
	
	_Draw = function()
	{
		__draw(__sprite, __frame, __xAxis, __yAxis, __xScale, __yScale, __angleRot, __colorBlend, __alpha)
	}
	
	static _Fog = function(_color)
	{
		gpu_set_fog(true, _color, 0, 1000)
		__draw(__sprite, __frame, __xAxis, __yAxis, __xScale, __yScale, __angleRot, c_white, 1)
		gpu_set_fog(false, _color, 0, 1000)
	}
	
	static _Outline = function(_color, _size = 1)
	{
		gpu_set_fog(true, _color, 0, 1000);
		//gpu_set_texfilter(true);
		for (var i = -_size; i <= _size; i++) 
		{
			for (var j = -_size; j <= _size; j++) 
			{
				__draw(__sprite, __frame, __xAxis + i, __yAxis + j, __xScale, __yScale, __angleRot, c_white, __alpha)
			}
		}
		gpu_set_fog(false, _color, 0, 1000);
		gpu_set_colourwriteenable(true, true, true, true)
		_Draw()
		gpu_set_colourwriteenable(true, true, true, false)
	}
	
	static _SmoothOutline = function(_color, _size)
	{
		gpu_set_fog(true, _color, 0, 1000);
		var outlineDir = 16
		for (var i = 0; i < outlineDir; i++) 
		{
			var __angle = (i / outlineDir) * 360;
			for (var j = 1; j <= _size; j++) 
			{
				var ox = lengthdir_x(j, __angle);
				var oy = lengthdir_y(j, __angle);
			
				__draw(__sprite, __frame, __xAxis + ox, __yAxis + oy, __xScale, __yScale, __angleRot, c_white, __alpha);
			}
		}
		gpu_set_fog(false, _color, 0, 1000);
		_Draw()
	}
	
	static _Gradient3 = function(_c1, _c2, _c3)
	{
		var _in1 = merge_colour(_c1, _c2, 0.5)
		var _in2 = merge_colour(_c2, _c3, 0.5)
		__draw_gradient(_c1, _in1, _in2, _c3)
	}
	
	static _Gradient4 = function(_c1, _c2, _c3, _c4)
	{
		__draw_gradient(_c1, _c2, _c3, _c4)
	}

}