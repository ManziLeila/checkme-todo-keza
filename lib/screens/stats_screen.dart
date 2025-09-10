
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    final total = todos.length;
    final completed = todos.where((t) => t.isCompleted).length;
    final percent = total == 0 ? 0.0 : completed / total;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Productivity')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 140, height: 140,
                      child: CircularProgressIndicator(
                        value: percent,
                        strokeWidth: 12,
                      ),
                    ),
                    Text('${(percent*100).toStringAsFixed(0)}%',
                      style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text('Completed $completed of $total tasks',
                style: GoogleFonts.poppins(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
