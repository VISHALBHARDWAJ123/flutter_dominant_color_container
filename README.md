
# flutter_dominant_color_container
####  The Dominant Color Container is a custom Flutter widget designed to dynamically extract the dominant color from an image and apply it as the background color of a container. This widget enhances UI design by automatically adapting to the primary color scheme of images, making it ideal for creating visually cohesive layouts.
.

## Features

-> Automatic Color Extraction: Extracts the dominant color from any image.
-> Dynamic Background Adaptation: Applies the extracted color as the background of a container.
-> Customizable: Easily integrate and customize the widget to fit your app’s design.

## Getting started

Add the following dependency to your pubspec.yaml file:
```yaml
dependencies:
flutter_dominant_color_container: ^1.0.0
```

## Usage

Here’s a basic example of how to use flutter_dominant_color_container

```dart

import 'package:flutter_dominant_color_container/flutter_dominant_color_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Dominant Color Container'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: FlutterDominantColorContainer(
        imageSource: 'https://images.pexels.com/photos/10939109/pexels-photo-10939109.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        imageType: ImageType.others,
        loadingBuilder: const Text('Loading.....'),
        errorWidget: const Text('Error......'),
        colorOpacity: 1,
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                'https://images.pexels.com/photos/10939109/pexels-photo-10939109.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                width: MediaQuery.of(context).size.width * .5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

```
#### Important Parameter
`imageSource` :  Image url
`imageType` : What is the extension of the image `ImageType.svg` for network svg images and `ImageType.others` for other type of image extension. 


# Acknowledgments

This package was originally created by [Vishal Bhardwaj](https://github.com/VISHALBHARDWAJ123) and is now also maintained by [Vishal Bhardwaj](https://github.com/VISHALBHARDWAJ123).

# Bugs or Requests

If you encounter any problems feel free to open an [issue](https://github.com/VISHALBHARDWAJ123/flutter_dominant_color_container/issues/new?template=bug_report.md). If you feel the library is missing a feature, please raise a [ticket](https://github.com/VISHALBHARDWAJ123/flutter_dominant_color_container/issues/new?template=feature_request.md). Pull request are also welcome.
