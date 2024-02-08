import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double initialChildSize = 0.4;
  final ValueNotifier<double> currentChildSizeNotifier = ValueNotifier(0.4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simultaneous Draggable Bottom Sheets'),
      ),
      body: SafeArea(
        child: ValueListenableBuilder<double>(
          valueListenable: currentChildSizeNotifier,
          builder: (context, currentChildSize, child) {
            return Stack(
              children: [
                AnimatedBuilder(
                  animation: currentChildSizeNotifier,
                  builder: (context, child) => DraggableScrollableSheet(
                    initialChildSize: currentChildSize,
                    minChildSize: 0.3,
                    maxChildSize: 0.9,
                    builder: (context, scrollController) => CustomBottomSheet(
                      title: 'Hidden  Bottom Sheet',
                      scrollController: scrollController,
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: currentChildSizeNotifier,
                  builder: (context, child) => DraggableScrollableSheet(
                    initialChildSize: currentChildSize,
                    minChildSize: 0.3,
                    maxChildSize: 0.9,
                    builder: (context, scrollController) =>
                        CustomHiddenBottomSheet(
                      title: ' Main Bottom Sheet',
                      scrollController: scrollController,
                    ),
                  ),
                ),
                const Center(child: Text('data')),
              ],
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
      color: Colors.blue,
      child: ListView.builder(
        controller: scrollController,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('$title Item $index'),
          );
        },
      ),
    );
  }
}

class CustomHiddenBottomSheet extends StatelessWidget {
  final String title;
  final ScrollController scrollController;

  const CustomHiddenBottomSheet({
    Key? key,
    required this.title,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: ListView.builder(
        controller: scrollController,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('$title Item $index'),
          );
        },
      ),
    );
  }
}
