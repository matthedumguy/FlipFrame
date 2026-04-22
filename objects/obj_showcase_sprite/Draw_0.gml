var _ff = flipframe(showcaseSprite, x, y, image_xscale, image_yscale, 0, c_white, 1)
_ff.outline(c_pulse, 5)
draw_set_font(fnt_cosmicsans)
for (var i = -2; i <= 2; i++) 
{
	for (var j = -2; j <= 2; j++) 
	{
		draw_text_colour(x + i, (y - 200) + j, "AnimationType: ", c_black, c_black, c_black, c_black, 1)
	}
}
draw_text(x, y - 200, "AnimationType: ")
