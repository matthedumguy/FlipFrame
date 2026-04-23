/// @desc Wave(from, to, duration, offset)
/// @arg from
/// @arg to
/// @arg duration
/// @arg offset
function Wave(argument0, argument1, argument2, argument3){
	var _wave = (argument1 - argument0) * 0.5;

	return argument0 + _wave + sin((((current_time * 0.001) + argument2 * argument3) / argument2) * (pi * 2)) * _wave;
}