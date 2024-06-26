// import 'package:firebase_demo_app/insta_reel_example/picker_crop_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:instagram_crop_images_video/instagram_crop_images_video.dart';
//
// class PickerDescription {
//   final String icon;
//   final String label;
//   final String? description;
//
//   const PickerDescription({
//     required this.icon,
//     required this.label,
//     this.description,
//   });
//
//   String get fullLabel => '$icon $label';
// }
//
// mixin InstaPickerInterface on Widget {
//   PickerDescription get description;
//
//   ThemeData getPickerTheme(BuildContext context) {
//     return InstaAssetPicker.themeData(Colors.red).copyWith(
//       appBarTheme: const AppBarTheme(titleTextStyle: TextStyle(fontSize: 16)),
//     );
//   }
//
//   AppBar get _appBar => AppBar(title: Text(description.fullLabel));
//
//   Column pickerColumn({
//     String? text,
//     required VoidCallback onPressed,
//   }) =>
//       Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Center(
//             child: Text(
//               text ??
//                   'The ${description.label} will push result in a new screen',
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 18),
//             ),
//           ),
//           TextButton(
//             onPressed: onPressed,
//             child: FittedBox(
//               child: Text(
//                 'Open the ${description.label}',
//                 style: const TextStyle(fontSize: 20),
//               ),
//             ),
//           ),
//         ],
//       );
//
//   Scaffold buildLayout(
//     BuildContext context, {
//     required VoidCallback onPressed,
//   }) =>
//       Scaffold(
//         appBar: _appBar,
//         body: Padding(
//           padding: const EdgeInsets.all(16),
//           child: pickerColumn(onPressed: onPressed),
//         ),
//       );
//
//   Scaffold buildCustomLayout(
//     BuildContext context, {
//     required Widget child,
//   }) =>
//       Scaffold(
//         appBar: _appBar,
//         body: Padding(padding: const EdgeInsets.all(16), child: child),
//       );
//
//   void pickAssets(BuildContext context, {required int maxAssets}) =>
//       InstaAssetPicker.pickAssets(
//         context,
//         title: description.fullLabel,
//         closeOnComplete: true,
//         maxAssets: maxAssets,
//         pickerTheme: getPickerTheme(context),
//         onCompleted: (Stream<InstaAssetsExportDetails> cropStream) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   PickerCropResultScreen(cropStream: cropStream),
//             ),
//           );
//         },
//       );
// }
