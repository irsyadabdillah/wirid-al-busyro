import 'package:flutter/material.dart';
import 'package:wirid_al_busyro/features/wirid/data/models/wirid_item.dart';

/// Faidah/source/note panel (F-05). Collapsed by default so it never
/// interrupts the main reading flow; renders nothing if there's no
/// faidah, source, or note to show.
class FaidahAccordion extends StatelessWidget {
  const FaidahAccordion({super.key, required this.item});

  final WiridItem item;

  @override
  Widget build(BuildContext context) {
    if (item.faidah == null && item.source == null && item.note == null) {
      return const SizedBox.shrink();
    }

    final bodySmall = Theme.of(context).textTheme.bodySmall;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        title: const Text('Faidah & Sumber'),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.faidah case final faidah?) Text(faidah),
                if (item.source case final source?) ...[
                  const SizedBox(height: 8),
                  Text('Sumber: $source', style: bodySmall),
                ],
                if (item.note case final note?) ...[
                  const SizedBox(height: 8),
                  Text(note, style: bodySmall),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
