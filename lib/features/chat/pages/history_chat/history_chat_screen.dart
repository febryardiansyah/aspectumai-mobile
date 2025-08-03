import 'package:aspectumai/core/widgets/app_spacer.dart';
import 'package:aspectumai/core/widgets/app_text_form.dart';
import 'package:flutter/material.dart';

class HistoryChatScreen extends StatelessWidget {
  const HistoryChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Chat",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const AppSpacer.height(16),
              const AppTextForm(
                hint: 'Search chat',
              ),
              const AppSpacer.height(16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(100, (index) => const Text('A')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
