function flipframe(sprite_index, x, y)
{
	__flipframe_animated_system(sprite_index, x, y, 1, 1, 0, c_white, 1);
}

function flipframe_ext(sprite_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
{
	__flipframe_animated_system(sprite_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha) 
}



function flipframe_create(argument0, argument1, argument2 = noone, argument3 = noone)
{
	return new __flipframe_data(argument0, argument1, argument2, argument3)	
}
