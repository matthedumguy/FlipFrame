//////////////////////////////////////////
//                                      //
//      ╔═══╦╗    ╔═══╗                 //
//      ║╔══╣║    ║╔══╝                 //
//      ║╚══╣║╔╦══╣╚══╦═╦══╦╗╔╦══╗      //
//      ║╔══╣║╠╣╔╗║╔══╣╔╣╔╗║╚╝║	═╣      //
//      ║║  ║╚╣║╚╝║║  ║║║╔╗║║║║	═╣      //
//      ╚╝  ╚═╩╣╔═╩╝  ╚╝╚╝╚╩╩╩╩══╝      //
//             ║║                       //
//             ╚╝                       //
//      FlipFrame - Animation System    //
//										//
//             Version 1.0.0            //
//										//
//            by MatTheDumGuy           //
//                                      //
//////////////////////////////////////////

#macro FLIPFRAME_VERSION "1.0.0"
#macro FLIPFRAME_DEBUG false
#macro LABEL_MAP global.__flipframe_label_map


#macro FLIPFRAME_PIXELTOFRAMES 2.5
#macro FLIPFRAME_FILE_FORMAT ".ffilm"
#macro FLIPFRAME_DEFAULT_DELTATIME delta_time / 1000000

#macro c_pulse flipframe_color_pulse()
#macro c_wave flipframe_color_wave()

#macro DM_NORMAL 0
#macro DM_PART 1
#macro DM_TILED 2
#macro DM_TILEDH 3
#macro DM_TILEDV 4
#macro DRAW_MODE global.flipframe_draw_mode

global.__flipframe_label_map = ds_map_create()
global.flipframe_draw_mode = DM_NORMAL

enum FLIPFRAME_ANIMTYPE
{
	LOOP, // 0 - Standard Loop
	ONESHOT, // 1 - One time animation stops at last frame
	ONESHOTB, // 2 - One time animation stops at first frame
	FRAMELOOPED, // 3 - Loops between two frames
	TRANSITIONTO, // 4 - Transitions into another animation
	PINGPONG // 5 - A forward then backwards loop
}

flipframe_log("Hello and welcome to FlipFrame!")