function flipframe_color_wave(_ratio = 3, _offset = 1)
{
	var wave = Wave(0, 255, _ratio, 1)
	return make_color_hsv(wave, 255, 255)
}