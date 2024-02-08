// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   HomePage({super.key});

//   List<Icon> myicons = [
//     const Icon(Icons.add_to_photos_rounded, color: Colors.blue),
//     Icon(Icons.air_outlined, color: Colors.red),
//     Icon(Icons.adobe, color: Colors.green),
//     Icon(Icons.search, color: Colors.yellow),
//     Icon(Icons.access_alarm, color: Colors.orange),
//     Icon(Icons.accessibility, color: Colors.purple),
//     Icon(Icons.account_balance, color: Colors.teal),
//     Icon(Icons.account_circle, color: Colors.pink),
//     Icon(Icons.account_tree, color: Colors.deepPurple),
//     Icon(Icons.add, color: Colors.indigo),
//     Icon(Icons.add_a_photo, color: Colors.amber),
//     Icon(Icons.add_alarm, color: Colors.lightGreen),
//     Icon(Icons.add_alert, color: Colors.lightBlue),
//     Icon(Icons.add_box, color: Colors.deepOrange),
//     Icon(Icons.add_business, color: Colors.cyan),
//     Icon(Icons.add_chart, color: Colors.brown),
//     Icon(Icons.add_circle, color: Colors.grey),
//     Icon(Icons.add_comment, color: Colors.lime),
//     Icon(Icons.add_ic_call, color: Colors.blueGrey),
//     Icon(Icons.add_link, color: Colors.redAccent),
//     Icon(Icons.add_location, color: Colors.greenAccent),
//     Icon(Icons.add_moderator, color: Colors.lightGreenAccent),
//     Icon(Icons.add_photo_alternate, color: Colors.blueAccent),
//     Icon(Icons.add_reaction, color: Colors.deepOrangeAccent),
//     Icon(Icons.add_road, color: Colors.cyanAccent),
//     Icon(Icons.add_shopping_cart, color: Colors.purpleAccent),
//     Icon(Icons.add_task, color: Colors.tealAccent),
//     Icon(Icons.add_to_drive, color: Colors.amberAccent),
//     Icon(Icons.add_to_home_screen, color: Colors.deepPurpleAccent),
//     Icon(Icons.add_to_queue, color: Colors.indigoAccent),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: Center(
//           child: Stack(
//             children: [
//               Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       height: 50,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: 390,
//                     height: 590,
//                     child: GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: myicons.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 5),
//                       itemBuilder: (context, index) {
//                         return SizedBox(
//                           width: 40,
//                           height: 40,
//                           child: myicons[index],
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Stack(
//                 children: [
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       width: 100,
//                       height: 50,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: CustomBottomSheet(title: 'dfd'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         elevation: 16,
//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'ss',
//               backgroundColor: Color.fromARGB(255, 64, 80, 255)),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: 'zzz'),
//           BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'zzzz'),
//           BottomNavigationBarItem(icon: Icon(Icons.delete), label: 'aaa'),
//         ],
//       ),
//     );
//   }
// }



// class CustomBottomSheet extends StatefulWidget {
//   final double bottomSheetheight;
//   final String title;
//   final String hintText;
//   final List<String> listofData;
//   const CustomBottomSheet(
//       {Key? key,
//       this.listofData = const [],
//       required this.title,
//       this.bottomSheetheight = 0.9,
//       this.hintText = ''})
//       : super(key: key);

//   @override
//   State<CustomBottomSheet> createState() => _customBottomSheetCopyState();
// }

// // ignore: camel_case_types
// class _customBottomSheetCopyState extends State<CustomBottomSheet> {
//   final List<String> emptyList = [];
//   final TextEditingController textController = TextEditingController();
//   bool visibilty = false;
//   @override
//   void initState() {
//     super.initState();
//     // Call _showModal method when the widget is initialized
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       _showModal(context);
//     });
//   }

//   // void _showModal(context) {
//   //   double currentChildSize = 0.4; // Initial size when opened
//   //   double minChildSize = 0.1; // Minimum size when dragging back
//   //   double maxChildSize = widget.bottomSheetheight;

//   //   showModalBottomSheet(
//   //     isScrollControlled: true,
//   //     shape: const RoundedRectangleBorder(
//   //       borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
//   //     ),
//   //     context: context,
//   //     isDismissible: false, // Disable dismiss on tap outside
//   //     builder: (context) {
//   //       return StatefulBuilder(

//   //         builder: (BuildContext context, StateSetter setState) {
//   //           return GestureDetector(
//   //             onTap: () {
//   //               // Do nothing on tap to prevent the modal from closing
//   //             },
//   //             child: DraggableScrollableSheet(
//   //               shouldCloseOnMinExtent: false,
//   //               initialChildSize: currentChildSize,
//   //               minChildSize: minChildSize,
//   //               maxChildSize: maxChildSize,
//   //               expand: false,
//   //               builder:
//   //                   (BuildContext context, ScrollController scrollController) {
//   //                 return Column(
//   //                   children: [
//   //                     Padding(
//   //                       padding: const EdgeInsets.only(
//   //                         left: 14,
//   //                         top: 8,
//   //                         right: 14,
//   //                         bottom: 8,
//   //                       ),
//   //                       child: Row(
//   //                         children: [
//   //                           Expanded(child: Container()),
//   //                         ],
//   //                       ),
//   //                     ),
//   //                     Expanded(
//   //                       child: ListView.separated(
//   //                         controller: scrollController,
//   //                         itemCount: (widget.listofData.isNotEmpty)
//   //                             ? widget.listofData.length
//   //                             : emptyList.length,
//   //                         separatorBuilder: (context, index) {
//   //                           return const Divider();
//   //                         },
//   //                         itemBuilder: (context, index) {
//   //                           return InkWell(
//   //                             onTap: () {
//   //                               Navigator.of(context).pop();
//   //                             },
//   //                           );
//   //                         },
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 );
//   //               },
//   //             ),
//   //           );
//   //         },
//   //       );
//   //     },
//   //   );
//   // }

//   void _showModal(context) {
//     double currentChildSize = 0.4; // Initial size when opened
//     double minChildSize = 0.1; // Minimum size when dragging back
//     double maxChildSize = widget.bottomSheetheight;

//     showModalBottomSheet(
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
//       ),
//       context: context,
//       isDismissible: false, // Disable dismiss on tap outside
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return GestureDetector(
//               onTap: () {
//                 // Do nothing on tap to prevent the modal from closing
//               },
//               child: WillPopScope(
//                 onWillPop: () async {
//                   // Prevents the back button from popping the modal
//                   return false;
//                 },
//                 child: DraggableScrollableSheet(
//                   shouldCloseOnMinExtent: false,
//                   initialChildSize: currentChildSize,
//                   minChildSize: minChildSize,
//                   maxChildSize: maxChildSize,
//                   expand: false,
//                   builder: (BuildContext context,
//                       ScrollController scrollController) {
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             left: 14,
//                             top: 8,
//                             right: 14,
//                             bottom: 8,
//                           ),
//                           child: Row(
//                             children: [
//                               Expanded(child: Container()),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: ListView.separated(
//                             controller: scrollController,
//                             itemCount: (widget.listofData.isNotEmpty)
//                                 ? widget.listofData.length
//                                 : emptyList.length,
//                             separatorBuilder: (context, index) {
//                               return const Divider();
//                             },
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final deviceWidth = MediaQuery.of(context).size.width;
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Stack(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       _showModal(context);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 2.0),
//                       child: SizedBox(
//                         width: deviceWidth * 0.69,
//                         height: 48,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


//----------------------------------------------------------------------------------------

// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   double currentChildSize = 0.4; // Initial size when opened

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: Center(
//           child: Stack(
//             children: [
//               // Main bottom sheet
//               DraggableScrollableSheet(
//                 initialChildSize: currentChildSize,
//                 minChildSize: 0.3,
//                 maxChildSize: 0.9,

//                 builder:
//                     (BuildContext context, ScrollController scrollController) {
//                   return CustomBottomSheet(
//                     title: 'Main Bottom Sheet',
//                     scrollController: scrollController,
//                   );
//                 },
//               ),
//               // Hidden bottom sheet
//               DraggableScrollableSheet(
//                 initialChildSize: currentChildSize,
//                 minChildSize: 0.3,
//                 maxChildSize: 0.9,
//                 builder:
//                     (BuildContext context, ScrollController scrollController) {
//                   return CustomHiddenBottomSheet(
//                     title: 'Hidden Bottom Sheet',
//                     scrollController: scrollController,
//                   );
//                 },
//               ),
//               Text('data'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
