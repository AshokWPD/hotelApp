import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'home/homepage.dart';

class NetworkCheckScreen extends StatefulWidget {
  const NetworkCheckScreen({super.key});

  @override
  _NetworkCheckScreenState createState() => _NetworkCheckScreenState();
}

class _NetworkCheckScreenState extends State<NetworkCheckScreen> {
  late ConnectivityResult _connectivityResult;
  Color customColor = const Color.fromRGBO(33, 84, 115, 1.0);

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _connectivityResult = result;
        if (_connectivityResult != ConnectivityResult.none) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      });
    });
  }

  Future<void> _checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    String connectivityStatus = '';

    switch (_connectivityResult) {
      case ConnectivityResult.mobile:
        connectivityStatus = 'Mobile Data';
        break;
      case ConnectivityResult.wifi:
        connectivityStatus = 'Wi-Fi';
        break;
      case ConnectivityResult.none:
        connectivityStatus = 'No Internet Connection';
        break;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'images/logo_1.png',
              fit: BoxFit.cover,
            ),
            Column(
              children: <Widget>[
                Icon(
                  _connectivityResult == ConnectivityResult.none
                      ? Icons.signal_wifi_off
                      : Icons.signal_wifi_4_bar,
                  size: 100.0,color: Colors.cyan.shade700,
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Connection Status: $connectivityStatus',
                  style: const TextStyle(fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
