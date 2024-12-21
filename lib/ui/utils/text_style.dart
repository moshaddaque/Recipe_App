import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  static TextStyle poppins = GoogleFonts.poppins();
  static TextStyle titlePoppins = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );
  static TextStyle recipeTitle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static TextStyle singleRecipePageIngredients = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );
  static TextStyle singleRecipePageInstruction = GoogleFonts.poppins(
    fontSize: 20,
  );
}
