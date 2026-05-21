var c_outline = merge_colour(c_wave, c_gray, 0.55)
var __y = Wave(y - 100, y + 100, 2, 1)
var __x = Wave(x - 500, x + 500, 4, 1)
var _ff = flipframe(showcaseSprite, __x, __y, image_xscale, image_yscale, 0, c_white, 1)
_ff.outline(c_outline, 10)
draw_set_font(fnt_main)
draw_set_halign(fa_center)
drawTextOutlined(x, y - 200, "Animation Type : " + stringifyAnimtype(Example.SCanimtype))
drawTextOutlined(x, y - 150, "Sprite : " + sprite_get_name(showcaseSprite.get_sprite()))
draw_set_halign(fa_right)
drawTextOutlined(x + 500, y - 200, "Current frame : " + string(showcaseSprite.get_subimage()))

if (Example.SCanimtype == FLIPFRAME_ANIMTYPE.FRAMELOOPED)
{
	drawTextOutlined(x + 500, y - 150, "Loop Start : " + string(showcaseSprite.__sprite_struct.animloopstart) + " Loop End : " + string(showcaseSprite.__sprite_struct.animloopend))
}

if (Example.SCanimtype == FLIPFRAME_ANIMTYPE.TRANSITIONTO)
{
	drawTextOutlined(x + 500, y - 280, "Animation to transition into : " + sprite_get_name(showcaseSprite.__sprite_struct.animtoloop))
}