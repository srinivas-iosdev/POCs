import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  CustomListTile({
    Key? key,
    required this.title,
    required this.isEditing,
    required this.isSelected,
    required this.deleteAction,
    required this.editAction,
    required this.selectAction,
  }) : super(key: key);

  String title;
  bool isEditing;
  bool isSelected;
  Function deleteAction;
  Function editAction;
  Function selectAction;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 2,
        child: Row(
          children: [
            Visibility(
              visible: !widget.isEditing,
              child: IconButton(
                onPressed: () => widget.selectAction,
                icon: const Icon(Icons.check_box_outline_blank),
              ),
            ),
            Text(widget.title),
            Visibility(
              visible: !(widget.isEditing || widget.isSelected),
              child: IconButton(
                onPressed: () => widget.editAction,
                icon: const Icon(Icons.edit),
              ),
            ),
            IconButton(
              onPressed: () => widget.deleteAction,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
