import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Gap extends StatelessWidget {
  const Gap(this.size, {super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size, width: size);
  }
}

extension NumExtensions on num {
  Duration get second => Duration(seconds: round());

  Duration get microSec => Duration(microseconds: round());

  Duration get milliSec => Duration(milliseconds: round());
}

extension WidgetExtensions on Widget {
  Widget get expand => Expanded(child: this);

  Widget get padXX16 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: this);

  Widget padYY(double y) =>
      Padding(padding: EdgeInsets.symmetric(vertical: y), child: this);

  Widget padRight(double x) =>
      Padding(padding: EdgeInsets.only(right: x), child: this);

  Widget padLeft(double x) =>
      Padding(padding: EdgeInsets.only(left: x), child: this);

  Widget padTop(double x) =>
      Padding(padding: EdgeInsets.only(top: x), child: this);

  Widget padBottom(double x) =>
      Padding(padding: EdgeInsets.only(bottom: x), child: this);
}

extension StyleExtensions on TextStyle {
  TextStyle get makeBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get makeLato => GoogleFonts.lato(textStyle: this);
}

extension StringExtensions on String {
  String get toTitleCase {
    final firstLetter = this[0].toUpperCase();
    final remainingLetters = substring(1);
    return firstLetter + remainingLetters;
  }
}

TextStyle get titleStyle =>
    GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold);

TextStyle get subTitleStyle => GoogleFonts.lato(
    fontSize: 16, color: Get.textTheme.titleMedium?.color?.withOpacity(0.5));

TextStyle get textFieldTextStyle => GoogleFonts.lato(
    fontSize: 16,
    color: Get.textTheme.titleMedium?.color,
    fontWeight: FontWeight.w500);
