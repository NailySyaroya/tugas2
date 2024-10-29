import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // Lock orientation to landscape
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Display',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Fullscreen background image
          Image.asset(
            'assets/images/tema.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Settings icon in the top left corner
          Positioned(
            top: 20,
            left: 20,
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.settings, size: 30, color: Colors.black),
              onSelected: (String value) {
                // Handle menu item selection
                switch (value) {
                  case 'Profile':
                    print('Profile clicked');
                    break;
                  case 'Controls':
                    print('Controls clicked');
                    break;
                  case 'Display':
                    print('Display clicked');
                    break;
                  case 'Sound':
                    print('Sound clicked');
                    break;
                  case 'Notification':
                    print('Notification clicked');
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Profile',
                  child: Text('Profile'),
                ),
                const PopupMenuItem<String>(
                  value: 'Controls',
                  child: Text('Controls'),
                ),
                const PopupMenuItem<String>(
                  value: 'Display',
                  child: Text('Display'),
                ),
                const PopupMenuItem<String>(
                  value: 'Sound',
                  child: Text('Sound'),
                ),
                const PopupMenuItem<String>(
                  value: 'Notification',
                  child: Text('Notification'),
                ),
              ],
            ),
          ),
          // Enlarged Start Game button in the bottom left corner
          Positioned(
            bottom: 50,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                _showStartGameOptions(context); // Show dialog with options
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text('Start Game', style: TextStyle(fontSize: 24)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to show dialog with game options
  void _showStartGameOptions(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Game Options'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Hero Selection
                _buildDropdown<String>(
                  hint: 'Select Hero',
                  items: ['Hero 1', 'Hero 2', 'Hero 3'],
                  onChanged: (value) {
                    print('Selected Hero: $value');
                  },
                ),
                // Arena Selection
                _buildDropdown<String>(
                  hint: 'Select Arena',
                  items: ['Arena 1', 'Arena 2', 'Arena 3'],
                  onChanged: (value) {
                    print('Selected Arena: $value');
                  },
                ),
                // Difficulty Mode Selection
                _buildDropdown<String>(
                  hint: 'Select Difficulty',
                  items: ['Easy', 'Medium', 'Hard'],
                  onChanged: (value) {
                    print('Selected Difficulty: $value');
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Method to build DropdownButton
  DropdownButton<String> _buildDropdown<T>({
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButton<String>(
      hint: Text(hint),
      isExpanded: true,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Page'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Game has started!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
