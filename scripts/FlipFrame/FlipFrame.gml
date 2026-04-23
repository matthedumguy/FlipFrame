
/// @param {Asset.GMSprite} sprite Sprite struct made using 'flipframe_flick()'
/// @param {Real} x x position where to draw
/// @param {Real} y y position where to draw
/// @param {Real} xscale Horizontal scaling to draw the sprite
/// @param {Real} yscale Vertical scaling to draw the sprite
/// @param {Real} rot Rotation to angle the sprite	
/// @param {Constant.Colour} colour Blend used to color the sprite
/// @param {Real} alpha Opacity for the sprite. 0 is transparent, 0.5 translucent and 1 is opaque
function flipframe(_sprite, _x, _y, _xscale = image_xscale, _yscale = image_yscale, _rot = 0, _colour = draw_get_colour(), _alpha = draw_get_alpha())
{
	return new __flipframe_animation_system(_sprite, _x, _y, _xscale, _yscale, _rot, _colour, _alpha)
}