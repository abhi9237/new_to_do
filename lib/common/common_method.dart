import 'dart:developer';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

class CustomToast {
  static showToast(
    final String mesage, {
    final Color? bgColor,
    final Color? textColor,
  }) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 3),
      messageText: Text(
        mesage ?? '',
        style: GoogleFonts.alice(color: Colors.white, fontSize: 14),
      ),
      backgroundColor: bgColor ?? Colors.white,
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(Get.context!);
  }
}

Future<File> compressImage(XFile? pickedImage) async {
  File image = File('');
  if (pickedImage != null) {
    final bytes = await pickedImage.readAsBytes();
    final kb = bytes.length / 1024;
    final mb = kb / 1024;
    log('compress image size2:$mb');
    final dir = await getTemporaryDirectory();
    final targetPath =
        '${dir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final result = await FlutterImageCompress.compressAndGetFile(
      pickedImage.path,
      targetPath,
      minWidth: 1000,
      minHeight: 1000,
      quality: 90,
    );
    if (result != null) {
      final data = await result.readAsBytes();
      final newKb = data.length / 1024;
      final newMb = newKb / 1024;
      log('compress image size:$newMb');
      image = File(result.path);
      return image;
    } else {
      File img = File(pickedImage.path);
      return img;
    }
  }
  return image;
}
