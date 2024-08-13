import 'package:flutter_dominant_color_container/flutter_dominant_color_container.dart';
import 'package:flutter_dominant_color_container/src/utils/functions.dart';

class FlutterDominantColorContainer extends StatefulWidget {
  final String imageSource;
  final ImageType imageType;
  final Size? size;
  final BoxDecoration? decoration;
  final Widget? errorWidget, loadingBuilder;
  final Widget child;
  final double colorOpacity;

  const FlutterDominantColorContainer({
    super.key,
    required this.imageSource,
    required this.imageType,
    this.size,
    this.decoration,
    this.errorWidget,
    this.loadingBuilder,
    required this.child,
    required this.colorOpacity,
  })  : assert((imageType != ImageType.svg || imageType != ImageType.others),
            'Image Type is required choose either ImageType.others or ImageType.svg'),
        assert((colorOpacity > 0 || colorOpacity < 1),
            'ColorOpacity should be between 0.0 - 1.0');

  @override
  State<FlutterDominantColorContainer> createState() =>
      _FlutterDominantColorContainerState();
}

class _FlutterDominantColorContainerState
    extends State<FlutterDominantColorContainer> {
  late Future<Color> _future;
  final colorMethod = ColorMethods();

  @override
  void initState() {
    // TODO: implement initState
    _future = widget.imageType == ImageType.svg
        ? colorMethod.returnSvgDominantColor(
            context: context,
            imageUrl: widget.imageSource,
          )
        : colorMethod.returnDominantColorFromBitmap(
            imageUrl: widget.imageSource,
          );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Color>(
      builder: (context, snapshot) {
        return SizedBox(
          width: (widget.size ??
                  const Size(
                    double.infinity,
                    double.infinity,
                  ))
              .width,
          height: (widget.size ??
                  const Size(
                    double.infinity,
                    double.infinity,
                  ))
              .height,
          child: snapshot.connectionState == ConnectionState.done
              ? Stack(
                  children: [
                    if (snapshot.hasData)
                      Container(
                        width: (widget.size ??
                                const Size(
                                  double.infinity,
                                  double.infinity,
                                ))
                            .width,
                        height: (widget.size ??
                                const Size(
                                  double.infinity,
                                  double.infinity,
                                ))
                            .height,
                        color: snapshot.data!.withOpacity(
                          widget.colorOpacity,
                        ),
                      ),
                    if (snapshot.hasError)
                      Center(
                        child: Text(
                          snapshot.error.toString(),
                        ),
                      ),
                    widget.child,
                  ],
                )
              : Center(
                  child: widget.loadingBuilder ??
                      const CircularProgressIndicator(),
                ),
        );
      },
      future: _future,
    );
  }
}
