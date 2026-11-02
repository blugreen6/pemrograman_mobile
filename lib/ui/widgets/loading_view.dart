import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  static const Color ivory = Color(0xFFF8F3EA);
  static const Color terracotta = Color(0xFFDC795F);
  static const Color charcoal = Color(0xFF292725);
  static const Color seaBlue = Color(0xFF7CA7B2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ivory,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: terracotta,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(Icons.public, color: Colors.white, size: 48),
              ),

              const SizedBox(height: 25),

              const Text(
                'WORLDLY',
                style: TextStyle(
                  color: charcoal,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Preparing your journey...',
                style: TextStyle(color: seaBlue, fontSize: 14),
              ),

              const SizedBox(height: 30),

              const SizedBox(
                width: 35,
                height: 35,
                child: CircularProgressIndicator(
                  color: terracotta,
                  strokeWidth: 3,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Discovering the world, one country at a time.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: charcoal.withValues(alpha: 0.55),
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
