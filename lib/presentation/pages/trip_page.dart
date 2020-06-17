import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterinovola/entities/trip.dart';
import 'package:flutterinovola/presentation/blocks/trip_block/bloc.dart';
import 'package:flutterinovola/presentation/widgets/custom_appbar_icon_button.dart';
import 'package:flutterinovola/presentation/widgets/custom_image_slider.dart';
import 'package:flutterinovola/presentation/widgets/custom_trip_appbar.dart';
import 'package:flutterinovola/presentation/widgets/order_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' as intl;

import '../../core/text_utils.dart';
import '../../injector.dart';

class TripPage extends StatefulWidget {
  TripPage({Key key}) : super(key: key);

  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  final _kOrderButtonHeight = 50.0;
  final _kImagesRatio = 0.35;
  var _appBarOpacityRatio = 0.0;
  final _kArabicDateFuture = initializeDateFormatting("ar_SA", null);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: BlocProvider<TripBloc>(
            create: (BuildContext context) => sl<TripBloc>(),
            child: BlocListener<TripBloc, TripState>(
              listener: (BuildContext context, state) {
                // TODO
              },
              child: BlocBuilder<TripBloc, TripState>(
                builder: (BuildContext context, TripState state) {
                  Widget childWidget;
                  if (state is Loading) {
                    childWidget = Center(
                      child: SpinKitCubeGrid(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  } else if (state is Loaded) {
                    childWidget = _buildPage(state.trip);
                  } else if (state is Reserved) {
                    childWidget = _buildPage(state.trip);
                  } else if (state is Error) {
                    childWidget = Stack(
                      children: <Widget>[
                        _buildBackButton(context),
                        Center(
                          child: Text(state.message),
                        ),
                      ],
                    );
                  } else {
                    childWidget = Container();
                  }
                  return AnimatedSwitcher(
                    child: childWidget,
                    duration: const Duration(seconds: 1),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildBackButton(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(
          MediaQuery.of(context).padding.top,
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor, shape: BoxShape.circle),
        child: CustomAppbarIconButton(
          onTap: _onBack,
          icon: Icons.arrow_back_ios,
        ));
  }

  Widget _buildPage(Trip model) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
      final height =
          max(constraint.maxHeight, constraint.maxWidth) - _kOrderButtonHeight;
      return Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).padding.top,
            right: 0.0,
            left: 0.0,
            child: CustomAppbar(
              favourite: model.isLiked,
              opacity: _appBarOpacityRatio,
              onFavourite: () {
                BlocProvider.of<TripBloc>(context).add(
                  SetLiked(!model.isLiked),
                );
              },
              onBack: _onBack,
              onShare: () {
                BlocProvider.of<TripBloc>(context).add(
                  ShareTrip(),
                );
              },
            ),
          ),
          Positioned.fill(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) =>
                        _onScrollNotification(notification, height),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          CustomImageSlider(
                            images: model.images,
                            height: height * _kImagesRatio,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _buildTitleBlock(model),
                                _buildDivider(),
                                _buildTrainerBlock(
                                  model.trainer,
                                ),
                                _buildDivider(),
                                _buildTripInfoBlock(model),
                                _buildDivider(),
                                _buildCostBlock(model),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                OrderButton(orderButtonHeight: _kOrderButtonHeight)
              ],
            ),
          ),
        ].reversed.toList(),
      );
    });
  }

  Widget _buildCostBlock(Trip model) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "تكلفة الدورة",
            style: Theme.of(context).textTheme.subtitle,
          ),
          Column(
            children: model.reservTypes.map((reserve) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    reserve.name,
                    style: Theme.of(context).textTheme.body1,
                  ),
//                Text(
//                  reserve.count.toString(),
//                  style: Theme.of(context).textTheme.body1,
//                ),
                  Text(
                    "SAR " + reserve.price.toString(),
                    style: Theme.of(context).textTheme.body1,
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      );
    });
  }

  Widget _buildTripInfoBlock(Trip model) {
    return LayoutBuilder(builder: (context, snapshot) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "عن الدورة",
            style: Theme.of(context).textTheme.subtitle,
          ),
          Text(
            model.occasionDetail,
            style: Theme.of(context).textTheme.body1,
          )
        ],
      );
    });
  }

  Widget _buildTrainerBlock(Trainer trainer) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: trainer.image,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => Center(
                    child: SpinKitFadingCircle(
                  color: Theme.of(context).primaryColor,
                )),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
//              CircleAvatar(
//                backgroundImage: NetworkImage(
//                  trainer.image,
//                ),
//              ),
              SizedBox(
                width: 8,
              ),
              Text(
                trainer.name,
                style: Theme.of(context).textTheme.subtitle,
              )
            ],
          ),
          Text(
            trainer.info,
            style: Theme.of(context).textTheme.body1,
          )
        ],
      );
    });
  }

  Widget _buildTitleBlock(Trip model) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "# " + model.interest,
            style: Theme.of(context).textTheme.body1,
          ),
          Text(
            model.title,
            style: Theme.of(context).textTheme.title,
          ),
          FutureBuilder<void>(
              future: _kArabicDateFuture,
              builder: (context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var formatter =
                      intl.DateFormat('EEE, d MMM, K:mm a ', 'ar_SA');
                  String formattedDate = formatter
                      .format(model.date)
                      .toEnglishNumbers()
                      .simplifyAmPm();
                  return _buildIconTextRow(
                      icon: FontAwesomeIcons.calendarAlt, text: formattedDate);
                } else {
                  return Container(
                    height: 15,
                    width: 15,
                    margin: const EdgeInsets.all(6.0),
                    child: SpinKitPouringHourglass(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }
              }),
          _buildIconTextRow(icon: Icons.pin_drop, text: model.address),
        ],
      );
    });
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Divider(
        thickness: 1.5,
      ),
    );
  }

  Widget _buildIconTextRow({IconData icon, String text}) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Theme.of(context).textTheme.body1.color,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.body1,
            )
          ],
        ),
      );
    });
  }

  bool _onScrollNotification(Notification notification, double height) {
    if (notification is ScrollUpdateNotification) {
      final offset = notification.metrics.pixels;
      setState(() {
        final imagesHeight = height * _kImagesRatio;
        _appBarOpacityRatio = (offset - imagesHeight / 3.0) / imagesHeight;
        _appBarOpacityRatio = _appBarOpacityRatio.clamp(0.0, 1.0);
      });
      return true;
    }
    return false;
  }

  void _onBack() {
    Navigator.of(context).pop();
  }
}
