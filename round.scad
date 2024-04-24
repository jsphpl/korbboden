// Template for a laser cut base for basket weaving.
// Base shape is round with equally spaced holes offset from the rim.
// Generates a 2D shape that can be exported as SVG or DXF

$fn = 60;
D_OUTER = 100;   // Outer diameter of the base
N_HOLES = 12;    // Number of holes
HOLE_OFFSET = 7; // Offset of the holes from the outer rim
D_HOLE = 3;      // Diameter of an individual hole. No automatic kerf compensation is performed.

// Derived values:
r_outer = D_OUTER / 2;                 // radius of the outer rim
r_hole_circle = r_outer - HOLE_OFFSET; // radius of the circle on which the holes lie
a_holes = 360 / N_HOLES;               // angle between two holes

// Just for validation purposes
echo("Distance between holes: ", 2 * r_hole_circle * PI / N_HOLES);

module Base(h)
{
    difference()
    {
        cylinder(h, r = r_outer, center = true);
        for (i = [0:N_HOLES])
        {
#rotate(i *a_holes) translate([ r_hole_circle, 0, 0 ]) cylinder(h + 1, r = D_HOLE / 2, center = true);
        }
    }
}

projection() Base(3);
