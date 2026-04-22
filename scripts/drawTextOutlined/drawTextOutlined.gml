function drawTextOutlined(_x, _y, _string)
{
	for (var i = -2; i <= 2; i++) 
	{
		for (var j = -2; j <= 2; j++) 
		{
			draw_text_colour(_x + i, _y + j, _string, c_black, c_black, c_black, c_black, 1)
		}
	}
	draw_text(_x, _y, _string)
}