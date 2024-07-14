import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_service.dart';
import 'connectivity_service.dart';
import 'battery_service.dart';
import 'auth_service.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';
import 'calculator_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  ConnectivityService();  // Initialize the connectivity service
  BatteryService();  // Initialize the battery service
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeService()),
        Provider(create: (context) => AuthService()),  // Add AuthService provider
      ],
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeService.themeData,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculator App'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.login), text: 'Sign In'),
              Tab(icon: Icon(Icons.app_registration), text: 'Sign Up'),
              Tab(icon: Icon(Icons.calculate), text: 'Calculator'),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Menu'),
              ),
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Sign In'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.app_registration),
                title: const Text('Sign Up'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.calculate),
                title: const Text('Calculator'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CalculatorScreen()),
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SignInScreen(),
            SignUpScreen(),
            const CalculatorScreen(),
          ],
        ),
      ),
    );
  }
}
