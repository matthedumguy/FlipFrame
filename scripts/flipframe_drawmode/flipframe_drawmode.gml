/// @param {Constant.DrawMode} mode Draw mode to use (DM_[drawing mode])
function flipframe_set_drawmode(_mode)
{
	global.flipframe_draw_mode = _mode;
}

/// @returns {Constant.DrawMode}
function flipframe_get_drawmode()
{
	return DRAW_MODE;
}

