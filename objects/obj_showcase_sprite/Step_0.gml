var arg2 = (Example.SCanimtype == FLIPFRAME_ANIMTYPE.TRANSITIONTO) ? Example.SCtoloop : 2
var _callbackTest = function()
{
	flipframe_log("Waku Waku Sonic Patrol Car")	
}
showcaseSprite.animate(Example.SCsprite, Example.SCanimtype, arg2, 5)
showcaseSprite.on_finished(_callbackTest)