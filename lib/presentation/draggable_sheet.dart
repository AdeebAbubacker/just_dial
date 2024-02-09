// import 'dart:async';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late ScrollController mainBottomSheetController;
//   late ScrollController hiddenBottomSheetController;
//   late Timer timer;
//     bool showData11 = false;

//   @override
//   void initState() {
//     super.initState();
//     mainBottomSheetController = ScrollController();
//     hiddenBottomSheetController = ScrollController();
//     // Start the timer when the widget is initialized

//     // Start the timer when the widget is initialized
//     timer = Timer.periodic(Duration(seconds: 2), (timer) {
//       print(
//           'Hidden Bottom Sheet Scroll Extent: ${hiddenBottomSheetController.position.extentAfter}');
//       print(
//           'Main Bottom Sheet Scroll Extent: ${mainBottomSheetController.position.extentAfter}');
//      if (mainBottomSheetController.hasClients &&
//           mainBottomSheetController.offset > 500) {
//         setState(() {
//           showData11 = true;
//         });
//       } else {
//         setState(() {
//           showData11 = false;
//         });
//       }
//     });
//   }

//   double currentChildSize1 = 0.4;
//   double currentChildSize2 = 0.9;

//   void updateHiddenBottomSheetSize(double extent) {
//     print('haai');
//     if (extent >= 0.4 && extent <= 0.6) {
//       setState(() {
//         currentChildSize2 = 0.9 - extent + 0.4;
//       });
//     } else if (extent < 0.4) {
//       setState(() {
//         currentChildSize2 = 1.0;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: Center(
//           child: Stack(
//             children: [
//               //  Main bottom sheet
//               DraggableScrollableSheet(
//                 initialChildSize: currentChildSize1,
//                 minChildSize: 0.35,
//                 maxChildSize: 0.9,
//                 builder:
//                     (BuildContext context, ScrollController scrollController) {
//                   mainBottomSheetController = scrollController;
//                   return CustomBottomSheet(
//                     title: 'Main Bottom Sheet',
//                     scrollController: mainBottomSheetController,
//                   );
//                 },
//               ),
//               // Hidden bottom sheet
//               DraggableScrollableSheet(
//                 initialChildSize: currentChildSize2,
//                 minChildSize: 0.3,
//                 maxChildSize: 1.0,
//                 builder:
//                     (BuildContext context, ScrollController scrollController) {
//                   hiddenBottomSheetController = scrollController;

//                   return CustomHiddenBottomSheet(
//                     title: 'Hidden Bottom Sheet',
//                     scrollController: hiddenBottomSheetController,
//                   );
//                 },
//               ),
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 child: showData11 ? Text('data11') : Text('data22'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomBottomSheet extends StatelessWidget {
//   final String title;
//   final ScrollController scrollController;

//   const CustomBottomSheet({
//     Key? key,
//     required this.title,
//     required this.scrollController,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Color.fromARGB(255, 80, 183, 252),
//       child: ListView.builder(
//         controller: scrollController,
//         itemCount: 20,
//         itemBuilder: (BuildContext context, int index) {
//           return const ListTile(
//             title: Text(''),
//           );
//         },
//       ),
//     );
//   }
// }

// class CustomHiddenBottomSheet extends StatelessWidget {
//   final String title;
//   final ScrollController scrollController;

//   const CustomHiddenBottomSheet({
//     Key? key,
//     required this.title,
//     required this.scrollController,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color.fromARGB(255, 252, 91, 80),
//       child: ListView.builder(
//         controller: scrollController,
//         itemCount: 20,
//         itemBuilder: (BuildContext context, int index) {
//           return const ListTile(
//             title: Text(''),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController mainBottomSheetController;
  late StreamController<ScrollController?> controllerStream;

  late Timer timer;
  bool showData11 = false;
  bool controllerAttached = false;

  @override
  void initState() {
    super.initState();
    mainBottomSheetController = ScrollController();
    controllerStream = StreamController<ScrollController?>.broadcast();
    controllerStream.add(mainBottomSheetController);

    // Start the timer when the widget is initialized
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (mainBottomSheetController.hasClients) {
        print(
            'Main Bottom Sheet Scroll Extent: ${mainBottomSheetController.position.extentAfter}');
        if (mainBottomSheetController.offset > 500) {
          setState(() {
            showData11 = true;
          });
        } else {
          setState(() {
            showData11 = false;
          });
        }
      }
      controllerStream
          .add(mainBottomSheetController); // Emit event on controller change
    });
  }

  @override
  void dispose() {
    controllerStream.close();
    timer.cancel();
    super.dispose();
  }

  double currentChildSize1 = 0.4;
  double currentChildSize2 = 0.9;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: StreamBuilder<ScrollController?>(
                    stream: controllerStream.stream,
                    initialData: mainBottomSheetController,
                    builder: (context, snapshot) {
                      final ScrollController? controller = snapshot.data;
                      if (controller != null && controller.hasClients) {
                        controllerAttached = true;
                        return Stack(
                          children: [
                            Center(
                              child: DraggableScrollableSheet(
                                initialChildSize: currentChildSize1,
                                minChildSize: 0.35,
                                maxChildSize: 0.9,
                                builder: (BuildContext context,
                                    ScrollController scrollController) {
                                  return CustomBottomSheet(
                                    title: 'Main Bottom Sheet',
                                    scrollController: controller,
                                  );
                                },
                              ),
                            ),
                            if (showData11)
                              Text(
                                'Main Bottom Sheet Scroll Extent: ${controller.position.extentAfter}',
                              )
                          ],
                        );
                      } else {
                        if (!controllerAttached) {
                          return Text(
                              ' waiting for controller'); // Placeholder widget while waiting for controller
                        } else {
                          return Text('Controller not attached');
                        }
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final ScrollController scrollController;

  const CustomBottomSheet({
    Key? key,
    required this.title,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      color: Color.fromARGB(255, 80, 183, 252),
      child: ListView.builder(
        controller: scrollController,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return const ListTile(
            title: Text(''),
          );
        },
      ),
    );
  }
}
