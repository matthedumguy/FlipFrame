showcaseSprite = flipframe_flick(Example.SCsprite)
showcaseSprite.animate(Example.SCsprite, Example.SCanimtype)


stringifyAnimtype = function(_animType)
{
	switch (_animType)
	{
		case FLIPFRAME_ANIMTYPE.LOOP:
		return "Loop"
		
		case FLIPFRAME_ANIMTYPE.ONESHOT:
		return "Oneshot"
		
		case FLIPFRAME_ANIMTYPE.FRAMELOOPED:
		return "Frame Looping"
		
		case FLIPFRAME_ANIMTYPE.TRANSITIONTO:
		return "Transition Into"
		
		case FLIPFRAME_ANIMTYPE.PINGPONG:
		return "Pingpong"
	}
}