import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget progessLoader() {
  return const Center(
    child: SpinKitFadingCircle(
      color: CupertinoColors.systemBlue,
    ),
  );
}
