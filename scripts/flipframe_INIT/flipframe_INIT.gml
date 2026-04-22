#macro FLIPFRAME_PIXELTOFRAMES 2.5
#macro FLIPFRAME_VERSION "Early-Beta"
#macro FLIPFRAME_DEBUG false
#macro FLIPFRAME_FILE_FORMAT ".ffilm"
#macro c_pulse flipframe_color_pulse()


enum FLIPFRAME_ANIMTYPE
{
	LOOP = 0, // 0 - Standard Loop
	ONESHOT = 1, // 1 - One time animation stops at last frame
	FRAMELOOPED, // 2 - Loops between two frames
	TRANSITIONTO, // 3 - Transitions into another animation
	PINGPONG // 4 - A forward then backwards loop
}