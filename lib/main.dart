import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snipe/provider.dart';

void main() {
  runApp(
    // the error in console said that i should move the provider to the top of MyApp so maoving that there worked
    ChangeNotifierProvider(
      create: (context) => ThemeChange(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChange>(
      builder: (context, themeChange, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeChange.getmode,
          home: const Button3D(),
        );
      },
    );
  }
}

class Button3D extends StatefulWidget {
  const Button3D({super.key});

  @override
  State<Button3D> createState() => _Button3DState();
}

class _Button3DState extends State<Button3D>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(5 - (_animation.value * 3),
                          5 - (_animation.value * 3)),
                      blurRadius: 10 - (_animation.value * 5),
                    ),
                  ],
                  border: Border(
                    right: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                      width: 3 - (_animation.value * 1.5),
                    ),
                    bottom: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.5),
                      width: 3 - (_animation.value * 1.5),
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    "3D Button",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Provider.of<ThemeChange>(context, listen: false).toggle(),
        tooltip: 'Toggle Theme',
        child: const Icon(Icons.brightness_6),
      ),
    );
  }
}
