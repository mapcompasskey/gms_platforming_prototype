// check_horizontal_collision_2(hsp, obj1, mask)

var hsp = argument0;
var obj1 = argument1;
var mask = argument2;

var hsp_push = 0;
var hsp_final = hsp;

/**/
// if object 1 is colliding horizontally with object 2
if (place_meeting(obj1.x + hsp_final, obj1.y, mask))
{
    var obj2 = instance_place(obj1.x + hsp_final, obj1.y, mask);
    //show_debug_message(inst);
    
    // if object 2 is to the right
    if (obj1.bbox_left < obj2.bbox_left)
    {
        return obj2.bbox_left - obj1.bbox_right;
    }
    // else, if object 2 is to the left
    else if (obj1.bbox_right > obj2.bbox_right)
    {
        return obj2.bbox_right - obj1.bbox_left;
    }
}
/**/

// if about to collide horizontally with an object
if (place_meeting(obj1.x + hsp_final, obj1.y, mask))
{
    hsp_final = 0;
    
    /*
    // get as close to the object as possible
    while ( ! place_meeting(xPos + sign(hsp), yPos, mask))
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
