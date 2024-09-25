import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_portofolio/style/color_style.dart';

class FontFamily {
  static TextStyle textButton = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: ColorStyle.white,
    fontFamily: GoogleFonts.jost().fontFamily,
  );

  /// name style
  static TextStyle h1 = TextStyle(
    color: ColorStyle.white,
    fontSize: 48,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.marcellus().fontFamily,
  );

  // regular text style
  static TextStyle reguler = TextStyle(
    color: ColorStyle.white,
    fontSize: 18,
    fontWeight: FontWeight.w200,
    //'Noto Serif Bengali'
    fontFamily: GoogleFonts.jost().fontFamily,
  );

  //sub text style
  static TextStyle sub = TextStyle(
    color: ColorStyle.white,
    fontSize: 32,
    fontWeight: FontWeight.w500,
    fontFamily: GoogleFonts.jost().fontFamily,
  );

  // italic light roboto
  static TextStyle italic = TextStyle(
      color: ColorStyle.white,
      fontSize: 18,
      fontWeight: FontWeight.w200,
      // italic
      fontStyle: FontStyle.italic,
      fontFamily: GoogleFonts.jost().fontFamily);
  // title
  static TextStyle title = TextStyle(
    color: ColorStyle.white,
    fontSize: 36,
    fontWeight: FontWeight.w500,
    fontFamily: GoogleFonts.jost().fontFamily,
  );
}
