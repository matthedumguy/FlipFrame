function flipframe_color_pulse(_ratio = 3)
{
	var _curTime = current_time / _ratio
	var pulse = _curTime % 255
	return make_color_hsv(pulse, 255, 255)
}