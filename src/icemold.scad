// INSPIRATION AND CREDITS:
// The text outline is ispired by the blog of Erika Heidi (https://dev.to/erikaheidi/how-to-create-letter-molds-and-stamps-for-3d-printing-on-openscad-18am)
// The general concept of a custom ice cube is inspired by Voldivo of Taipei (https://www.thingiverse.com/thing:1419541)
// The lattice base is taken from the OpenSCAD forum at http://forum.openscad.org/Lattice-structure-tp21001p21009.html

module lattice(sx, sy, h, th, n)
linear_extrude(height = h)
    difference() {
        square([sx, sy]);
        m = ceil(n * sy / sx);
        for (i = [0:n], j = [0:2 * m])
        translate([(i + (j % 2) / 2) * sx / n, j * sx / n / 2])
            rotate(45)
                square(sx / n / sqrt(2) - th, center = true);
    }

// LICENSE:
// Start MIT license (c) 2021 Mark Teese

//------------------------------------------------//
//                  TEXT MOLD                     //
//------------------------------------------------//
module ice_mold(ice_block_text, ice_block_font, font_size, text_spacing, mold_length_x, wall_text_lhs_top,
wall_text_lhs_bottom, wall_text_rhs_top,
wall_text_rhs_centre, wall_text_rhs_bottom, wall_lhs_text_x_offset_from_centre, wall_rhs_text_x_offset_from_centre) {

    font_offset = 1;
    ice_block_text_height = 8.5;
    ice_block_x_center = (mold_length_x - (mold_length_x * 0.12)) / 2;
    width_y = 50;

    module create_ice_block_text(input_text) {
        halign = "center";
        valign = "center";
        text(input_text, size = font_size, spacing = text_spacing, font = ice_block_font, halign = halign, valign =
        valign);
    }

    module create_ice_block_text_outline() {
        linear_extrude(height = ice_block_text_height) {
            difference() {
                offset(r = font_offset) {
                    create_ice_block_text(ice_block_text);
                }
                offset(r = font_offset - 1) {
                    create_ice_block_text(ice_block_text);
                }
            }
        }
    }

    rotate([- 180, 0, 0])
        // text outline and base
        union() {
            translate([ice_block_x_center, 0, 1]) create_ice_block_text_outline();
            translate([ice_block_x_center, 0, ice_block_text_height + 0.5]) linear_extrude(0.5) offset(r = font_offset)
                {
                    text(ice_block_text, size = font_size, spacing = text_spacing, font = ice_block_font,
                    halign = "center", valign = "center");
                }
        }

    //------------------------------------------------//
    //     POLYHEDRONS FOR OUTER AND INNER WALL       //
    //------------------------------------------------//

    IceCubeFaces = [
            [0, 1, 2, 3], // bottom
            [4, 5, 1, 0], // front
            [7, 6, 5, 4], // top
            [5, 6, 2, 1], // right
            [6, 7, 3, 2], // back
            [7, 4, 0, 3]]; // left

    // constants used in polyhedron (outer wall)
    // nomenclature: "x03" means the x-value used in face 0 and face 3
    x03 = - 8;
    x56 = mold_length_x;
    x12 = x56 * 1.08;
    x47 = 0;
    y0145 = 1;
    y23 = 60;
    y67 = width_y + 2;
    z4567 = 23;

    IceCubePointsOuter = [
            [x03, y0145, 0], //0
            [x12, y0145, 0], //1
            [x12, y23, 0], //2
            [x03, y23, 0], //3
            [x47, y0145, z4567], //4
            [x56, y0145, z4567], //5
            [x56, y67, z4567], //6
            [x47, y67, z4567]]; //7

    // offsets that determine thickness of polyhedron walls
    a = 0;
    b = 2;
    c = 3;

    IceCubePointsInner = [
            [x03 + c, y0145 + a, 0], //0
            [x12 + a, y0145 + a, 0], //1
            [x12 + a, y23 - c, 0], //2
            [x03 + c, y23 - c, 0], //3
            [x47 + c, y0145 + a, z4567 - a], //4
            [x56 + a, y0145 + a, z4567 - a], //5
            [x56 + a, y67 - c, z4567 - a], //6
            [x47 + c, y67 - c, z4567 - a]]; //7


    module create_wall_text(input_text) {
        rotate([90, 180, 0])
            linear_extrude(height = 2) text(input_text, spacing = 1, size = 5, $fn = 100, font = "Courier", halign =
            "center", valign = "center");
    }

    // constants for text on wall
    wall_text_x_centre = mold_length_x / 2;
    wall_text_y_centre = - 24;
    wall_text_z_centre = - 7;

    rotate([- 180, 0, 0])
        difference() {
            translate([- 7, - 26, - 20]) polyhedron(IceCubePointsOuter, IceCubeFaces);
            union() {
                translate([- 9, - 24, - 22]) polyhedron(IceCubePointsInner, IceCubeFaces);
                translate([ice_block_x_center, 0, - 5]) linear_extrude(20) offset(r = font_offset) {
                    text(ice_block_text, size = font_size, spacing = text_spacing, font = ice_block_font,
                    halign = "center", valign = "center");
                }
                translate([wall_text_x_centre - wall_rhs_text_x_offset_from_centre, wall_text_y_centre,
                        wall_text_z_centre - 6]) create_wall_text(wall_text_rhs_top);
                translate([wall_text_x_centre - wall_rhs_text_x_offset_from_centre, wall_text_y_centre,
                    wall_text_z_centre]) create_wall_text(wall_text_rhs_centre);
                translate([wall_text_x_centre - wall_rhs_text_x_offset_from_centre, wall_text_y_centre,
                        wall_text_z_centre + 7]) create_wall_text(wall_text_rhs_bottom);
                translate([wall_text_x_centre + wall_lhs_text_x_offset_from_centre, wall_text_y_centre,
                        wall_text_z_centre - 2]) create_wall_text(wall_text_lhs_top);
                translate([wall_text_x_centre + wall_lhs_text_x_offset_from_centre, wall_text_y_centre,
                        wall_text_z_centre + 4]) create_wall_text(wall_text_lhs_bottom);
            }
        }

    //-------------------------------------------------------------------//
    //        LATTICE BASE WITH SURROUNDING WALL AS INBUILT SUPPORT      //
    //-------------------------------------------------------------------//

    // constants for lattice
    n = mold_length_x / 10;
    h = ice_block_text_height - 2.5;
    sx = mold_length_x;
    sy = width_y + 1;
    th = 0.7;

    rotate([- 180, 0, 0])
        difference() {
            union() {
                // lattice
                translate([- 7, - 25, 3.5]) lattice(sx, sy, h, th, n);

                // surrounding wall
                wall_thickness = 0.5;
                difference() {
                    translate([- 7, - 25, 3]) linear_extrude(6.5) square([mold_length_x, width_y + 1]);
                    translate([- 7 + wall_thickness, - 25 + wall_thickness, 3]) linear_extrude(11) square([mold_length_x
                        - (wall_thickness * 2), width_y + 1 - (wall_thickness * 2)]);
                }
            }
            // cut a hole for the ice_block_text out of the lattice
            translate([ice_block_x_center, 0, 0]) linear_extrude(10) offset(r = font_offset) create_ice_block_text(
            ice_block_text);
        }
}

ice_mold(ice_block_text, mold_length_x, wall_text_lhs_top, wall_text_lhs_bottom, wall_text_rhs_top,
wall_text_rhs_centre, wall_text_rhs_bottom, wall_lhs_text_x_offset_from_centre, wall_rhs_text_x_offset_from_centre);