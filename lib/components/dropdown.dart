import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final int active;
  final List<String> items;
  final Function onChanged;
  const CustomDropdown(
      {required this.active,
      required this.items,
      required this.onChanged,
      super.key});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late GlobalKey actionKey;
  late double height,
      width,
      xPosition,
      yPosition,
      //     screenHeight,
      maxHeight;
  //     itemsHeight;
  bool isDropdownOpened = false;
  late OverlayEntry floatingDropdown;

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.items[0]);
    super.initState();
  }

  void findDropdownData() {
    RenderBox? renderBox =
        actionKey.currentContext!.findRenderObject() as RenderBox?;
    height = renderBox!.size.height - 10;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
    //   screenHeight = MediaQuery.of(context).size.height;
    maxHeight = 165;
    //   itemsHeight = widget.items.length * height;
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Stack(
        children: [
          GestureDetector(
            onTap: dropdownOpenClose,
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            left: xPosition,
            width: width,
            top: yPosition + 39,
            child: Container(
              height: widget.items.length * 35 + 15,
              constraints: const BoxConstraints(maxHeight: 165),
              decoration: BoxDecoration(
                  border: Border.all(color: ThemeStyle.primary, width: 1),
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(5))),
              child: DropDown(
                itemHeight: height,
                maxHeight: maxHeight,
                items: widget.items,
                active: widget.active,
                onClick: dropdownOpenClose,
                onChange: widget.onChanged,
              ),
            ),
          ),
        ],
      );
    });
  }

  dropdownOpenClose() {
    if (isDropdownOpened) {
      floatingDropdown.remove();
    } else {
      findDropdownData();
      floatingDropdown = _createFloatingDropdown();
      Overlay.of(context).insert(floatingDropdown);
    }
    setState(() {
      isDropdownOpened = !isDropdownOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: dropdownOpenClose,
      child: SizedBox(
        height: 40,
        child: Container(
          // margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: (isDropdownOpened)
                      ? ThemeStyle.primary
                      : ThemeStyle.borderGray),
              borderRadius: BorderRadius.vertical(
                  top: const Radius.circular(5),
                  bottom: (isDropdownOpened)
                      ? Radius.zero
                      : const Radius.circular(5))
              // .circular(5),
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.active >= 0
                  ? widget.items[widget.active]
                  : widget.items[0]),
              Icon(
                (isDropdownOpened)
                    ? Icons.expand_less_outlined
                    : Icons.expand_more_outlined,
                color: ThemeStyle.primary,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DropDown extends StatelessWidget {
  const DropDown({
    super.key,
    required this.itemHeight,
    required this.maxHeight,
    required this.items,
    required this.active,
    required this.onClick,
    required this.onChange,
  });

  final double itemHeight;
  final double maxHeight;
  final List items;
  final int active;
  final Function onClick;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(5)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 5.0, bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < items.length; i++)
                DropDownItem(
                  text: items[i],
                  isSelected: (active == i) ? true : false,
                  height: itemHeight,
                  onChange: () {
                    onChange(i);
                    onClick();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class DropDownItem extends StatelessWidget {
  const DropDownItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.height,
    required this.onChange,
  });

  final String text;
  final bool isSelected;
  final double height;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChange();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        alignment: Alignment.centerLeft,
        height: height,
        decoration: BoxDecoration(
            color: (isSelected) ? ThemeStyle.primary : Colors.white,
            borderRadius: BorderRadius.circular(5)),
        child: Text(text,
            style: (isSelected)
                ? ThemeStyle.textStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)
                : ThemeStyle.textStyle()),
      ),
    );
  }
}
