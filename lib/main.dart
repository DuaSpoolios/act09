import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        textTheme: GoogleFonts.creepsterTextTheme(),
      ),
      home: const Storybook(),
    );
  }
}

class StoryPage {
  final String title;
  final String text;
  final String image;
  StoryPage({required this.title, required this.text, required this.image});
}

class Storybook extends StatefulWidget {
  const Storybook({super.key});

  @override
  State<Storybook> createState() => _StorybookState();
}

class _StorybookState extends State<Storybook> {
  int _currentPage = 0;

  final List<StoryPage> _pages = [
    StoryPage(
      title: "🎃 Spooktacular Night",
      text:
          "By Dua Spall — CSC 4370 Web Programming\n\nWelcome to our Halloween storybook! Tap next to begin your spooky adventure...",
      image: 'assets/night.png',
    ),
    StoryPage(
      title: "🌕 The Stormy Night",
      text:
          "It was a dark and stormy Halloween night. The moon glowed behind the clouds as the wind howled through the empty streets.",
      image: 'assets/storm.png',
    ),
    StoryPage(
      title: "🏚️ The Haunted Mansion",
      text:
          "Three friends found an old mansion at the edge of town. Its windows flickered, and the doors creaked open as if inviting them inside...",
      image: 'assets/mansion.png',
    ),
    StoryPage(
      title: "🕯️ The Glowing Pumpkin",
      text:
          "Inside the dusty hall, they found a glowing pumpkin. It pulsed like a heartbeat, filling the room with eerie orange light...",
      image: 'assets/pumpkin.png',
    ),
    StoryPage(
      title: "👻 The Trick Revealed",
      text:
          "Suddenly, the lights burst on—it was all a prank! Laughter echoed through the halls as the friends realized their spooky night had been nothing but fun.",
      image: 'assets/friends.png',
    ),
    StoryPage(
      title: "🕸️ The End",
      text:
          "Thanks for reading our Halloween story! Remember, sometimes the scariest nights bring the brightest memories.",
      image: 'assets/end.png',
    ),
  ];

  void _nextPage() {
    setState(() {
      if (_currentPage < _pages.length - 1) _currentPage++;
    });
  }

  void _prevPage() {
    setState(() {
      if (_currentPage > 0) _currentPage--;
    });
  }

  void _restartStory() => setState(() => _currentPage = 0);

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentPage];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: Container(
          key: ValueKey(_currentPage),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(page.image),
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                Colors.black54,
                BlendMode.darken,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    page.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.creepster(
                      fontSize: 40,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        Shadow(blurRadius: 8, color: Colors.black)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            page.text,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.creepster(
                              fontSize: 24,
                              color: Colors.white,
                              height: 1.4,
                            ),
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.orangeAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _prevPage,
                          icon: const Icon(Icons.arrow_back),
                          label: const Text("Back"),
                        )
                      else
                        const SizedBox(width: 120),
                      if (_currentPage < _pages.length - 1)
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade700,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _nextPage,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text("Next"),
                        )
                      else
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _restartStory,
                          icon: const Icon(Icons.restart_alt),
                          label: const Text("Restart"),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
