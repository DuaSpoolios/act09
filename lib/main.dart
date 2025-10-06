import 'package:flutter/material.dart';

void main() => runApp(const HalloweenStorybookApp());

class HalloweenStorybookApp extends StatelessWidget {
  const HalloweenStorybookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spooktacular Storybook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const Storybook(),
    );
  }
}

class StoryPage {
  final String title;
  final String text;
  final Color color;
  StoryPage({required this.title, required this.text, required this.color});
}

class Storybook extends StatefulWidget {
  const Storybook({super.key});

  @override
  State<Storybook> createState() => _StorybookState();
}

class _StorybookState extends State<Storybook> {
  int _currentPage = 0;

  // 🕯️ Story content (customize this later)
  final List<StoryPage> _pages = [
    StoryPage(
      title: "🎃 Spooktacular Night",
      text:
          "Welcome to our Halloween storybook! Tap next to begin your spooky adventure...",
      color: Colors.deepPurple.shade900,
    ),
    StoryPage(
      title: "🌕 The Stormy Night",
      text:
          "It was a dark and stormy Halloween night. The moon glowed behind the clouds as the wind howled through the empty streets.",
      color: Colors.indigo.shade900,
    ),
    StoryPage(
      title: "🏚️ The Haunted Mansion",
      text:
          "Three friends found an old mansion at the edge of town. Its windows flickered, and the doors creaked open as if inviting them inside...",
      color: Colors.blueGrey.shade900,
    ),
    StoryPage(
      title: "🕯️ The Glowing Pumpkin",
      text:
          "Inside the dusty hall, they found a glowing pumpkin. It pulsed like a heartbeat, filling the room with eerie orange light...",
      color: Colors.orange.shade900,
    ),
    StoryPage(
      title: "👻 The Trick Revealed",
      text:
          "Suddenly, the lights burst on—it was all a prank! Laughter echoed through the halls as the friends realized their spooky night had been nothing but fun.",
      color: Colors.black87,
    ),
    StoryPage(
      title: "🕸️ The End",
      text:
          "Thanks for reading our Halloween story! Remember, sometimes the scariest nights bring the brightest memories.",
      color: Colors.deepPurple.shade800,
    ),
  ];

  void _nextPage() {
    setState(() {
      if (_currentPage < _pages.length - 1) {
        _currentPage++;
      }
    });
  }

  void _prevPage() {
    setState(() {
      if (_currentPage > 0) {
        _currentPage--;
      }
    });
  }

  void _restartStory() {
    setState(() {
      _currentPage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentPage];

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        color: page.color,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  page.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        page.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage > 0)
                      ElevatedButton.icon(
                        onPressed: _prevPage,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text("Back"),
                      )
                    else
                      const SizedBox(width: 100),
                    if (_currentPage < _pages.length - 1)
                      ElevatedButton.icon(
                        onPressed: _nextPage,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text("Next"),
                      )
                    else
                      ElevatedButton.icon(
                        onPressed: _restartStory,
                        icon: const Icon(Icons.restart_alt),
                        label: const Text("Restart"),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
