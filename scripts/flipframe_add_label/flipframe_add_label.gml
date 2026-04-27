function flipframe_add_label(_name, _sprite, _animtype, _speed = undefined, _arg2 = undefined, _loopend = undefined)
{	
	var __struct = {
		sprite: _sprite,
		animtype: _animtype,
		sprspeed: is_undefined(_speed) ? flipframe_get_speed(_sprite) : _speed,
		arg2: _arg2,
		loopend: _loopend
	}
	
	if (ds_map_exists(LABEL_MAP, _name))
		flipframe_throw("The label ''", _name, "'' is already defined")
	
	LABEL_MAP[? _name] = __struct;		
}