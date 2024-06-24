import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonTextFormFilled extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? suffixIcon;
  final int? minLines;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  const CommonTextFormFilled(
      {super.key,
      this.controller,
      this.hintText,
      this.suffixIcon,
      this.contentPadding,
      this.minLines,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.alice(color: Colors.black, fontSize: 14),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
          suffixIcon: suffixIcon != null
              ? SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    suffixIcon ?? '',
                    fit: BoxFit.contain,
                  ),
                )
              : null,
          hintStyle: GoogleFonts.alice(color: Colors.black, fontSize: 16),
          hintText: hintText,
          filled: true,
          fillColor: Colors.blueAccent.withOpacity(0.1),
          contentPadding: contentPadding ??
              const EdgeInsets.only(top: 5, left: 10, right: 10),
          // border: OutlineInputBorder(
          //     borderSide: BorderSide(color: Colors.transparent),
          //     borderRadius: BorderRadius.circular(20))
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(8))),
    );
  }
}
