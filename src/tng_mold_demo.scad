use <icemold.scad>;
$fn = 20;

ice_block_text = "TNG";
font_size = 45;
text_spacing = 1.2;
mold_length_x = 100;

wall_text_lhs_top = "TNG Technology";
wall_text_lhs_bottom = "Consulting GmbH";
wall_text_rhs_top = "Testen,";
wall_text_rhs_centre = "Nicht";
wall_text_rhs_bottom = "Glauben";

wall_lhs_text_x_offset_from_centre = 10;
wall_rhs_text_x_offset_from_centre = 40;

ice_block_font = "Sledge regular";

ice_mold(ice_block_text, ice_block_font, font_size, text_spacing, mold_length_x, wall_text_lhs_top,
         wall_text_lhs_bottom, wall_text_rhs_top, wall_text_rhs_centre, wall_text_rhs_bottom,
         wall_lhs_text_x_offset_from_centre, wall_rhs_text_x_offset_from_centre);