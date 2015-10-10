// check_horizontal_collision_2(x, y, hsp, obj_wall)

var xPos = argument0;
var yPos = argument1;
var hsp = argument2;
var theObj = argument3;
var hsp_final = hsp;

/**/
// if colliding horizontally with an object
if (place_meeting(xPos, yPos, theObj))
{
    // if the object is to the right
    if (xPos < theObj.x)
    {
        hsp_final = xPos - theObj.x;
    }
    // else, if the object is to the left
    else if (xPos >= theObj.x)
    {
        hsp_final = xPos - theObj.x;
    }
}
/**/

// if about to collide horizontally with an object
if (place_meeting(xPos + hsp_final, yPos, theObj))
{
    hsp_final = 0;
    
    /*
    // get as close to the object as possible
    while ( ! place_meeting(xPos + sign(hsp), yPos, theObj))
    {
        hsp_final += sign(hsp);
    }
    */
}

return hsp_final;


    /*
    // if object is moving left
    if (theObj.x < theObj.xprevious)
    {
        
    }
    // else, if the ojbect is moving right
    else if (theObj.x > theObj.xprevious)
    {
    
    }
    // else, if the object hasn't moved
    else if (theObj.x == theObj.xprevious)
    {
        
    }
    */
