import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key key, this.title, this.leading, this.actions})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String title;
  final Widget leading;
  final List<Widget> actions;

  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        elevation: 0,
        actions: widget.actions,
        leading: widget.leading,
        title: (widget.title != null)
            ? Text(
                translate(widget.title).toLowerCase(),
                style: const TextStyle(
                    letterSpacing: 2,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500),
              )
            : null);
  }
}
