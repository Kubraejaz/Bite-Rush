import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/auth_provider.dart';
import 'routes.dart';
import 'theme.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'Bite Rush',
            theme: AppTheme.theme, // fixed: use 'theme' instead of 'lightTheme'
            debugShowCheckedModeBanner: false,
            home: LoginWrapper(auth: auth),
            routes: AppRoutes.routes,
          );
        },
      ),
    ); // <-- Added missing semicolon here
  }
}

// Separate widget to safely handle auto-login
class LoginWrapper extends StatefulWidget {
  final AuthProvider auth;
  const LoginWrapper({required this.auth});

  @override
  _LoginWrapperState createState() => _LoginWrapperState();
}

class _LoginWrapperState extends State<LoginWrapper> {
  @override
  void initState() {
    super.initState();
    // Delay navigation until first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.auth.tryAutoLogin().then((loggedIn) {
        if (loggedIn) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      }).catchError((_) {
        // Stay on login screen if auto-login fails
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
