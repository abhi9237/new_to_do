// import 'package:firebase_demo_app/insta_reel_example/stateless_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:instagram_crop_images_video/instagram_crop_images_video.dart';
//
// import 'insta_reel_description.dart';
//
// class InstaReelScreen extends StatefulWidget {
//   const InstaReelScreen({super.key});
//
//   @override
//   State<InstaReelScreen> createState() => _InstaReelScreenState();
// }
//
// class _InstaReelScreenState extends State<InstaReelScreen> {
//   Future<void> assetPicker(BuildContext context) async {
// // set picker theme based on app theme primary color
//     final theme = InstaAssetPicker.themeData(Theme.of(context).primaryColor);
//     InstaAssetPicker.pickAssets(
//       context,
//       maxAssets: 2,
//       // loadingIndicatorBuilder: (context, isAssetsEmpty) {
//       //   return const SizedBox();
//       // },
//       closeOnComplete: true,
//       actionsBuilder: (context, pickerTheme, height, unselectAll) {
//         return [1, 2, 3, 4, 4]
//             .map(
//               (e) => Container(
//                 width: 20,
//                 height: 20,
//                 color: Colors.red,
//               ),
//             )
//             .toList();
//       },
//       // selectedAssets: selectAssetEntity.value,
//       useRootNavigator: true,
//       // cropDelegate:
//       //     const InstaAssetCropDelegate(preferredSize: 1080, cropRatios: []),
//       pickerTheme: theme.copyWith(
//         canvasColor: Colors.black, // body background color
//         splashColor: Colors.grey, // ontap splash color
//         colorScheme: theme.colorScheme.copyWith(
//           background: Colors.black87, // albums list background color
//         ),
//         appBarTheme: theme.appBarTheme.copyWith(
//           backgroundColor: Colors.black, // app bar background color
//           titleTextStyle:
//               Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
//                     color: Colors.white,
//                   ), // change app bar title text style to be like app theme
//         ),
//         // edit `confirm` button style
//         textButtonTheme: TextButtonThemeData(
//           style: TextButton.styleFrom(
//             foregroundColor: Colors.blue,
//             disabledForegroundColor: Colors.red,
//           ),
//         ),
//       ),
//       onCompleted: (_) {
//         Navigator.pop(context);
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final List<InstaPickerInterface> pickers = [
//       // const SinglePicker(),
//       const MultiplePicker(),
//       // const RestorablePicker(),
//       // CameraPicker(camera: _cameras.first),
//       // const WeChatCameraPicker(),
//     ];
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Insta pickers')),
//       body: ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemBuilder: (BuildContext context, int index) {
//           final PickerDescription description = pickers[index].description;
//
//           return Card(
//             child: ListTile(
//               leading: Text(description.icon),
//               title: Text(description.label),
//               subtitle: description.description != null
//                   ? Text(description.description!)
//                   : null,
//               trailing: const Icon(Icons.chevron_right_rounded),
//               onTap: () => Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => pickers[index]),
//               ),
//             ),
//           );
//         },
//         separatorBuilder: (_, __) => const SizedBox(height: 4),
//         itemCount: pickers.length,
//       ),
//     );
//   }
// }
