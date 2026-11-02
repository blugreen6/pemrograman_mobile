import 'package:flutter/material.dart';

import '../../models/country_model.dart';
import '../../services/country_service.dart';
import 'country_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color ivory = Color(0xFFF8F3EA);
  static const Color terracotta = Color(0xFFDC795F);
  static const Color charcoal = Color(0xFF292725);
  static const Color seaBlue = Color(0xFF7CA7B2);

  final CountryService _countryService = CountryService();
  final TextEditingController _searchController = TextEditingController();

  List<CountryModel> _countries = [];
  bool _isLoading = true;
  String? _errorMessage;
  String _selectedRegion = 'All';

  final List<String> _regions = [
    'All',
    'Africa',
    'Americas',
    'Asia',
    'Europe',
    'Oceania',
  ];

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCountries() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final countries = await _countryService.fetchCountries();

      if (!mounted) return;

      setState(() {
        _countries = countries;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  List<CountryModel> get _filteredCountries {
    final query = _searchController.text.trim().toLowerCase();

    return _countries.where((country) {
      final matchesSearch =
          country.name.toLowerCase().contains(query) ||
          country.capital.toLowerCase().contains(query);

      final matchesRegion =
          _selectedRegion == 'All' ||
          country.region.toLowerCase() == _selectedRegion.toLowerCase();

      return matchesSearch && matchesRegion;
    }).toList();
  }

  void _openCountryDetail(CountryModel country) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountryDetailScreen(country: country),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredCountries = _filteredCountries;

    return Scaffold(
      backgroundColor: ivory,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: terracotta))
            : _errorMessage != null
            ? _buildErrorState()
            : RefreshIndicator(
                color: terracotta,
                onRefresh: _loadCountries,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 20, 22, 10),
                        child: _buildHeader(),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: _buildIntroduction(),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
                        child: _buildSearchBar(),
                      ),
                    ),

                    SliverToBoxAdapter(child: _buildRegionFilters()),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 25, 22, 15),
                        child: _buildSectionTitle(),
                      ),
                    ),

                    if (filteredCountries.isNotEmpty)
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final country = filteredCountries[index];

                            return _buildCountryCard(country);
                          }, childCount: filteredCountries.length),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,
                                childAspectRatio: 0.88,
                              ),
                        ),
                      )
                    else
                      SliverToBoxAdapter(child: _buildEmptyState()),

                    const SliverToBoxAdapter(child: SizedBox(height: 30)),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: terracotta,
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(Icons.public, color: Colors.white, size: 25),
        ),
        const SizedBox(width: 11),
        const Text(
          'WORLDLY',
          style: TextStyle(
            color: charcoal,
            fontSize: 19,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Icon(Icons.explore_outlined, color: terracotta, size: 17),
              SizedBox(width: 5),
              Text(
                'Explore',
                style: TextStyle(
                  color: charcoal,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        const Text(
          'THE WORLD IS',
          style: TextStyle(
            color: terracotta,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Yours to\nDiscover.',
          style: TextStyle(
            color: charcoal,
            fontSize: 43,
            height: 1.08,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Explore countries, discover cultures, '
          'and learn something new about our world.',
          style: TextStyle(
            color: charcoal.withValues(alpha: 0.65),
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: 'Search country or capital...',
          hintStyle: TextStyle(
            color: charcoal.withValues(alpha: 0.4),
            fontSize: 13,
          ),
          prefixIcon: const Icon(Icons.search, color: terracotta),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.close),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 17),
        ),
      ),
    );
  }

  Widget _buildRegionFilters() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        scrollDirection: Axis.horizontal,
        itemCount: _regions.length,
        separatorBuilder: (context, index) => const SizedBox(width: 9),
        itemBuilder: (context, index) {
          final region = _regions[index];
          final isSelected = _selectedRegion == region;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedRegion = region;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? charcoal : Colors.white,
                borderRadius: BorderRadius.circular(25),
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

  Widget _buildSectionTitle() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Explore Countries',
            style: TextStyle(
              color: charcoal,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          '${_filteredCountries.length} countries',
          style: const TextStyle(
            color: terracotta,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCountryCard(CountryModel country) {
    return GestureDetector(
      onTap: () => _openCountryDetail(country),
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
                          return _buildFlagFallback(country.flag);
                        },
                      )
                    : _buildFlagFallback(country.flag),
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

  Widget _buildFlagFallback(String flag) {
    return Container(
      color: const Color(0xFFEDE7DC),
      alignment: Alignment.center,
      child: Text(
        flag.isEmpty ? '🌍' : flag,
        style: const TextStyle(fontSize: 55),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Column(
        children: [
          const Icon(Icons.search_off, color: seaBlue, size: 50),
          const SizedBox(height: 12),
          const Text(
            'No countries found',
            style: TextStyle(
              color: charcoal,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try another country name or region.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: charcoal.withValues(alpha: 0.6),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded, color: terracotta, size: 55),
            const SizedBox(height: 15),
            const Text(
              'Oops! Something went wrong.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: charcoal,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _errorMessage ?? 'Unable to load countries.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: charcoal.withValues(alpha: 0.6),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _loadCountries,
              style: ElevatedButton.styleFrom(
                backgroundColor: terracotta,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
