// scr_player_create()

// Initialize Variables
//grav = 0.5;
hsp = 0;
vsp = 0;
//max_vsp = 10;
//movespeed = 8;
jumps = 0;
jumpsmax = 2;
//jumpspeed = 12;

gravity_rate = 400;
speed_x = 200;
speed_y = 440;
velocity_x = 0;
velocity_y = 0;
max_velocity_x = 300;
max_velocity_y = 880;

walking = false;
jumping = false;
falling = false;
crouching = false;
hurting = false;
dying = false;
launching = false;

grounded = false;
facing_right = true;

timepassed = 0;

moving_platform = 0;
on_moving_wall = 0;

/*
if (global.checkpointR == room)
{
    x = global.checkpointx;
    y = global.checkpointy;
}

key_down = 0;
*/

