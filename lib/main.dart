import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main()=> runApp(const HalloweenStorybookApp());
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
  StoryPage({
    required this.title,
    required this.text,
    required this.image,
  });
}

class Storybook extends StatefulWidget {
  const Storybook({super.key});
  @override
  State<Storybook> createState()=> _StorybookState();
}

class _StorybookState extends State<Storybook>
    with SingleTickerProviderStateMixin {
  int _currentPage = 0;
  double _textOpacity= 0;
  final _random= Random();

  late final AnimationController _emojiController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat(reverse: true);

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
          "A shadow darted by the window... or was it a trick of the light? 🕷️",
      image: 'assets/mansion.png',
    ),
    StoryPage(
      title: "🕯️ The Glowing Pumpkin",
      text:
          "Inside the dusty hall, they found a glowing pumpkin. It pulsed like a heartbeat, filling the room with eerie orange light 👻",
      image: 'assets/pumpkin.png',
    ),
    StoryPage(
      title: "👻 The Trick Revealed",
      text:
          "Suddenly, the lights burst on—it was all a prank! Laughter echoed through the halls 🎃",
      image: 'assets/friends.png',
    ),
    StoryPage(
      title: "🕸️ The End",
      text:
          "Thanks for reading our Halloween story! Remember, sometimes the scariest nights bring the brightest memories. 🌙",
      image: 'assets/end.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeInText();
  }

  void _fadeInText() async {
    setState(()=> _textOpacity = 0);
    await Future.delayed(const Duration(milliseconds: 200));
    setState(()=> _textOpacity = 1);
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      setState(() {
        _currentPage++;
        _fadeInText();
      });
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _fadeInText();
      });
    }
  }

  void _restartStory() {
    setState(() {
      _currentPage= 0;
      _fadeInText();
    });
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentPage];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        child: Container(
          key: ValueKey(_currentPage),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(page.image),
              fit: BoxFit.cover,
              colorFilter:
                  const ColorFilter.mode(Colors.black54, BlendMode.darken),
            ),
          ),
          child: Stack(
            children: [
              if (_currentPage == 0 || _currentPage == 3)
                AnimatedBuilder(
                  animation: _emojiController,
                  builder: (_, __) {
                    double dx = _emojiController.value * 300;
                    double dy =
                        100 + sin(_emojiController.value * pi * 2) * 50;
                    return Positioned(
                      left: dx,
                      top: dy,
                      child: const Text(
                        "👻",
                        style: TextStyle(fontSize: 40),
                      ),
                    );
                  },
                ),
              if (_currentPage==2)
                AnimatedBuilder(
                  animation: _emojiController,
                  builder: (_, __) {
                    double dx = 300 - _emojiController.value * 300;
                    double dy =
                        200 + cos(_emojiController.value * pi * 2) * 40;
                    return Positioned(
                      left: dx,
                      top: dy,
                      child: const Text(
                        "🕷️",
                        style: TextStyle(fontSize: 28),
                      ),
                    );
                  },
                ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) => const LinearGradient(
                          colors: [Colors.orange, Colors.redAccent],
                        ).createShader(rect),
                        child: Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.creepster(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: const [
                              Shadow(blurRadius: 8, color: Colors.black)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: AnimatedOpacity(
                            opacity: _textOpacity,
                            duration: const Duration(milliseconds: 900),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
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
                      ),
                      NavigationButtons(
                        isFirst: _currentPage== 0,
                        isLast: _currentPage== _pages.length - 1,
                        onNext: _nextPage,
                        onBack: _prevPage,
                        onRestart: _restartStory,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emojiController.dispose();
    super.dispose();
  }
}

class NavigationButtons extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onRestart;

  const NavigationButtons({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.onNext,
    required this.onBack,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!isFirst)
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
            label: const Text("Back"),
          )
        else
          const SizedBox(width: 120),
        if (!isLast)
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade700,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: onNext,
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Next"),
          )
        else
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: onRestart,
            icon: const Icon(Icons.restart_alt),
            label: const Text("Restart"),
          ),
      ],
    );
  }
}
