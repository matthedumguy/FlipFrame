/// @return {Real}
/// @desc  Returns the default sprite speed
/// @param {Asset.GMSprite} sprite
function flipframe_get_speed(_sprite)
{
    var speeds = sprite_get_speed(_sprite);
    var speedtype = sprite_get_speed_type(_sprite);
	
	return (speedtype == 1) ? speeds : speeds / game_get_speed(gamespeed_fps)
}