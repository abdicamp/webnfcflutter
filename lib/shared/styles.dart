import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

// TextStyle
TextStyle primaryRegularTextStyle = GoogleFonts.poppins(
  color: BaseColors.primary,
  fontWeight: FontWeight.w400,
);

TextStyle primarySemiBoldTextStyle = GoogleFonts.poppins(
  color: BaseColors.primary,
  fontWeight: FontWeight.w600,
);

TextStyle primaryBoldTextStyle = GoogleFonts.poppins(
  color: BaseColors.primary,
  fontWeight: FontWeight.w700,
);

TextStyle mainRegularTextStyle = GoogleFonts.poppins(
  color: BaseColors.main,
  fontWeight: FontWeight.w400,
);

TextStyle mainSemiBoldTextStyle = GoogleFonts.poppins(
  color: BaseColors.main,
  fontWeight: FontWeight.w600,
);

TextStyle mainBoldTextStyle = GoogleFonts.poppins(
  color: BaseColors.main,
  fontWeight: FontWeight.w700,
);

TextStyle blackRegularTextStyle = GoogleFonts.poppins(
  color: BaseColors.black,
  fontWeight: FontWeight.w400,
);

TextStyle blackSemiBoldTextStyle = GoogleFonts.poppins(
  color: BaseColors.black,
  fontWeight: FontWeight.w600,
);

TextStyle blackBoldTextStyle = GoogleFonts.poppins(
  color: BaseColors.black,
  fontWeight: FontWeight.w700,
);

TextStyle whiteRegularTextStyle = GoogleFonts.poppins(
  color: Colors.white,
  fontWeight: FontWeight.w400,
);

TextStyle whiteSemiBoldTextStyle = GoogleFonts.poppins(
  color: Colors.white,
  fontWeight: FontWeight.w600,
);

TextStyle whiteBoldTextStyle = GoogleFonts.poppins(
  color: Colors.white,
  fontWeight: FontWeight.w700,
);

TextStyle greyRegularTextStyle = GoogleFonts.poppins(
  color: BaseColors.grey,
  fontWeight: FontWeight.w400,
);

TextStyle greySemiBoldTextStyle = GoogleFonts.poppins(
  color: BaseColors.grey,
  fontWeight: FontWeight.w600,
);

TextStyle greyBoldTextStyle = GoogleFonts.poppins(
  color: BaseColors.grey,
  fontWeight: FontWeight.w700,
);

TextStyle hintRegularTextStyle = GoogleFonts.poppins(
  color: BaseColors.hint,
  fontWeight: FontWeight.w400,
);

TextStyle hintSemiBoldTextStyle = GoogleFonts.poppins(
  color: BaseColors.hint,
  fontWeight: FontWeight.w600,
);

TextStyle hintBoldTextStyle = GoogleFonts.poppins(
  color: BaseColors.hint,
  fontWeight: FontWeight.w700,
);

TextStyle montserratRegularTextStyle = GoogleFonts.montserrat(
  color: BaseColors.black,
  fontWeight: FontWeight.w400,
);

TextStyle montserratSemiBoldTextStyle = GoogleFonts.montserrat(
  color: BaseColors.black,
  fontWeight: FontWeight.w600,
);

TextStyle montserratBoldTextStyle = GoogleFonts.lato(
  color: BaseColors.black,
  fontWeight: FontWeight.w700,
);

BoxShadow shadow = const BoxShadow(
  color: Colors.black12,
  blurRadius: 3,
  offset: Offset(0, 5),
);

BoxShadow textShadowWhite = const BoxShadow(
  color: Colors.white,
  blurRadius: 5,
  offset: Offset(0, 2),
);

BoxShadow textShadowMain = const BoxShadow(
  color: BaseColors.main,
  blurRadius: 5,
  offset: Offset(0, 2),
);

const loadingSpin = SpinKitFadingCircle(
  color: BaseColors.blue,
  size: 46.0,
);
