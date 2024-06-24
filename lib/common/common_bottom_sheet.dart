import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showMyBottomSheet(BuildContext context,
    {VoidCallback? onTapGallery, VoidCallback? onTapCamera}) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.sizeOf(context).height * 0.15,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Select',
                style: GoogleFonts.alice(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: onTapGallery,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Center(
                    child: Text(
                      'Gallery',
                      style: GoogleFonts.alice(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: onTapCamera,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Center(
                    child: Text(
                      'Camera',
                      style: GoogleFonts.alice(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        );
      });
}
