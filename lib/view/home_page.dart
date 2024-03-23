// import 'package:flutter/material.dart';

// class CustomDraggableScrollable extends StatefulWidget {
//   const CustomDraggableScrollable({super.key});

//   @override
//   State<CustomDraggableScrollable> createState() =>
//       _CustomDraggableScrollableState();
// }

// class _CustomDraggableScrollableState extends State<CustomDraggableScrollable> {
//   double _scrollPosition1 = 437.0;
//   double _scrollPosition2 = 437.0;
//   final double _previousScrollPosition1 = 437.0;
//   final double _previousScrollPosition2 = 437.0;
//   final double _minScrollPosition2 = 420.0;
//   final double _maxScrollPosition2 = 690.0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Custom Draggable Scrollable'),
//       ),
//       body: Stack(
//         children: [
//           Positioned(
//             top: _scrollPosition1,
//             child: GestureDetector(
//               onVerticalDragUpdate: (details) {
//                 setState(() {
//                   if (_scrollPosition2 >= _minScrollPosition2 &&
//                       _scrollPosition2 <= _maxScrollPosition2) {
//                     _scrollPosition1 += details.delta.dy;
//                   }
//                 });
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 color: Colors.cyan,
//               ),
//             ),
//           ),
//           Positioned(
//             top: _scrollPosition2,
//             child: GestureDetector(
//               onVerticalDragUpdate: (details) {
//                 setState(() {
//                   _scrollPosition2 += details.delta.dy;
//                   if (_scrollPosition2 >= _minScrollPosition2 &&
//                       _scrollPosition2 <= _maxScrollPosition2) {
//                     _scrollPosition1 -= 4.5 * details.delta.dy;
//                   }
//                 });
//               },
//               onVerticalDragEnd: (details) {
//                 if (_scrollPosition2 <= _minScrollPosition2) {
//                   setState(() {
//                     _scrollPosition2 = _minScrollPosition2;
//                   });
//                 } else if (_scrollPosition2 >= _maxScrollPosition2) {
//                   setState(() {
//                     _scrollPosition2 = _maxScrollPosition2;
//                   });
//                 } else {
//                   setState(() {
//                     _scrollPosition1 = _previousScrollPosition1;
//                     _scrollPosition2 = _previousScrollPosition2;
//                   });
//                 }
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 color: const Color.fromARGB(175, 212, 191, 0),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:snapping_bottom_sheet/snapping_bottom_sheet.dart';

const Color mapsBlue = Color(0xFF4185F3);

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  ExampleState createState() => ExampleState();
}

class ExampleState extends State<Example> {
  late SheetController controller1;
  late SheetController controller2;
  late ValueNotifier<Color> colorNotifier;

  @override
  void initState() {
    super.initState();
    // Initialize the controller
    controller1 = SheetController();
    controller2 = SheetController();
    colorNotifier = ValueNotifier<Color>(Colors.transparent);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {});
      Timer.periodic(Duration(milliseconds: 16), (timer) {
        // Ensure controller.state is not null before accessing currentScrollOffset
        if (controller1.state != null) {
          double extent = controller1.state!.extent;
          if (extent >= 0.4 && extent <= 0.7) {
            // Calculate color based on the current extent
            Color color = calculateColor(extent);
            colorNotifier.value = color;
          }
        }
      });
    });
  }

  Color calculateColor(double extent) {
    double startExtent = 0.4;
    double endExtent = 0.7;

    // Define colors for interpolation
    Color startColor = Color.fromRGBO(226, 97, 97, 0.4); // Red with alpha 100
    Color endColor = Color.fromRGBO(255, 0, 0, 1.0); // Red with alpha 255

    // Calculate normalized value between start and end extents
    double t = (extent - startExtent) / (endExtent - startExtent);

    // Interpolate between start and end colors
    int r = startColor.red;
    int g = startColor.green;
    int b = startColor.blue;
    int alpha =
        (startColor.alpha + (t * (endColor.alpha - startColor.alpha))).toInt();

    // Return the interpolated color
    return Color.fromARGB(alpha, r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            buildSheet1(),
            buildSheet2(),
          ],
        ),
      ),
    );
  }

  Widget buildSheet1() {
    return ValueListenableBuilder(
      valueListenable: colorNotifier,
      builder: (context, color, _) {
        return SnappingBottomSheet(
          duration: const Duration(milliseconds: 200),
          controller: controller1,
          color: color,
          shadowColor: Colors.black26,
          elevation: 12,
          maxWidth: 500,
          cornerRadius: 16,
          cornerRadiusOnFullscreen: 0.0,
          closeOnBackdropTap: true,
          closeOnBackButtonPressed: true,
          addTopViewPaddingOnFullscreen: true,
          isBackdropInteractable: true,
          border: Border.all(
            color: Colors.grey.shade300,
            width: 3,
          ),
          snapSpec: SnapSpec(
            initialSnap: 0.4,
            snap: true,
            positioning: SnapPositioning.relativeToAvailableSpace,
            snappings: const [
              0.4, // Initial snapping point
              0.9,
              0.3,
            ],
            onSnap: (state, snap) {
              log('Snapped to $snap');
            },
          ),
          parallaxSpec: const ParallaxSpec(
            enabled: true,
            amount: 0.35,
            endExtent: 0.6,
          ),
          liftOnScrollHeaderElevation: 12.0,
          liftOnScrollFooterElevation: 12.0,
          footerBuilder: buildFooter,
          customBuilder: buildInfiniteChild,
        );
      },
    );
  }

//footer isnide
  Widget buildFooter(BuildContext context, SheetState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color.fromARGB(255, 255, 255, 255),
      child: const Row(
        children: <Widget>[Text('footer')],
      ),
    );
  }

// 1 to 100 list
  Widget buildInfiniteChild(
    BuildContext context,
    ScrollController controller,
    SheetState state,
  ) {
    return ListView.builder(
      controller: controller,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      itemCount: 100,
    );
  }

  Widget buildSheet2() {
    double previousSnap = 0.4;
    return SnappingBottomSheet(
      listener: (state) {
        setState(() {
          if (controller1.state != null) {
            double currentExtent = state.extent;
            double maxExtent = controller1.state!.maxExtent;

            double currentSnap = 1.0 - (currentExtent / maxExtent);
            double snapDifference = previousSnap - currentSnap;

            double position = (1 - currentSnap + snapDifference) * maxExtent;
            print('currentsnap = ${currentSnap}');

            // Check if currentSnap is within the specified range
            if (currentSnap >= 0.2 && currentSnap <= 0.9) {
              // Sudden increase from 0.45 to 0.77 within the range of 0.2 to 0.9
              if (currentSnap > 0.6) {
                currentSnap = 0.9;
                controller1.snapToExtent(currentSnap,
                    duration: Duration(milliseconds: 700));
              }
              if (currentSnap < 0.6) {
                currentSnap = 0.4;
                controller1.snapToExtent(currentSnap,
                    duration: Duration(milliseconds: 700));
              }
            }
            previousSnap = currentSnap;
          }
        });
      },
      duration: const Duration(milliseconds: 200),
      controller: controller2,
      color: Color.fromARGB(125, 61, 236, 113),
      shadowColor: Colors.black26,
      elevation: 12,
      maxWidth: 500,
      cornerRadius: 16,
      cornerRadiusOnFullscreen: 0.0,
      closeOnBackdropTap: true,
      closeOnBackButtonPressed: true,
      addTopViewPaddingOnFullscreen: true,
      isBackdropInteractable: true,
      border: Border.all(
        color: Colors.grey.shade300,
        width: 3,
      ),
      snapSpec: SnapSpec(
        initialSnap: 0.4,
        snap: true,
        positioning: SnapPositioning.relativeToAvailableSpace,
        snappings: const [
          0.4, // Initial snapping point
          0.9,
          0.3,
        ],
        onSnap: (state, snap) {
          log('Snapped to $snap');
        },
      ),
      parallaxSpec: const ParallaxSpec(
        enabled: true,
        amount: 0.35,
        endExtent: 0.6,
      ),
      liftOnScrollHeaderElevation: 12.0,
      liftOnScrollFooterElevation: 12.0,
      footerBuilder: buildFooter,
      customBuilder: buildInfiniteChild,
    );
  }

//footer isnide
  Widget buildFooter2(BuildContext context, SheetState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: const Row(
        children: <Widget>[Text('footer')],
      ),
    );
  }

// 1 to 100 list
  Widget buildInfiniteChild2(
    BuildContext context,
    ScrollController controller2,
    SheetState state,
  ) {
    return ListView.builder(
      controller: controller2,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      itemCount: 100,
    );
  }
}
