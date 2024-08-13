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
      debugShowCheckedModeBanner: false,
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
  final String _imageUrl = 'https://images.unsplash.com/photo-1713323228776-f9b26da0e528?q=80&w=2487&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FlutterDominantColorContainer(
        /*     imageSource: 'https://images.unsplash.com/photo-1598729512070-b2ee1524ce13?q=80&w=2333&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        imageType: ImageType.others,*/
        loadingBuilder: const Text('Loading.....'),
        errorWidget: const Text('Error......'),
        /*
        colorOpacity: 1,*/
        containerController: ContainerController()
          ..setImageUrl = _imageUrl
          ..imageType = ImageType.others
          ..setColorOpacity = 1,
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                _imageUrl,
                width: MediaQuery.of(context).size.width * .5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
