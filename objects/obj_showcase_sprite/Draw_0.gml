var _ff = flipframe(showcaseSprite, x, y, image_xscale, image_yscale, 0, c_white, 1)
_ff.outline(c_gray, 10)
draw_set_font(fnt_arial)
draw_set_halign(fa_center)
drawTextOutlined(x, y - 200, "Animation Type : " + stringifyAnimtype(Example.SCanimtype))
draw_set_halign(fa_right)
drawTextOutlined(x + 500, y - 200, "Current frame : " + string(showcaseSprite.get_subimage()))

if (Example.SCanimtype == FLIPFRAME_ANIMTYPE.FRAMELOOPED)
{
	drawTextOutlined(x + 500, y - 150, "Loop Start : " + string(showcaseSprite._struct.animloopstart) + " Loop End : " + string(showcaseSprite._struct.animloopend))
}