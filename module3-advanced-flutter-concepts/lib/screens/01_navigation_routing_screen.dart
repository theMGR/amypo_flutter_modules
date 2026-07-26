import 'package:flutter/material.dart';

// Session 1 — Navigation and routing: Navigator, Route, named routes,
// passing arguments to a route, returning a result on pop.

class NavigationRoutingScreen extends StatelessWidget {
  const NavigationRoutingScreen({super.key});

  static const routeName = '/navigation-routing';

  Future<void> _pushAnonymousRoute(BuildContext context) async {
    // Anonymous (unnamed) route via MaterialPageRoute — simplest form.
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const _SimpleDestinationScreen()),
    );
  }

  Future<void> _pushNamedRouteWithArgs(BuildContext context) async {
    // Named route registered in MaterialApp.routes / onGenerateRoute (see
    // main.dart), with typed arguments passed in and a result returned.
    final result = await Navigator.pushNamed<String>(
      context,
      ProfileScreen.routeName,
      arguments: const ProfileArgs(userName: 'Asha', userId: 42),
    );
    if (result != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Returned: $result')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('01 - Navigation & Routing')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Navigator maintains a stack of Routes. push() adds a screen, '
              'pop() removes it. Named routes let you navigate by a String '
              'identifier and pass typed arguments.',
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _pushAnonymousRoute(context),
              child: const Text('Push anonymous route (MaterialPageRoute)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _pushNamedRouteWithArgs(context),
              child: const Text('Push named route with arguments'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimpleDestinationScreen extends StatelessWidget {
  const _SimpleDestinationScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anonymous Route')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Pop back'),
        ),
      ),
    );
  }
}

class ProfileArgs {
  final String userName;
  final int userId;
  const ProfileArgs({required this.userName, required this.userId});
}

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  final ProfileArgs args;
  const ProfileScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile: ${args.userName}')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('userId = ${args.userId}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Saved changes for ${args.userName}'),
              child: const Text('Pop with a result'),
            ),
          ],
        ),
      ),
    );
  }
}
