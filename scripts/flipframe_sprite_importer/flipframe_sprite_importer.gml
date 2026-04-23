function flipframe_sprite_importer(fname)
{
	var _fname = fname
	var _inifname = _fname
	var _xoff = 0;
	var _yoff = 0;
	var _numb = 1;
	var _formats = [".png", ".jpg", ".jpeg", ".gif"]
	var _fformat
	
	for (var i = 0; i < array_length(_formats); i++)
	{
		var __fformat = _formats[i]
		if (stringContains(__fformat, _fname))
		{
			_inifname = string_replace(_inifname, __fformat, FLIPFRAME_FILE_FORMAT)
			_fformat = __fformat
		}
	}
	
	if (file_exists(_inifname))
	{
		ini_open(_inifname)
		_xoff = ini_read_real("FFrameInfo", "xOrigin", 0)
		_yoff = ini_read_real("FFrameInfo", "yOrigin", 0)
		_numb = ini_read_real("FFrameInfo", "frameCount", 1)
	}
	
	return sprite_add_ext(_fname, _numb, _xoff, _yoff, false)
}

