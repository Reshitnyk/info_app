import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Device Information',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map? _info;

  void _getInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    final result = await deviceInfoPlugin.deviceInfo;
    setState(() {
      _info = result.toMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device information')),
      body: _info != null
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: _info!.entries
                    .map((e) => Wrap(
                          children: [
                            Text(
                              "${e.key} :",
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.red),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              e.value.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        ))
                    .toList(),
              ),
            )
          : const Center(
              child: Text('Press the button'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getInfo,
        child: const Icon(Icons.info),
      ),
    );
  }
}
