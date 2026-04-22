var hor = keyboard_check_pressed(ord("D")) - keyboard_check_pressed(ord("A"))
var _speed = keyboard_check_pressed(ord("S"))
var _reset = keyboard_check_pressed(ord("R"))

if (hor != 0)
{
	animTypeN += hor
	
	if (animTypeN >= array_length(animationTypes))
		animTypeN = 0;
	else if (animTypeN < 0)
		animTypeN = array_length(animationTypes) - 1

	SCanimtype = animationTypes[animTypeN]
}

if (_reset)
	obj_showcase_sprite.showcaseSprite.flip(0)

if (_speed)
	get_string_async("Input the desired speed (Leave blank for default)", "Bruh")