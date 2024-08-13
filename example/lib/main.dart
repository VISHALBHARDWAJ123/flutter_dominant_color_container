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
        imageSource:
            'https://images.pexels.com/photos/10939109/pexels-photo-10939109.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
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
