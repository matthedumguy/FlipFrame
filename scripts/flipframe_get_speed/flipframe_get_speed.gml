/// @return {Real}
/// @desc  Returns the default sprite speed
function flipframe_get_speed(argument0)
{
    var speeds = sprite_get_speed(argument0);
    var speedtype = sprite_get_speed_type(argument0);
	
	return (speedtype == 1) ? speeds : speeds / game_get_speed(gamespeed_fps)
}