import 'package:flutter/foundation.dart';

import 'dart:ui' as ui;

import 'package:flutter_dominant_color_container/src/utils/function_abstract.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:image/image.dart' as img;
import '../../flutter_dominant_color_container.dart';

const List<String> bitmapImageExtensions = [
  'bmp', // Bitmap Image File
  'dib', // Device-Independent Bitmap
  'jpg', // JPEG Image
  'jpeg', // JPEG Image
  'png', // Portable Network Graphics
  'gif', // Graphics Interchange Format
  'tiff', // Tagged Image File Format
  'tif', // Tagged Image File Format (alternative extension)
  'webp', // WebP Image
  'ico', // Icon File
  'heic', // High Efficiency Image Coding
  'heif', // High Efficiency Image Format
];

class ColorMethods extends ColorAbstract {
  @override
  Future<Color> returnDominantColorFromBitmap({
    required String imageUrl,
  }) async {
    /// Send a GET request to the provided image URL.
    final response = await HttpClient().getUrl(Uri.parse(imageUrl));

    /// Close the response and consolidate the response body into a byte array.
    final responseBody = await response.close();
    final imageBytes = await consolidateHttpClientResponseBytes(responseBody);

    /// Extract the image type from the URL (e.g., jpg, jpeg, png, gif, etc.).
    String imageType = await returnImageType(imageUrl: imageUrl) ?? imageUrl.split('?').first.split('.').last.toLowerCase();

    /// If the image type is one of the supported bitmap formats, set the type to 'bitmap'.
    /// Otherwise, throw an error indicating that the image format is unsupported.
    if (bitmapImageExtensions.contains(imageType)) {
      imageType = 'bitmap';
    } else {
      throw UnsupportedError('Unsupported image format');
    }

    /// Convert the image bytes to a PNG file using the helper function `returnPngFile`.
    final file = await returnPngFile(imageBytes: imageBytes, imageType: imageType);

    /// Generate a color palette from the image file using the PaletteGenerator.
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      FileImage(file),
    );

    /// Execute the callback function provided as a parameter after processing is complete.

    /// Return the dominant color from the palette, or white if no dominant color is found.
    return paletteGenerator.dominantColor != null ? paletteGenerator.dominantColor!.color : Colors.white;
  }

  Future<Uint8List> convertImageToPng(Uint8List imageBytes, {int? width, int? height}) async {
    /// Decode the image bytes into an Image object using the `image` package.
    final image = img.decodeImage(imageBytes);

    /// Resize the image to the specified width and height, or use default dimensions of 200x200 pixels.
    final resizedImage = img.copyResize(image!, width: width ?? 200, height: height ?? 200);

    /// Encode the resized image as a PNG and return the resulting bytes.
    return Uint8List.fromList(img.encodePng(resizedImage));
  }

  Future<File> returnPngFile({required Uint8List imageBytes, required String imageType}) async {
    /// Convert the original image bytes to PNG format using the `convertImageToPng` function.
    final pngBytes = await convertImageToPng(imageBytes, width: 250, height: 250);

    /// Get the path to the application's documents directory to save the PNG file.
    final directory = await getApplicationDocumentsDirectory();

    /// Create a new file in the documents directory with a unique name based on the current timestamp.
    final file = File('${directory.path}/image_${DateTime.now().millisecondsSinceEpoch}.png');

    /// Write the PNG bytes to the file and return the file object.
    return await file.writeAsBytes(pngBytes);
  }

  Future<Uint8List> svgToPng(BuildContext context, String svgString, {int? svgWidth, int? svgHeight}) async {
    /// Load the SVG string as a PictureInfo object using the `svg` package.
    final pictureInfo = await vg.loadPicture(SvgStringLoader(svgString), null);

    /// Convert the PictureInfo to an Image object with specified width and height.
    final ui.Image image = await pictureInfo.picture.toImage(svgWidth ?? 200, svgHeight ?? 200);

    /// Convert the Image object to PNG format and return the resulting bytes.
    final ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return bytes!.buffer.asUint8List();
  }

  Future<String> returnSvgString({required String imageUrl}) async {
    /// Send a GET request to the provided SVG image URL and return the response body as a string.
    final response = await get(Uri.parse(imageUrl));
    return response.body;
  }

  Future<File> returnSvgToPng({required BuildContext context, required String svgString}) async {
    /// Convert the SVG string to PNG bytes using the `svgToPng` function.
    final pngBytes = await svgToPng(context, svgString);

    /// Get the path to the application's documents directory to save the PNG file.
    final directory = await getApplicationDocumentsDirectory();

    /// Create a new file in the documents directory with a unique name based on the current timestamp.
    final file = File('${directory.path}/test${DateTime.now().toString()}.png');

    /// Write the PNG bytes to the file and return the file object.
    return await file.writeAsBytes(pngBytes);
  }

  @override
  Future<Color> returnSvgDominantColor({required BuildContext context, required String imageUrl}) async {
    /// Retrieve the SVG string from the provided image URL using the `returnSvgString` function.
    final svgString = await returnSvgString(imageUrl: imageUrl);

    /// Convert the SVG string to a PNG file using the `returnSvgToPng` function.
    final file = await returnSvgToPng(context: context, svgString: svgString);

    /// Generate a color palette from the PNG file using the PaletteGenerator.
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.file(file).image,
    );

    /// Print the dominant color for debugging purposes.
    print(paletteGenerator.dominantColor!.color.toString());

    /// Return the dominant color from the palette.
    return paletteGenerator.dominantColor!.color;
  }
}

Future<String?> returnImageType({required String imageUrl}) async {
  try {
    final response = await get(Uri.parse(imageUrl));
    if (response.statusCode == 200 && response.headers['content-type']!.contains('image')) {
      final contentType = response.headers['content-type']!.split('/')[1];
      print('content type $contentType');
      return contentType;
    } else {
      throw UnsupportedError('Unsupported image format');
    }
  } catch (e) {
    print(e);
    throw UnsupportedError('Unsupported image format');
  }
}
