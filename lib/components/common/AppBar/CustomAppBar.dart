import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomAppBar({super.key, this.showBackButton = false, required this.title});

  @override
  Widget build(BuildContext context) {
  final location = GoRouterState.of(context).uri.toString();

    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Theme.of(context).colorScheme.primary,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 28),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () => context.pop(),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 30,
        ),
      ),
      centerTitle: true,
      actions: [
        if (!location.startsWith('/account'))
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
            child: IconButton(
              icon: const Icon(Icons.person),
              iconSize: 40,
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                context.push('/account');
              },
            ),
          ),
      ],
    );
  }

  // Obligatoire pour PreferredSizeWidget
  @override
  Size get preferredSize => Size.fromHeight(80);
}
