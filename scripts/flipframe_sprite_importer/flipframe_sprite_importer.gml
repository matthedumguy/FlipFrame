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
	if (!file_exists(_fname))
		flipframe_throw("File name ''", _fname, "'' does not exist")
		
	if (!file_exists(_inifname))
		flipframe_throw("FFilm file ''", _inifname, "'' does not exist")
	
	ini_open(_inifname)
	_xoff = ini_read_real("FFrameInfo", "xOrigin", 0)
	_yoff = ini_read_real("FFrameInfo", "yOrigin", 0)
	_numb = ini_read_real("FFrameInfo", "frameCount", 1)
	ini_close()
	
	return sprite_add_ext(_fname, _numb, _xoff, _yoff, false)
}

