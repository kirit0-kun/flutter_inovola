import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'custom_appbar_icon_button.dart';

class CustomAppbar extends StatefulWidget {
  final bool favourite;
  final Function onFavourite;
  final Function onBack;
  final Function onShare;
  final double opacity;

  const CustomAppbar(
      {Key key,
      this.favourite,
      this.onFavourite,
      this.onBack,
      this.onShare,
      this.opacity})
      : super(key: key);

  @override
  _CustomAppbarState createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  Color oldColor = Colors.transparent;
  Color newColor = Colors.transparent;
  Color backColor;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 0), () {
      backColor = Theme.of(context).primaryColor;
    });
    super.initState();
  }

  @override
  void didUpdateWidget(CustomAppbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldColor = newColor;
    newColor = Color.lerp(Colors.transparent, backColor, widget.opacity);
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: ColorTween(begin: oldColor, end: newColor),
      duration: Duration(milliseconds: 200),
      builder: (BuildContext context, Color color, child) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: backColor,
          statusBarColor: color,
        ));
        return Ink(
          color: color,
          height: AppBar().preferredSize.height,
          child: child,
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomAppbarIconButton(
            icon: Icons.arrow_back_ios,
            onTap: widget.onBack,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomAppbarIconButton(
                  icon: FontAwesomeIcons.shareAlt, onTap: widget.onShare),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomAppbarIconButton(
                    icon: widget.favourite
                        ? FontAwesomeIcons.solidStar
                        : FontAwesomeIcons.star,
                    onTap: widget.onFavourite),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LaggyCustomAppbar extends StatelessWidget {
  final bool favourite;
  final Function onFavourite;
  final Function onBack;
  final Function onShare;
  final double opacity;

  const LaggyCustomAppbar(
      {Key key,
      this.favourite,
      this.onFavourite,
      this.onBack,
      this.onShare,
      this.opacity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backColor = Theme.of(context).primaryColor;
    final finalColor = Color.lerp(Colors.transparent, backColor, opacity);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: backColor, // navigation bar color
      statusBarColor: finalColor, // status bar color
    ));

    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      color: finalColor,
      height: AppBar().preferredSize.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomAppbarIconButton(
            icon: Icons.arrow_back_ios,
            onTap: onBack,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomAppbarIconButton(icon: Icons.share, onTap: onShare),
              CustomAppbarIconButton(
                  icon: favourite ? Icons.star : Icons.star_border,
                  onTap: onFavourite)
            ],
          ),
        ],
      ),
    );
  }
}
