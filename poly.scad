// Template for a laser cut base for basket weaving.
// Base shape is a regular polygon with equally spaced holes offset from the rim.
// Generates a 2D shape that can be exported as SVG or DXF

$fn = 10;
R_BASE = 80;        // Radius of the base (distance between the midpoint of each side and the base's center point)
N_SIDES = 8;        // Number of sides of the polygon
HOLES_PER_SIDE = 5; // Number of holes per side of the polygon
HOLE_OFFSET = 7;    // Offset of the holes from the outer rim (center of hole to edge)
D_HOLE = 3;         // Diameter of an individual hole. No automatic kerf compensation is performed.

// Derived values:
r_base_outer = R_BASE / (cos(180 / N_SIDES)); // radius of the vertex points of the base polygon
r_hole_circle = r_base_outer - HOLE_OFFSET; // distance between centerpoint and the holes at the vertices of the polygon
l_hole_circle = 2 * sin(180 / N_SIDES) * r_hole_circle; // side length of the polygon on which the holes lie
l_holes = l_hole_circle / (HOLES_PER_SIDE - 1);         // distance between two holes

echo("Distance between two holes:", l_holes);

module Base(h)
{
    difference()
    {
        cylinder(h, r = r_base_outer, center = true, $fn = N_SIDES);
        for (s = [0:N_SIDES - 1])
        {
            rotate([ 0, 0, s * 360 / N_SIDES ]) translate([ r_hole_circle, 0, 0 ]) HolesPerSide(h + 1);
        }
    }
}

module HolesPerSide(h)
{
    for (n = [0:HOLES_PER_SIDE - 1])
    {
        rotate([ 0, 0, 180 / N_SIDES ]) translate([ 0, n * l_holes, 0 ]) cylinder(h, r = D_HOLE / 2, center = true);
    }
}

projection() Base(3);
