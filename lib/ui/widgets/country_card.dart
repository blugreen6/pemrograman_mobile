import 'package:flutter/material.dart';

import '../../models/country_model.dart';

class CountryCard extends StatelessWidget {
  final CountryModel country;
  final VoidCallback onTap;

  const CountryCard({super.key, required this.country, required this.onTap});

  static const Color ivory = Color(0xFFF8F3EA);
  static const Color terracotta = Color(0xFFDC795F);
  static const Color charcoal = Color(0xFF292725);
  static const Color seaBlue = Color(0xFF7CA7B2);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                width: double.infinity,
                child: country.flagPng.isNotEmpty
                    ? Image.network(
                        country.flagPng,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildFlagFallback();
                        },
                      )
                    : _buildFlagFallback(),
              ),
            ),

            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: charcoal,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      country.capital,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: charcoal.withValues(alpha: 0.55),
                        fontSize: 11,
                      ),
                    ),

                    const Spacer(),

                    Row(
                      children: [
                        const Icon(Icons.public, color: seaBlue, size: 13),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            country.region,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: seaBlue,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: terracotta,
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlagFallback() {
    return Container(
      color: ivory,
      alignment: Alignment.center,
      child: Text(
        country.flag.isEmpty ? '🌍' : country.flag,
        style: const TextStyle(fontSize: 55),
      ),
    );
  }
}
