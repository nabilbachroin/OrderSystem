import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:wifi_iot/wifi_iot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/guest': (context) => GuestPage(),
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
  late ConnectivityResult connectivityResult;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult[0] == ConnectivityResult.wifi) {
      setState(() {
        connectionStatus = 'Connected';
      });
    } else {
      setState(() {
        connectionStatus = 'Not Connected';
      });
    }
  }

  void _openWiFiSettings() {
      // WifiIotPlugin.showWiFiSettings();
      // WiFiForIoTPlugin.showWiFiSettings();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order System'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Text(
                connectionStatus == 'Connected'
                    ? 'Selamat Datang di Pabrik Kami'
                    : 'Silahkan hubungkan dengan WiFi kami terlebih dahulu',
                style: const TextStyle(fontSize: 19),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            connectionStatus == 'Connected'
                ? Column(
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
                  )
                : ElevatedButton(
                    onPressed: _openWiFiSettings,
                    child: const Text('Buka Pengaturan WiFi'),
                  ),
          ],
        ),
      ),
    );
  }
}

// Halaman Login
class LoginPage extends StatelessWidget {
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
