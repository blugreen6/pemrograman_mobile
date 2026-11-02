import 'package:flutter/material.dart';

import '../../models/country_model.dart';

class CountryDetailScreen extends StatelessWidget {
  final CountryModel country;

  const CountryDetailScreen({super.key, required this.country});

  static const Color ivory = Color(0xFFF8F3EA);
  static const Color terracotta = Color(0xFFDC795F);
  static const Color charcoal = Color(0xFF292725);
  static const Color seaBlue = Color(0xFF7CA7B2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ivory,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ivory,
            foregroundColor: charcoal,
            elevation: 0,
            pinned: true,
            title: const Text(
              'Country Details',
              style: TextStyle(fontWeight: FontWeight.bold, color: charcoal),
            ),
            centerTitle: true,
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Country flag
                  Container(
                    width: double.infinity,
                    height: 210,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: charcoal.withValues(alpha: 0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: country.flagPng.isNotEmpty
                        ? Image.network(
                            country.flagPng,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Text(
                                  country.flag,
                                  style: const TextStyle(fontSize: 90),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              country.flag,
                              style: const TextStyle(fontSize: 90),
                            ),
                          ),
                  ),

                  const SizedBox(height: 25),

                  // Country name
                  Text(
                    country.name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: charcoal,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '${country.alpha2Code} • ${country.alpha3Code}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: seaBlue,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Country Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: charcoal,
                    ),
                  ),

                  const SizedBox(height: 15),

                  _buildInfoCard(
                    icon: Icons.location_city,
                    label: 'Capital City',
                    value: country.capital,
                  ),

                  _buildInfoCard(
                    icon: Icons.public,
                    label: 'Region',
                    value: country.region,
                  ),

                  _buildInfoCard(
                    icon: Icons.map_outlined,
                    label: 'Subregion',
                    value: country.subregion,
                  ),

                  _buildInfoCard(
                    icon: Icons.people_outline,
                    label: 'Population',
                    value: _formatNumber(country.population),
                  ),

                  _buildInfoCard(
                    icon: Icons.landscape_outlined,
                    label: 'Area',
                    value: '${_formatNumber(country.area.round())} km²',
                  ),

                  _buildInfoCard(
                    icon: Icons.payments_outlined,
                    label: 'Currencies',
                    value: country.currencies.isEmpty
                        ? 'Not available'
                        : country.currencies.join(', '),
                  ),

                  _buildInfoCard(
                    icon: Icons.translate,
                    label: 'Languages',
                    value: country.languages.isEmpty
                        ? 'Not available'
                        : country.languages.join(', '),
                  ),

                  const SizedBox(height: 20),

                  // Country code section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: charcoal,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'IDENTIFICATION',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Alpha-2: ${country.alpha2Code}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Alpha-3: ${country.alpha3Code}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: Text(
                      'EXPLORE THE WORLD WITH WORLDLY',
                      style: TextStyle(
                        color: terracotta,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: ivory,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: terracotta, size: 22),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: charcoal,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(num number) {
    return number.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }
}
