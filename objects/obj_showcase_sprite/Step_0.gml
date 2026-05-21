var _callbackTest = function()
{
	flipframe_log("Waku Waku Sonic Patrol Car")	;
}
showcaseSprite.animate(Example.SCsprite, Example.SCanimtype);

if (Example.SCanimtype == FLIPFRAME_ANIMTYPE.TRANSITIONTO)
	showcaseSprite.transition_into(Example.SCtoloop);
else if (Example.SCanimtype == FLIPFRAME_ANIMTYPE.FRAMELOOPED)
	showcaseSprite.frame_looping(2, 5);
	
showcaseSprite.on_finished(_callbackTest);
if (speedz != 0.1)
speedz -= 0.01