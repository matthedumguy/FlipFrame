var __id = ds_map_find_value(async_load, "id");

if (speedId == __id)
{
    if (ds_map_find_value(async_load, "status"))
    {
        if (ds_map_find_value(async_load, "result") != "" || !is_real(ds_map_find_value(async_load, "result")))
		{
            speedString = ds_map_find_value(async_load, "result")
			obj_showcase_sprite.showcaseSprite.animation_speed(real(speedString))
		}
		else
		{
			speedString = flipframe_get_speed(SCsprite)
			obj_showcase_sprite.showcaseSprite.animation_speed(undefined)
		}
    }
}