import 'package:flutter/material.dart';
import 'package:flutter_chess_board/screens/chessboard_screen.dart';
import 'package:flutter_chess_board/screens/manual_position_screen.dart';
import 'package:flutter_chess_board/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'widgets/chessboardStat.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ChessboardState(),
      child: const ChessApp(),
    ),
  );
}

class ChessApp extends StatelessWidget {
  const ChessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chess App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/chessboard': (context) => const ChessboardScreen(),
        '/splash': (context) => SplashScreen(),
        '/manual_position': (context) => const ManualPosition(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: CustomAppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.play_arrow),
              title: const Text('New Game'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/chessboard');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.play_arrow),
              title: const Text('Mettre une Position'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/manual_position');
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Your main content goes here'),
      ),
    );
  }
}
