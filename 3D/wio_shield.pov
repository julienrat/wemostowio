//Fichier POVRay crée par 3d41.ulp v20110101
///home/julo/eagle/wio_shield/wio_shield.brd
//10/08/2016 16:19

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

#declare global_use_radiosity = on;

#declare global_ambient_mul = 1;
#declare global_ambient_mul_emit = 0;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare e3d_environment = off;

#local cam_x = 0;
#local cam_y = -155;
#local cam_z = -80;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -3;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#local pcb_wire_bridges = off;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 18;
#local lgt1_pos_y = -27;
#local lgt1_pos_z = 18;
#local lgt1_intense = 0.724224;
#local lgt2_pos_x = -18;
#local lgt2_pos_y = -27;
#local lgt2_pos_z = 18;
#local lgt2_intense = 0.724224;
#local lgt3_pos_x = 18;
#local lgt3_pos_y = -27;
#local lgt3_pos_z = -12;
#local lgt3_intense = 0.724224;
#local lgt4_pos_x = -18;
#local lgt4_pos_y = -27;
#local lgt4_pos_z = -12;
#local lgt4_intense = 0.724224;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 48.565000;
#declare pcb_y_size = 34.915000;
#declare pcb_layer1_used = 0;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(68);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "e3d_tools.inc"
#include "e3d_user.inc"

global_settings{charset utf8}

#if(e3d_environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Ressources pour créer une animation
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "Absence ou erreur dans les données spécifiés pour l'animation (3 points minimum) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "Absence ou erreur dans les données spécifiés pour l'animation (3 points minimum) (Montrer l'arborescence)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-24.282500,0,-17.457500>
}
#end

background{col_bgr}
light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro WIO_SHIELD(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Plaque
prism{-1.500000,0.000000,8
<1.270000,10.160000><49.835000,10.160000>
<49.835000,10.160000><49.835000,45.075000>
<49.835000,45.075000><1.270000,45.075000>
<1.270000,45.075000><1.270000,10.160000>
texture{col_brd}}
}//End union(PCB)
//Trous(réel)/Composants
//Trous(réel)/Board
//Trous(réel)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Composants
union{
}//End union
#end
#if(pcb_pads_smds=on)
//Pattes&CMS/Composants
#ifndef(global_pack_J1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,0+global_tmp,0) rotate<0,-90.000000,0>translate<5.080000,0,35.100000> texture{col_thl}}
#ifndef(global_pack_J1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<5.080000,0,37.100000> texture{col_thl}}
#ifndef(global_pack_J1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<5.080000,0,39.100000> texture{col_thl}}
#ifndef(global_pack_J1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<5.080000,0,41.100000> texture{col_thl}}
#ifndef(global_pack_J2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,0+global_tmp,0) rotate<0,-90.000000,0>translate<44.450000,0,36.370000> texture{col_thl}}
#ifndef(global_pack_J2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<44.450000,0,38.370000> texture{col_thl}}
#ifndef(global_pack_J2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<44.450000,0,40.370000> texture{col_thl}}
#ifndef(global_pack_J2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<44.450000,0,42.370000> texture{col_thl}}
#ifndef(global_pack_K1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.905000,1.143000,1,16,0+global_tmp,0) rotate<0,-0.000000,0>translate<39.497000,0,21.209000> texture{col_thl}}
#ifndef(global_pack_K1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.905000,1.143000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<39.497000,0,16.891000> texture{col_thl}}
#ifndef(global_pack_K1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.905000,1.143000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<46.863000,0,16.891000> texture{col_thl}}
#ifndef(global_pack_K1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.905000,1.143000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<46.863000,0,21.209000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<39.370000,0,31.115000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<39.370000,0,26.035000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<41.910000,0,31.115000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<46.990000,0,31.115000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<46.990000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<46.990000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<12.700000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<35.560000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<12.700000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<12.700000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<35.560000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<35.560000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<35.560000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<35.560000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<12.700000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<12.700000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<12.700000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<12.700000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<35.560000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<12.700000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<35.560000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<35.560000,0,31.750000> texture{col_thl}}
//Pattes/Vias
#end
#if(pcb_wires=on)
union{
//Signaux
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<3.175000,-1.535000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<3.175000,-1.535000,33.655000>}
box{<0,0,-0.508000><5.080000,0.035000,0.508000> rotate<0,-90.000000,0> translate<3.175000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<3.175000,-1.535000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<3.540000,-1.535000,39.100000>}
box{<0,0,-0.508000><0.516188,0.035000,0.508000> rotate<0,-44.997030,0> translate<3.175000,-1.535000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<3.175000,-1.535000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<4.445000,-1.535000,32.385000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,44.997030,0> translate<3.175000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<3.540000,-1.535000,39.100000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,39.100000>}
box{<0,0,-0.508000><1.540000,0.035000,0.508000> rotate<0,0.000000,0> translate<3.540000,-1.535000,39.100000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,41.100000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.255000,-1.535000,41.275000>}
box{<0,0,-0.508000><0.247487,0.035000,0.508000> rotate<0,-44.997030,0> translate<5.080000,-1.535000,41.100000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,39.100000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.350000,-1.535000,39.370000>}
box{<0,0,-0.508000><0.381838,0.035000,0.508000> rotate<0,-44.997030,0> translate<5.080000,-1.535000,39.100000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<4.445000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.350000,-1.535000,32.385000>}
box{<0,0,-0.508000><1.905000,0.035000,0.508000> rotate<0,0.000000,0> translate<4.445000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,35.100000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.810000,-1.535000,35.100000>}
box{<0,0,-0.508000><1.730000,0.035000,0.508000> rotate<0,0.000000,0> translate<5.080000,-1.535000,35.100000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.350000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.985000,-1.535000,31.750000>}
box{<0,0,-0.508000><0.898026,0.035000,0.508000> rotate<0,44.997030,0> translate<6.350000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.080000,-1.535000,37.100000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.350000,-1.535000,37.100000>}
box{<0,0,-0.508000><2.270000,0.035000,0.508000> rotate<0,0.000000,0> translate<5.080000,-1.535000,37.100000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.350000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,39.370000>}
box{<0,0,-0.508000><2.270000,0.035000,0.508000> rotate<0,0.000000,0> translate<5.350000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.810000,-1.535000,35.100000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<8.255000,-1.535000,33.655000>}
box{<0,0,-0.508000><2.043539,0.035000,0.508000> rotate<0,44.997030,0> translate<6.810000,-1.535000,35.100000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<5.255000,-1.535000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<8.255000,-1.535000,41.275000>}
box{<0,0,-0.508000><3.000000,0.035000,0.508000> rotate<0,0.000000,0> translate<5.255000,-1.535000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.350000,-1.535000,37.100000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<8.890000,-1.535000,35.560000>}
box{<0,0,-0.508000><2.177889,0.035000,0.508000> rotate<0,44.997030,0> translate<7.350000,-1.535000,37.100000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<9.525000,-1.535000,37.465000>}
box{<0,0,-0.508000><2.694077,0.035000,0.508000> rotate<0,44.997030,0> translate<7.620000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,15.875000>}
box{<0,0,-0.508000><15.875000,0.035000,0.508000> rotate<0,-90.000000,0> translate<10.160000,-1.535000,15.875000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.985000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,31.750000>}
box{<0,0,-0.508000><3.175000,0.035000,0.508000> rotate<0,0.000000,0> translate<6.985000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<8.255000,-1.535000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,39.370000>}
box{<0,0,-0.508000><2.694077,0.035000,0.508000> rotate<0,44.997030,0> translate<8.255000,-1.535000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,15.875000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<11.430000,-1.535000,14.605000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,44.997030,0> translate<10.160000,-1.535000,15.875000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<11.430000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<12.065000,-1.535000,14.605000>}
box{<0,0,-0.508000><0.635000,0.035000,0.508000> rotate<0,0.000000,0> translate<11.430000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<12.065000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<12.700000,-1.535000,13.970000>}
box{<0,0,-0.508000><0.898026,0.035000,0.508000> rotate<0,44.997030,0> translate<12.065000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<8.255000,-1.535000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<15.240000,-1.535000,33.655000>}
box{<0,0,-0.508000><6.985000,0.035000,0.508000> rotate<0,0.000000,0> translate<8.255000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<12.700000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.145000,-1.535000,29.210000>}
box{<0,0,-0.508000><4.445000,0.035000,0.508000> rotate<0,0.000000,0> translate<12.700000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<8.890000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.145000,-1.535000,35.560000>}
box{<0,0,-0.508000><8.255000,0.035000,0.508000> rotate<0,0.000000,0> translate<8.890000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<9.525000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.050000,-1.535000,37.465000>}
box{<0,0,-0.508000><9.525000,0.035000,0.508000> rotate<0,0.000000,0> translate<9.525000,-1.535000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.145000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.685000,-1.535000,26.670000>}
box{<0,0,-0.508000><3.592102,0.035000,0.508000> rotate<0,44.997030,0> translate<17.145000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<15.240000,-1.535000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.685000,-1.535000,29.210000>}
box{<0,0,-0.508000><6.286179,0.035000,0.508000> rotate<0,44.997030,0> translate<15.240000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.145000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<20.955000,-1.535000,31.750000>}
box{<0,0,-0.508000><5.388154,0.035000,0.508000> rotate<0,44.997030,0> translate<17.145000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<20.955000,-1.535000,39.370000>}
box{<0,0,-0.508000><10.795000,0.035000,0.508000> rotate<0,0.000000,0> translate<10.160000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.050000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<22.225000,-1.535000,34.290000>}
box{<0,0,-0.508000><4.490128,0.035000,0.508000> rotate<0,44.997030,0> translate<19.050000,-1.535000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<20.955000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<24.130000,-1.535000,36.195000>}
box{<0,0,-0.508000><4.490128,0.035000,0.508000> rotate<0,44.997030,0> translate<20.955000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.685000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<29.845000,-1.535000,26.670000>}
box{<0,0,-0.508000><10.160000,0.035000,0.508000> rotate<0,0.000000,0> translate<19.685000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<31.115000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<31.115000,-1.535000,12.700000>}
box{<0,0,-0.508000><12.700000,0.035000,0.508000> rotate<0,-90.000000,0> translate<31.115000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<29.845000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<31.115000,-1.535000,25.400000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,44.997030,0> translate<29.845000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<31.115000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<32.385000,-1.535000,11.430000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,44.997030,0> translate<31.115000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<24.130000,-1.535000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.925000,-1.535000,36.195000>}
box{<0,0,-0.508000><10.795000,0.035000,0.508000> rotate<0,0.000000,0> translate<24.130000,-1.535000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<19.685000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.560000,-1.535000,29.210000>}
box{<0,0,-0.508000><15.875000,0.035000,0.508000> rotate<0,0.000000,0> translate<19.685000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<20.955000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.560000,-1.535000,31.750000>}
box{<0,0,-0.508000><14.605000,0.035000,0.508000> rotate<0,0.000000,0> translate<20.955000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<22.225000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.560000,-1.535000,34.290000>}
box{<0,0,-0.508000><13.335000,0.035000,0.508000> rotate<0,0.000000,0> translate<22.225000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.560000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.941000,-1.535000,16.891000>}
box{<0,0,-0.508000><0.538815,0.035000,0.508000> rotate<0,-44.997030,0> translate<35.560000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.560000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.941000,-1.535000,21.209000>}
box{<0,0,-0.508000><0.538815,0.035000,0.508000> rotate<0,44.997030,0> translate<35.560000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.560000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<36.830000,-1.535000,26.670000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,0.000000,0> translate<35.560000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<32.385000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.100000,-1.535000,11.430000>}
box{<0,0,-0.508000><5.715000,0.035000,0.508000> rotate<0,0.000000,0> translate<32.385000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<36.830000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.735000,-1.535000,28.575000>}
box{<0,0,-0.508000><2.694077,0.035000,0.508000> rotate<0,-44.997030,0> translate<36.830000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.735000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.735000,-1.535000,29.845000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,90.000000,0> translate<38.735000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.735000,-1.535000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<39.370000,-1.535000,31.115000>}
box{<0,0,-0.508000><1.419903,0.035000,0.508000> rotate<0,-63.430762,0> translate<38.735000,-1.535000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.941000,-1.535000,16.891000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<39.497000,-1.535000,16.891000>}
box{<0,0,-0.508000><3.556000,0.035000,0.508000> rotate<0,0.000000,0> translate<35.941000,-1.535000,16.891000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.941000,-1.535000,21.209000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<39.497000,-1.535000,21.209000>}
box{<0,0,-0.508000><3.556000,0.035000,0.508000> rotate<0,0.000000,0> translate<35.941000,-1.535000,21.209000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.100000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<40.640000,-1.535000,13.970000>}
box{<0,0,-0.508000><3.592102,0.035000,0.508000> rotate<0,-44.997030,0> translate<38.100000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.925000,-1.535000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<41.100000,-1.535000,42.370000>}
box{<0,0,-0.508000><8.732769,0.035000,0.508000> rotate<0,-44.997030,0> translate<34.925000,-1.535000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<39.370000,-1.535000,26.035000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<41.275000,-1.535000,26.035000>}
box{<0,0,-0.508000><1.905000,0.035000,0.508000> rotate<0,0.000000,0> translate<39.370000,-1.535000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<41.275000,-1.535000,26.035000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<41.275000,-1.535000,31.115000>}
box{<0,0,-0.508000><5.080000,0.035000,0.508000> rotate<0,90.000000,0> translate<41.275000,-1.535000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.560000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<41.640000,-1.535000,40.370000>}
box{<0,0,-0.508000><8.598418,0.035000,0.508000> rotate<0,-44.997030,0> translate<35.560000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<41.275000,-1.535000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<41.910000,-1.535000,31.115000>}
box{<0,0,-0.508000><0.635000,0.035000,0.508000> rotate<0,0.000000,0> translate<41.275000,-1.535000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<39.370000,-1.535000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<41.910000,-1.535000,36.195000>}
box{<0,0,-0.508000><5.679613,0.035000,0.508000> rotate<0,-63.430762,0> translate<39.370000,-1.535000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<39.497000,-1.535000,16.891000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.561000,-1.535000,18.415000>}
box{<0,0,-0.508000><4.340354,0.035000,0.508000> rotate<0,-20.554689,0> translate<39.497000,-1.535000,16.891000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.561000,-1.535000,18.415000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.815000,-1.535000,18.415000>}
box{<0,0,-0.508000><0.254000,0.035000,0.508000> rotate<0,0.000000,0> translate<43.561000,-1.535000,18.415000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.815000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.815000,-1.535000,18.415000>}
box{<0,0,-0.508000><1.905000,0.035000,0.508000> rotate<0,-90.000000,0> translate<43.815000,-1.535000,18.415000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.560000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.815000,-1.535000,24.130000>}
box{<0,0,-0.508000><8.255000,0.035000,0.508000> rotate<0,0.000000,0> translate<35.560000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.815000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.815000,-1.535000,24.130000>}
box{<0,0,-0.508000><8.255000,0.035000,0.508000> rotate<0,-90.000000,0> translate<43.815000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<41.910000,-1.535000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<44.450000,-1.535000,36.195000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,0.000000,0> translate<41.910000,-1.535000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<44.450000,-1.535000,36.370000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<44.450000,-1.535000,36.195000>}
box{<0,0,-0.508000><0.175000,0.035000,0.508000> rotate<0,-90.000000,0> translate<44.450000,-1.535000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<41.640000,-1.535000,40.370000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<44.450000,-1.535000,40.370000>}
box{<0,0,-0.508000><2.810000,0.035000,0.508000> rotate<0,0.000000,0> translate<41.640000,-1.535000,40.370000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<41.100000,-1.535000,42.370000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<44.450000,-1.535000,42.370000>}
box{<0,0,-0.508000><3.350000,0.035000,0.508000> rotate<0,0.000000,0> translate<41.100000,-1.535000,42.370000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<44.450000,-1.535000,38.370000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<45.450000,-1.535000,38.370000>}
box{<0,0,-0.508000><1.000000,0.035000,0.508000> rotate<0,0.000000,0> translate<44.450000,-1.535000,38.370000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.815000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<46.355000,-1.535000,24.130000>}
box{<0,0,-0.508000><4.579050,0.035000,0.508000> rotate<0,-56.306216,0> translate<43.815000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.815000,-1.535000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<46.355000,-1.535000,34.925000>}
box{<0,0,-0.508000><3.592102,0.035000,0.508000> rotate<0,-44.997030,0> translate<43.815000,-1.535000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<46.355000,-1.535000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<46.355000,-1.535000,34.925000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,-90.000000,0> translate<46.355000,-1.535000,34.925000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<45.450000,-1.535000,38.370000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<46.355000,-1.535000,37.465000>}
box{<0,0,-0.508000><1.279863,0.035000,0.508000> rotate<0,44.997030,0> translate<45.450000,-1.535000,38.370000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<46.355000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<46.990000,-1.535000,24.130000>}
box{<0,0,-0.508000><0.635000,0.035000,0.508000> rotate<0,0.000000,0> translate<46.355000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<46.990000,-1.535000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<46.990000,-1.535000,29.210000>}
box{<0,0,-0.508000><1.905000,0.035000,0.508000> rotate<0,-90.000000,0> translate<46.990000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<40.640000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<48.895000,-1.535000,13.970000>}
box{<0,0,-0.508000><8.255000,0.035000,0.508000> rotate<0,0.000000,0> translate<40.640000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<46.990000,-1.535000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<48.895000,-1.535000,31.115000>}
box{<0,0,-0.508000><1.905000,0.035000,0.508000> rotate<0,0.000000,0> translate<46.990000,-1.535000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<48.895000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<48.895000,-1.535000,31.115000>}
box{<0,0,-0.508000><17.145000,0.035000,0.508000> rotate<0,90.000000,0> translate<48.895000,-1.535000,31.115000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygones
texture{col_pol}
}
#end
union{
cylinder{<5.080000,0.038000,35.100000><5.080000,-1.538000,35.100000>0.400000}
cylinder{<5.080000,0.038000,37.100000><5.080000,-1.538000,37.100000>0.400000}
cylinder{<5.080000,0.038000,39.100000><5.080000,-1.538000,39.100000>0.400000}
cylinder{<5.080000,0.038000,41.100000><5.080000,-1.538000,41.100000>0.400000}
cylinder{<44.450000,0.038000,36.370000><44.450000,-1.538000,36.370000>0.400000}
cylinder{<44.450000,0.038000,38.370000><44.450000,-1.538000,38.370000>0.400000}
cylinder{<44.450000,0.038000,40.370000><44.450000,-1.538000,40.370000>0.400000}
cylinder{<44.450000,0.038000,42.370000><44.450000,-1.538000,42.370000>0.400000}
cylinder{<39.497000,0.038000,21.209000><39.497000,-1.538000,21.209000>0.571500}
cylinder{<39.497000,0.038000,16.891000><39.497000,-1.538000,16.891000>0.571500}
cylinder{<46.863000,0.038000,16.891000><46.863000,-1.538000,16.891000>0.571500}
cylinder{<46.863000,0.038000,21.209000><46.863000,-1.538000,21.209000>0.571500}
cylinder{<39.370000,0.038000,31.115000><39.370000,-1.538000,31.115000>0.406400}
cylinder{<39.370000,0.038000,26.035000><39.370000,-1.538000,26.035000>0.406400}
cylinder{<41.910000,0.038000,31.115000><41.910000,-1.538000,31.115000>0.406400}
cylinder{<46.990000,0.038000,31.115000><46.990000,-1.538000,31.115000>0.406400}
cylinder{<46.990000,0.038000,29.210000><46.990000,-1.538000,29.210000>0.406400}
cylinder{<46.990000,0.038000,24.130000><46.990000,-1.538000,24.130000>0.406400}
cylinder{<12.700000,0.038000,13.970000><12.700000,-1.538000,13.970000>0.400000}
cylinder{<35.560000,0.038000,13.970000><35.560000,-1.538000,13.970000>0.400000}
cylinder{<12.700000,0.038000,29.210000><12.700000,-1.538000,29.210000>0.400000}
cylinder{<12.700000,0.038000,26.670000><12.700000,-1.538000,26.670000>0.400000}
cylinder{<35.560000,0.038000,26.670000><35.560000,-1.538000,26.670000>0.400000}
cylinder{<35.560000,0.038000,24.130000><35.560000,-1.538000,24.130000>0.400000}
cylinder{<35.560000,0.038000,21.590000><35.560000,-1.538000,21.590000>0.400000}
cylinder{<35.560000,0.038000,19.050000><35.560000,-1.538000,19.050000>0.400000}
cylinder{<12.700000,0.038000,24.130000><12.700000,-1.538000,24.130000>0.400000}
cylinder{<12.700000,0.038000,21.590000><12.700000,-1.538000,21.590000>0.400000}
cylinder{<12.700000,0.038000,19.050000><12.700000,-1.538000,19.050000>0.400000}
cylinder{<12.700000,0.038000,16.510000><12.700000,-1.538000,16.510000>0.400000}
cylinder{<35.560000,0.038000,16.510000><35.560000,-1.538000,16.510000>0.400000}
cylinder{<12.700000,0.038000,31.750000><12.700000,-1.538000,31.750000>0.400000}
cylinder{<35.560000,0.038000,29.210000><35.560000,-1.538000,29.210000>0.400000}
cylinder{<35.560000,0.038000,31.750000><35.560000,-1.538000,31.750000>0.400000}
//Trous(rapide)/Vias
//Trous(rapide)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Sérigraphie (Silk Screen)
union{
//J1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.080000,0.000000,33.100000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.080000,0.000000,33.100000>}
box{<0,0,-0.063500><2.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<4.080000,0.000000,33.100000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<3.580000,0.000000,43.100000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<6.580000,0.000000,43.100000>}
box{<0,0,-0.127000><3.000000,0.036000,0.127000> rotate<0,0.000000,0> translate<3.580000,0.000000,43.100000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<2.880000,0.000000,33.100000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.280000,0.000000,33.100000>}
box{<0,0,-0.127000><4.400000,0.036000,0.127000> rotate<0,0.000000,0> translate<2.880000,0.000000,33.100000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.280000,0.000000,33.100000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.280000,0.000000,34.900000>}
box{<0,0,-0.127000><1.800000,0.036000,0.127000> rotate<0,90.000000,0> translate<7.280000,0.000000,34.900000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.280000,0.000000,41.300000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.280000,0.000000,43.100000>}
box{<0,0,-0.127000><1.800000,0.036000,0.127000> rotate<0,90.000000,0> translate<7.280000,0.000000,43.100000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.280000,0.000000,43.100000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<2.880000,0.000000,43.100000>}
box{<0,0,-0.127000><4.400000,0.036000,0.127000> rotate<0,0.000000,0> translate<2.880000,0.000000,43.100000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<2.880000,0.000000,33.100000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<2.880000,0.000000,43.100000>}
box{<0,0,-0.127000><10.000000,0.036000,0.127000> rotate<0,90.000000,0> translate<2.880000,0.000000,43.100000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.280000,0.000000,33.100000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.880000,0.000000,33.100000>}
box{<0,0,-0.127000><0.600000,0.036000,0.127000> rotate<0,0.000000,0> translate<7.280000,0.000000,33.100000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.880000,0.000000,33.100000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.880000,0.000000,34.900000>}
box{<0,0,-0.127000><1.800000,0.036000,0.127000> rotate<0,90.000000,0> translate<7.880000,0.000000,34.900000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.880000,0.000000,34.900000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.280000,0.000000,34.900000>}
box{<0,0,-0.127000><0.600000,0.036000,0.127000> rotate<0,0.000000,0> translate<7.280000,0.000000,34.900000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.280000,0.000000,34.900000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.280000,0.000000,41.300000>}
box{<0,0,-0.127000><6.400000,0.036000,0.127000> rotate<0,90.000000,0> translate<7.280000,0.000000,41.300000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.280000,0.000000,41.300000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.880000,0.000000,41.300000>}
box{<0,0,-0.127000><0.600000,0.036000,0.127000> rotate<0,0.000000,0> translate<7.280000,0.000000,41.300000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.880000,0.000000,41.300000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.880000,0.000000,43.100000>}
box{<0,0,-0.127000><1.800000,0.036000,0.127000> rotate<0,90.000000,0> translate<7.880000,0.000000,43.100000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.880000,0.000000,43.100000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.280000,0.000000,43.100000>}
box{<0,0,-0.127000><0.600000,0.036000,0.127000> rotate<0,0.000000,0> translate<7.280000,0.000000,43.100000> }
//J2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<43.450000,0.000000,34.370000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<45.450000,0.000000,34.370000>}
box{<0,0,-0.063500><2.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<43.450000,0.000000,34.370000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<42.950000,0.000000,44.370000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<45.950000,0.000000,44.370000>}
box{<0,0,-0.127000><3.000000,0.036000,0.127000> rotate<0,0.000000,0> translate<42.950000,0.000000,44.370000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<42.250000,0.000000,34.370000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<46.650000,0.000000,34.370000>}
box{<0,0,-0.127000><4.400000,0.036000,0.127000> rotate<0,0.000000,0> translate<42.250000,0.000000,34.370000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<46.650000,0.000000,34.370000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<46.650000,0.000000,36.170000>}
box{<0,0,-0.127000><1.800000,0.036000,0.127000> rotate<0,90.000000,0> translate<46.650000,0.000000,36.170000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<46.650000,0.000000,42.570000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<46.650000,0.000000,44.370000>}
box{<0,0,-0.127000><1.800000,0.036000,0.127000> rotate<0,90.000000,0> translate<46.650000,0.000000,44.370000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<46.650000,0.000000,44.370000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<42.250000,0.000000,44.370000>}
box{<0,0,-0.127000><4.400000,0.036000,0.127000> rotate<0,0.000000,0> translate<42.250000,0.000000,44.370000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<42.250000,0.000000,34.370000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<42.250000,0.000000,44.370000>}
box{<0,0,-0.127000><10.000000,0.036000,0.127000> rotate<0,90.000000,0> translate<42.250000,0.000000,44.370000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<46.650000,0.000000,34.370000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<47.250000,0.000000,34.370000>}
box{<0,0,-0.127000><0.600000,0.036000,0.127000> rotate<0,0.000000,0> translate<46.650000,0.000000,34.370000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<47.250000,0.000000,34.370000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<47.250000,0.000000,36.170000>}
box{<0,0,-0.127000><1.800000,0.036000,0.127000> rotate<0,90.000000,0> translate<47.250000,0.000000,36.170000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<47.250000,0.000000,36.170000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<46.650000,0.000000,36.170000>}
box{<0,0,-0.127000><0.600000,0.036000,0.127000> rotate<0,0.000000,0> translate<46.650000,0.000000,36.170000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<46.650000,0.000000,36.170000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<46.650000,0.000000,42.570000>}
box{<0,0,-0.127000><6.400000,0.036000,0.127000> rotate<0,90.000000,0> translate<46.650000,0.000000,42.570000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<46.650000,0.000000,42.570000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<47.250000,0.000000,42.570000>}
box{<0,0,-0.127000><0.600000,0.036000,0.127000> rotate<0,0.000000,0> translate<46.650000,0.000000,42.570000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<47.250000,0.000000,42.570000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<47.250000,0.000000,44.370000>}
box{<0,0,-0.127000><1.800000,0.036000,0.127000> rotate<0,90.000000,0> translate<47.250000,0.000000,44.370000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<47.250000,0.000000,44.370000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<46.650000,0.000000,44.370000>}
box{<0,0,-0.127000><0.600000,0.036000,0.127000> rotate<0,0.000000,0> translate<46.650000,0.000000,44.370000> }
//K1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.080000,0.000000,22.150000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<46.280000,0.000000,22.150000>}
box{<0,0,-0.063500><6.200000,0.036000,0.063500> rotate<0,0.000000,0> translate<40.080000,0.000000,22.150000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<46.280000,0.000000,22.150000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<46.280000,0.000000,15.950000>}
box{<0,0,-0.063500><6.200000,0.036000,0.063500> rotate<0,-90.000000,0> translate<46.280000,0.000000,15.950000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<46.280000,0.000000,15.950000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.080000,0.000000,15.950000>}
box{<0,0,-0.063500><6.200000,0.036000,0.063500> rotate<0,0.000000,0> translate<40.080000,0.000000,15.950000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.080000,0.000000,15.950000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.080000,0.000000,22.150000>}
box{<0,0,-0.063500><6.200000,0.036000,0.063500> rotate<0,90.000000,0> translate<40.080000,0.000000,22.150000> }
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<39.370000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<39.370000,0.000000,26.543000>}
box{<0,0,-0.254000><0.508000,0.036000,0.254000> rotate<0,90.000000,0> translate<39.370000,0.000000,26.543000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<39.370000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<39.370000,0.000000,30.607000>}
box{<0,0,-0.254000><0.508000,0.036000,0.254000> rotate<0,-90.000000,0> translate<39.370000,0.000000,30.607000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<40.005000,0.000000,30.099000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<38.735000,0.000000,30.099000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<38.735000,0.000000,27.051000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<40.005000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,30.353000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,30.353000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.735000,0.000000,30.353000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,29.845000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.259000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,29.718000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,29.845000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<40.132000,0.000000,29.718000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.481000,0.000000,30.099000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.481000,0.000000,29.845000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.481000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.608000,0.000000,29.718000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.481000,0.000000,29.845000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<38.481000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,27.432000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,27.305000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<40.132000,0.000000,27.432000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,27.432000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,29.718000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.132000,0.000000,29.718000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.608000,0.000000,27.432000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.481000,0.000000,27.305000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<38.481000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.608000,0.000000,27.432000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.608000,0.000000,29.718000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.608000,0.000000,29.718000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,27.305000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.259000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.481000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.481000,0.000000,27.305000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.481000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.735000,0.000000,26.797000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,26.797000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.735000,0.000000,26.797000> }
box{<-0.127000,0,-0.254000><0.127000,0.036000,0.254000> rotate<0,-270.000000,0> translate<39.370000,0.000000,30.480000>}
box{<-0.127000,0,-0.254000><0.127000,0.036000,0.254000> rotate<0,-270.000000,0> translate<39.370000,0.000000,26.670000>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<46.990000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<46.482000,0.000000,31.115000>}
box{<0,0,-0.254000><0.508000,0.036000,0.254000> rotate<0,0.000000,0> translate<46.482000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<41.910000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<42.418000,0.000000,31.115000>}
box{<0,0,-0.254000><0.508000,0.036000,0.254000> rotate<0,0.000000,0> translate<41.910000,0.000000,31.115000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<42.926000,0.000000,31.750000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<42.926000,0.000000,30.480000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<45.974000,0.000000,30.480000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<45.974000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.672000,0.000000,31.750000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<42.672000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,32.004000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.926000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.307000,0.000000,31.877000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,32.004000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<43.180000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.926000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,30.226000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.926000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.307000,0.000000,30.353000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,30.226000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.180000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.593000,0.000000,31.877000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,32.004000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<45.593000,0.000000,31.877000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.593000,0.000000,31.877000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.307000,0.000000,31.877000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.307000,0.000000,31.877000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.593000,0.000000,30.353000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,30.226000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<45.593000,0.000000,30.353000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.593000,0.000000,30.353000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.307000,0.000000,30.353000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.307000,0.000000,30.353000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,32.004000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,32.004000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.720000,0.000000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.974000,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,30.226000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<45.720000,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.228000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.228000,0.000000,31.750000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.228000,0.000000,31.750000> }
box{<-0.127000,0,-0.254000><0.127000,0.036000,0.254000> rotate<0,-0.000000,0> translate<42.545000,0.000000,31.115000>}
box{<-0.127000,0,-0.254000><0.127000,0.036000,0.254000> rotate<0,-0.000000,0> translate<46.355000,0.000000,31.115000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<46.990000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<46.990000,0.000000,24.638000>}
box{<0,0,-0.254000><0.508000,0.036000,0.254000> rotate<0,90.000000,0> translate<46.990000,0.000000,24.638000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<46.990000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<46.990000,0.000000,28.702000>}
box{<0,0,-0.254000><0.508000,0.036000,0.254000> rotate<0,-90.000000,0> translate<46.990000,0.000000,28.702000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<47.625000,0.000000,28.194000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<46.355000,0.000000,28.194000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<46.355000,0.000000,25.146000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<47.625000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,28.448000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,28.448000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.355000,0.000000,28.448000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.879000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.879000,0.000000,27.940000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<47.879000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,27.813000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.879000,0.000000,27.940000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<47.752000,0.000000,27.813000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.101000,0.000000,28.194000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.101000,0.000000,27.940000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<46.101000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.228000,0.000000,27.813000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.101000,0.000000,27.940000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<46.101000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,25.527000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.879000,0.000000,25.400000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<47.752000,0.000000,25.527000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,25.527000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.752000,0.000000,27.813000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.752000,0.000000,27.813000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.228000,0.000000,25.527000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.101000,0.000000,25.400000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<46.101000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.228000,0.000000,25.527000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.228000,0.000000,27.813000>}
box{<0,0,-0.076200><2.286000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.228000,0.000000,27.813000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.879000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.879000,0.000000,25.400000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<47.879000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.101000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.101000,0.000000,25.400000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<46.101000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<46.355000,0.000000,24.892000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.625000,0.000000,24.892000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<46.355000,0.000000,24.892000> }
box{<-0.127000,0,-0.254000><0.127000,0.036000,0.254000> rotate<0,-270.000000,0> translate<46.990000,0.000000,28.575000>}
box{<-0.127000,0,-0.254000><0.127000,0.036000,0.254000> rotate<0,-270.000000,0> translate<46.990000,0.000000,24.765000>}
//U$1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.700000,0.000000,40.970000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.700000,0.000000,40.970000>}
box{<0,0,-0.063500><21.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<13.700000,0.000000,40.970000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.700000,0.000000,37.970000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<10.700000,0.000000,11.970000>}
box{<0,0,-0.063500><26.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<10.700000,0.000000,11.970000> }
object{ARC(3.000000,0.127000,90.000000,180.000000,0.036000) translate<13.700000,0.000000,37.970000>}
object{ARC(3.000000,0.127000,0.000000,90.000000,0.036000) translate<34.700000,0.000000,37.970000>}
box{<-1.270000,0,-10.160000><1.270000,0.036000,10.160000> rotate<0,-0.000000,0> translate<12.700000,0.000000,22.860000>}
box{<-1.270000,0,-10.160000><1.270000,0.036000,10.160000> rotate<0,-0.000000,0> translate<35.560000,0.000000,22.860000>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  WIO_SHIELD(-25.552500,0,-27.617500,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//J1	4P-2.0	HW4-2.0
//J2	4P-2.0	HW4-2.0
//K1	TS-1109	SW4-6.0X6.0X5.0MM
//R1	100K	PR-D1.8*L3.3MM
//R2	100K	PR-D1.8*L3.3MM
//R3	100K	PR-D1.8*L3.3MM
//U$1	WEMOS	WEMOS
