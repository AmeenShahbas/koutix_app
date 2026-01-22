import 'package:flutter/material.dart';

class FooterLinkColumn extends StatelessWidget {
  final String title;
  final List<String> links;
  final List<VoidCallback>? onTaps;

  const FooterLinkColumn({
    super.key,
    required this.title,
    required this.links,
    this.onTaps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        ...links.asMap().entries.map((entry) {
          final index = entry.key;
          final link = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GestureDetector(
              onTap: onTaps != null && index < onTaps!.length
                  ? onTaps![index]
                  : null,
              child: MouseRegion(
                cursor: onTaps != null && index < onTaps!.length
                    ? SystemMouseCursors.click
                    : SystemMouseCursors.basic,
                child: Text(
                  link,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
