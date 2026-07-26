import 'package:flutter/material.dart';

// Session 3 — Animations and transitions: implicit animations
// (AnimatedContainer/AnimatedOpacity), explicit animation with
// AnimationController + FadeTransition, Hero animations, and a custom
// PageRouteBuilder transition.

class AnimationsTransitionsScreen extends StatefulWidget {
  const AnimationsTransitionsScreen({super.key});

  @override
  State<AnimationsTransitionsScreen> createState() => _AnimationsTransitionsScreenState();
}

class _AnimationsTransitionsScreenState extends State<AnimationsTransitionsScreen>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  bool _visible = true;
  late final AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _openHeroDetail(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        // Custom explicit transition: fade the destination screen in.
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        pageBuilder: (context, animation, secondaryAnimation) => const _HeroDetailScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('03 - Animations & Transitions')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Implicit animation — AnimatedContainer:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: _expanded ? 220 : 100,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _expanded ? Colors.indigo : Colors.indigo.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Tap me', style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 24),

          const Text('Implicit animation — AnimatedOpacity:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => setState(() => _visible = !_visible),
                child: const Text('Toggle visibility'),
              ),
              const SizedBox(width: 16),
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 400),
                child: const Icon(Icons.star, color: Colors.amber, size: 40),
              ),
            ],
          ),
          const SizedBox(height: 24),

          const Text('Explicit animation — AnimationController + FadeTransition:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          FadeTransition(
            opacity: _fadeController,
            child: Container(height: 60, color: Colors.teal, alignment: Alignment.center, child: const Text('Fading box')),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(onPressed: () => _fadeController.forward(), child: const Text('Fade in')),
              const SizedBox(width: 12),
              ElevatedButton(onPressed: () => _fadeController.reverse(), child: const Text('Fade out')),
            ],
          ),
          const SizedBox(height: 24),

          const Text('Hero animation across two routes:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          GestureDetector(
            key: const Key('hero-thumbnail-tap-target'),
            onTap: () => _openHeroDetail(context),
            child: const Hero(
              tag: 'star-hero',
              child: Icon(Icons.star, color: Colors.amber, size: 64),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroDetailScreen extends StatelessWidget {
  const _HeroDetailScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Detail')),
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Hero(
            tag: 'star-hero',
            child: Icon(Icons.star, color: Colors.amber, size: 200),
          ),
        ),
      ),
    );
  }
}
