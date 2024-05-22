import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bachroin Test', // Task Manager Title, Window Title, Screen Reader Title
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/guest': (context) => const GuestPage(),
      },
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
  String connectionStatus = 'Unknown';
  String ssid = 'Unknown';
  late ConnectivityResult connectivityResult;
  late Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isRequestingPermission = false;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      _updateConnectionStatus(result[0]);
    });
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    if (_isRequestingPermission) return;
    _isRequestingPermission = true;

    if (await Permission.location.request().isGranted) {
      List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult[0] == ConnectivityResult.wifi) {
        ssid = await WifiInfo().getWifiName() ?? 'Unknown';
        // ignore: avoid_print
        print('SSID: $ssid');
        setState(() {
          if (ssid == "AndroidWifi") {
            connectionStatus = 'Connected to expected network';
          } else {
            connectionStatus = 'Connected to wrong network';
          }
        });
      } else {
        setState(() {
          connectionStatus = 'Not Connected';
        });
      }
    } else {
      setState(() {
        connectionStatus = 'Permission denied';
      });
    }

    _isRequestingPermission = false;
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _checkConnection();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _openWiFiSettings() async {
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.iOS) {
      const wifiSettingsUrl = 'App-Prefs:root=WIFI';
      if (await canLaunchUrl(Uri.parse(wifiSettingsUrl))) {
        await launchUrl(Uri.parse(wifiSettingsUrl));
      } else {
        throw 'Could not launch $wifiSettingsUrl';
      }
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      const AndroidIntent intent = AndroidIntent(
        action: 'android.settings.WIFI_SETTINGS',
      );
      await intent.launch();
    } else {
      throw 'Platform not supported';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bachroin Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Text(
                connectionStatus == 'Connected to expected network'
                    ? 'Selamat Datang di Pabrik Kami'
                    : 'Silahkan hubungkan dengan WiFi kami terlebih dahulu',
                style: const TextStyle(fontSize: 19),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            if (connectionStatus != 'Connected to expected network')
              kIsWeb || defaultTargetPlatform == TargetPlatform.iOS
                  ? const Text('Buka Pengaturan WiFi Anda secara manual')
                  : ElevatedButton(
                      onPressed: _openWiFiSettings,
                      child: const Text('Buka Pengaturan WiFi'),
                    ),
            if (connectionStatus == 'Connected to expected network')
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text('Daftar Akun'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/guest');
                    },
                    child: const Text('Masuk tanpa Akun'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// Halaman Login
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Center(
        child: Text('Halaman Login'),
      ),
    );
  }
}

// Halaman Daftar Akun
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Akun'),
      ),
      body: const Center(
        child: Text('Halaman Daftar Akun'),
      ),
    );
  }
}

// Halaman Masuk tanpa Akun
class GuestPage extends StatelessWidget {
  const GuestPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masuk tanpa Akun'),
      ),
      body: const Center(
        child: Text('Halaman Masuk tanpa Akun'),
      ),
    );
  }
}
