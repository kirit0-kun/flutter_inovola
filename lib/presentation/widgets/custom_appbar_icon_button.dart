import 'package:flutter/material.dart';

class CustomAppbarIconButton extends StatelessWidget {
  final IconData icon;
  final Function onTap;

  const CustomAppbarIconButton({
    Key key,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      shape: CircleBorder(),
      child: InkResponse(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
