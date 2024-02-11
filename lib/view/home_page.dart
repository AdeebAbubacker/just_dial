import 'package:flutter/material.dart';

class CustomDraggableScrollable extends StatefulWidget {
  const CustomDraggableScrollable({super.key});

  @override
  State<CustomDraggableScrollable> createState() =>
      _CustomDraggableScrollableState();
}

class _CustomDraggableScrollableState extends State<CustomDraggableScrollable> {
  double _scrollPosition1 = 437.0;
  double _scrollPosition2 = 437.0;
  final double _previousScrollPosition1 = 437.0;
  final double _previousScrollPosition2 = 437.0;
  final double _minScrollPosition2 = 420.0;
  final double _maxScrollPosition2 = 690.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Draggable Scrollable'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: _scrollPosition1,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  if (_scrollPosition2 >= _minScrollPosition2 &&
                      _scrollPosition2 <= _maxScrollPosition2) {
                    _scrollPosition1 += details.delta.dy;
                  }
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.cyan,
              ),
            ),
          ),
          Positioned(
            top: _scrollPosition2,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  _scrollPosition2 += details.delta.dy;
                  if (_scrollPosition2 >= _minScrollPosition2 &&
                      _scrollPosition2 <= _maxScrollPosition2) {
                    _scrollPosition1 -= 4.5 * details.delta.dy;
                  }
                });
              },
              onVerticalDragEnd: (details) {
                if (_scrollPosition2 <= _minScrollPosition2) {
                  setState(() {
                    _scrollPosition2 = _minScrollPosition2;
                  });
                } else if (_scrollPosition2 >= _maxScrollPosition2) {
                  setState(() {
                    _scrollPosition2 = _maxScrollPosition2;
                  });
                } else {
                  setState(() {
                    _scrollPosition1 = _previousScrollPosition1;
                    _scrollPosition2 = _previousScrollPosition2;
                  });
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: const Color.fromARGB(175, 212, 191, 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
