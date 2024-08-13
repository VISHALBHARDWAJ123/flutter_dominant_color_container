import 'package:flutter_dominant_color_container/flutter_dominant_color_container.dart';

import 'package:flutter_dominant_color_container/src/utils/functions.dart';

class FlutterDominantColorContainer extends StatefulWidget {
  final Widget? errorWidget, loadingBuilder;
  final Widget child;
  final ContainerController containerController;

  const FlutterDominantColorContainer({
    super.key,
    this.errorWidget,
    this.loadingBuilder,
    required this.child,
    required this.containerController,
  });

  @override
  State<FlutterDominantColorContainer> createState() => _FlutterDominantColorContainerState();
}

class _FlutterDominantColorContainerState extends State<FlutterDominantColorContainer> {
  final colorMethod = ColorMethods();
  late final ValueNotifier<ContainerController> containerController;

  @override
  void initState() {
    containerController = ValueNotifier(widget.containerController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ContainerController>(
        valueListenable: containerController,
        builder: (context, value, child) {
          return FutureBuilder<Color>(
            builder: (context, snapshot) {
              return SizedBox(
                width: (containerController.value.size ??
                        const Size(
                          double.infinity,
                          double.infinity,
                        ))
                    .width,
                height: (containerController.value.size ??
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
                              width: (containerController.value.size ??
                                      const Size(
                                        double.infinity,
                                        double.infinity,
                                      ))
                                  .width,
                              height: (containerController.value.size ??
                                      const Size(
                                        double.infinity,
                                        double.infinity,
                                      ))
                                  .height,
                              color: snapshot.data!.withOpacity(
                                containerController.value.colorOpacity,
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
                        child: widget.loadingBuilder ?? const CircularProgressIndicator(),
                      ),
              );
            },
            future: containerController.value.imgType == ImageType.svg
                ? colorMethod.returnSvgDominantColor(
                    context: context,
                    imageUrl: containerController.value.imgUrl,
                  )
                : colorMethod.returnDominantColorFromBitmap(
                    imageUrl: containerController.value.imgUrl,
                  ),
          );
        });
  }
}
