import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NGO_Dashboard(),
    );
  }
}

class NGO_Dashboard extends StatefulWidget {
  const NGO_Dashboard({super.key});

  @override
  State<NGO_Dashboard> createState() => _NGO_DashboardState();
}

class _NGO_DashboardState extends State<NGO_Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}