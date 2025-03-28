import 'package:turno/components/buttons/rounded_elevated_button.dart';
import 'package:turno/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turno/utils/routes.dart'; // or whatever your routes file path is

class MyAppBar extends StatefulWidget {
  final bool hiddenAppBar;
  final Function btnAction;
  final String btnText;
  final IconData btnIcon;
  const MyAppBar(
      {required this.hiddenAppBar,
      required this.btnAction,
      required this.btnText,
      required this.btnIcon,
      super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of(context, listen: false);
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.only(
              left: (widget.hiddenAppBar) ? 23 : 15,
              right: 15,
              bottom: (widget.hiddenAppBar) ? 25 : 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.menu);
                },
                style: (widget.hiddenAppBar)
                    ? const ButtonStyle(
                        padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 0, horizontal: 0)),
                        minimumSize: WidgetStatePropertyAll(Size.zero),
                        elevation: WidgetStatePropertyAll(5),
                        shadowColor: WidgetStatePropertyAll(Colors.black),
                      )
                    : null,
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Inner container for the image
                        Container(
                          width:
                              36, // Slightly smaller to leave room for border
                          height:
                              36, // Slightly smaller to leave room for border
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: (user.image != null && user.image != '')
                              ? Image.network(
                                  user.image!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "assets/images/user_placeholder.jpg",
                                  fit: BoxFit.cover,
                                ),
                        ),
                        // Outer container for the border
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2.5),
                          ),
                        ),
                      ],
                    ),
                    (!widget.hiddenAppBar)
                        ? const SizedBox(
                            width: 10,
                          )
                        : Container(),
                    (!widget.hiddenAppBar)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                user.entity ?? "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: (widget.hiddenAppBar) ? 0 : 4),
                child: RoundedElevatedButton(
                  onPressed: widget.btnAction,
                  showOnlyIcon: widget.hiddenAppBar,
                  icon: widget.btnIcon,
                  btnText: widget.btnText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
