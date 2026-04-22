/// @param {Asset.GMSprite} sprite Sprite struct made using 'flipframe_flick()'
/// @param {Real} x x position where to draw
/// @param {Real} y y position where to draw
/// @param {Real} xscale horizontal scaling to draw the sprite
/// @param {Real} yscale vertical scaling to draw the sprite
/// @param {Real} rot rotation to angle the sprite	
/// @param {Constant.Colour} colour blend used to color the sprite
/// @param {Real} alpha opacity for the sprite. 0 is transparent, 0.5 translucent and 1 is opaque
function flipframe(_sprite, _x, _y, _xscale = image_xscale, _yscale = image_yscale, _rot = 0, _colour = draw_get_colour(), _alpha = draw_get_alpha())
{
	__flipframe_animation_system(_sprite, _x, _y, _xscale, _yscale, _rot, _colour, _alpha)
}

function flipframe_flick(_sprite)
{
	return new __flipframe_flick_data(_sprite)	
}

var Spr = flipframe_flick(spr_PierreRun)
Spr.animate(spr_PierreRun, FLIPFRAME_ANIMTYPE.LOOP)