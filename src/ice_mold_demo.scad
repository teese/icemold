// INSTRUCTIONS
// Download the sledge typeface (available at https://allbestfonts.com/sledge-typeface/)
// Install the typeface so it's accessible to OpenSCAD (see https://www.reddit.com/r/3Dprinting/comments/ee8011/anyone_know_how_to_add_a_font_to_openscad/)
// Download icemolddemo.scad and icemold.scad to the same folder
// In icemolddemo.scad, modify the text as desired.
// Note: if you don't want any wall text, just change the variables to empty strings (e.g. wall_text_lhs_top = "";).
// Modify mold_length_x to change the length of the ice cube to match the text.

// LICENSE:
// MIT license (c) 2021 Mark Teese

use <icemold.scad>;
$fn = 20;

ice_block_text = "ICE";
font_size = 45;
text_spacing = 1.3;
mold_length_x = 95;

wall_text_lhs_top = "";
wall_text_lhs_bottom = "";
wall_text_rhs_top = "\"To you, frozen water.";
wall_text_rhs_centre = "To me, home.\"";
wall_text_rhs_bottom = "ANON. POLAR BEAR";

wall_lhs_text_x_offset_from_centre = 20;
wall_rhs_text_x_offset_from_centre = 5;

ice_block_font = "Sledge regular";

ice_mold(ice_block_text, ice_block_font, font_size, text_spacing, mold_length_x, wall_text_lhs_top,
         wall_text_lhs_bottom, wall_text_rhs_top, wall_text_rhs_centre, wall_text_rhs_bottom,
         wall_lhs_text_x_offset_from_centre, wall_rhs_text_x_offset_from_centre);