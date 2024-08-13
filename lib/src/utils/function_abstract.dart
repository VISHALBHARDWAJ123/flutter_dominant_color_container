import 'package:flutter_dominant_color_container/flutter_dominant_color_container.dart';

abstract class ColorAbstract {
  Future<Color> returnDominantColorFromBitmap({
    required String imageUrl,
  });

  Future<Color> returnSvgDominantColor({
    required BuildContext context,
    required String imageUrl,
  });
}
