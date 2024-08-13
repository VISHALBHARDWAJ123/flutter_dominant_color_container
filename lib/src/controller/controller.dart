import 'package:flutter_dominant_color_container/flutter_dominant_color_container.dart';

class ContainerController extends ChangeNotifier {
  String _imageUrl = '';
  double _colorOpacity = 1.0;
  BoxDecoration _boxDecoration = const BoxDecoration();
  Size _size = const Size(double.infinity, double.infinity);
  ImageType _imageType = ImageType.others;

  ImageType get imgType => _imageType;

  set imageType(ImageType value) {
    _imageType = value;
    notifyListeners();
  }

  String get imgUrl => _imageUrl;

  set setImageUrl(String value) {
    _imageUrl = value;
    notifyListeners();
  }

  double get colorOpacity => _colorOpacity;

  set setColorOpacity(double value) {
    _colorOpacity = value;
    notifyListeners();
  }

  BoxDecoration get boxDecoration => _boxDecoration;

  set setBoxDecoration(BoxDecoration value) {
    _boxDecoration = value;
    notifyListeners();
  }

  Size get size => _size;

  set setSize(Size value) {
    _size = value;
    notifyListeners();
  }
}
