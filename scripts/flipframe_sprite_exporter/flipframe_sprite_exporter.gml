function flipframe_sprite_exporter(_sprite, _fname)
{
	if (file_exists(_fname))
	exit; 
	
	var _inifname = string_replace(_fname, ".png", FLIPFRAME_FILE_FORMAT)
	ini_open(_inifname)
	ini_write_real("FFrameInfo", "xOrigin", sprite_get_xoffset(_sprite));
	ini_write_real("FFrameInfo", "yOrigin", sprite_get_yoffset(_sprite));
	ini_write_real("FFrameInfo", "frameCount", sprite_get_number(_sprite));
	ini_close()
	
	var _temp = sprite_duplicate(_sprite)
	sprite_save_strip(_temp, _fname)
	sprite_delete(_temp)
}