import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title = "Quittance";
  final bool showBackButton;

  const CustomAppBar({Key? key, this.showBackButton = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 30,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.person),
              iconSize: 40,
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                context.push('/account');
              },
            ),
          ),
        ),
      ],
    );
  }

  // Obligatoire pour PreferredSizeWidget
  @override
  Size get preferredSize => Size.fromHeight(80);
}
