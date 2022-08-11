import 'package:flutter/material.dart';
import 'package:quote_mobile_app/utils/constants/app_contants.dart';

class CustomListTile extends StatefulWidget {
  CustomListTile({
    Key? key,
    required this.type,
    required this.index,
    required this.title,
    required this.isSelected,
    required this.deleteAction,
    required this.editAction,
    required this.selectAction,
  }) : super(key: key);

  Screens type;
  int index;
  String title;
  bool isSelected;
  Function(int)? deleteAction;
  Function(int)? editAction;
  Function(int)? selectAction;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetConstants.kAll10,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsetConstants.kAll10,
          child: Row(
            children: [
              Visibility(
                visible: (widget.selectAction != null),
                child: IconButton(
                  onPressed: () {
                    widget.selectAction!(widget.index);
                  },
                  icon: (widget.isSelected)
                      ? const Icon(Icons.check_box_outlined)
                      : const Icon(Icons.check_box_outline_blank),
                ),
              ),
              Expanded(
                child: Text(
                  widget.title,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Visibility(
                visible: !(widget.isSelected) && (widget.editAction != null),
                child: IconButton(
                  onPressed: () {
                    widget.editAction!(widget.index);
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              Visibility(
                visible: !(widget.type == Screens.favourites_tab) &&
                    (widget.deleteAction != null),
                child: IconButton(
                  onPressed: () {
                    widget.deleteAction!(widget.index);
                  },
                  icon: widget.isSelected
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                ),
              ),
              Visibility(
                visible: (widget.type == Screens.favourites_tab) &&
                    (widget.deleteAction != null),
                child: IconButton(
                  onPressed: () {
                    widget.deleteAction!(widget.index);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
