import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> isDragging = List.filled(5, false);

  final List<Color> containerColors = [
    Color(0xffea1e63),
    Color(0xfffd5822),
    Color(0xff3f51b5),
    Color(0xfffc5727),
    Color(0xffcddc37),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const iconSize = 50.0;
              const iconPadding = 8.0;
              final visibleIcons = isDragging.where((dragging) => !dragging).length + 1;
              final containerWidth = visibleIcons * (iconSize + iconPadding);

              return Draggable<int>(
                data: 5,
                feedback: Container(
                  width: containerWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black12.withOpacity(0.8),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) {
                      return Icon(
                        _getIcon(index),
                        color: Colors.blue,
                        size: iconSize,
                      );
                    }),
                  ),
                ),
                child: Container(
                  width: containerWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black12,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) {
                      return Visibility(
                        visible: !isDragging[index],
                        child: DragTarget<int>(
                          onWillAccept: (data) => data == index,
                          onAccept: (_) {
                            setState(() {
                              isDragging[index] = false;
                            });
                          },
                          builder: (context, candidateData, rejectedData) {
                            return Draggable<int>(
                              data: index,
                              feedback: Container(
                                width: 48,
                                height: 48,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: containerColors[index],
                                ),
                                child: Center(
                                  child: Icon(
                                    _getIcon(index),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onDragStarted: () {
                                setState(() {
                                  isDragging[index] = true;
                                });
                              },
                              onDraggableCanceled: (_, __) {
                                setState(() {
                                  isDragging[index] = false;
                                });
                              },
                              onDragCompleted: () {
                                setState(() {
                                  isDragging[index] = false;
                                });
                              },
                              child: Container(
                                width: 48,
                                height: 48,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: containerColors[index],
                                ),
                                child: Center(
                                  child: Icon(
                                    _getIcon(index),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  IconData _getIcon(int index) {
    List<IconData> icons = [
      Icons.person,
      Icons.message,
      Icons.call,
      Icons.camera,
      Icons.photo,
    ];
    return icons[index];
  }
}