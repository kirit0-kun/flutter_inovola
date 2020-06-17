import 'package:flutter/material.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({
    Key key,
    @required this.orderButtonHeight,
  }) : super(key: key);

  final double orderButtonHeight;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).accentColor,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: orderButtonHeight,
          width: double.infinity,
          child: Center(
            child: Text(
              "قم بالحجز الآن",
              style: Theme.of(context).textTheme.button.copyWith(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
