import 'package:flutter/material.dart';

class RegionFilter extends StatelessWidget {
  final String selectedRegion;
  final ValueChanged<String> onRegionSelected;

  const RegionFilter({
    super.key,
    required this.selectedRegion,
    required this.onRegionSelected,
  });

  static const Color ivory = Color(0xFFF8F3EA);
  static const Color terracotta = Color(0xFFDC795F);
  static const Color charcoal = Color(0xFF292725);

  static const List<String> regions = [
    'All',
    'Africa',
    'Americas',
    'Asia',
    'Europe',
    'Oceania',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        scrollDirection: Axis.horizontal,
        itemCount: regions.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 9);
        },
        itemBuilder: (context, index) {
          final region = regions[index];
          final isSelected = selectedRegion == region;

          return GestureDetector(
            onTap: () => onRegionSelected(region),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? charcoal : Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: isSelected ? charcoal : ivory),
              ),
              child: Text(
                region,
                style: TextStyle(
                  color: isSelected ? Colors.white : charcoal,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
