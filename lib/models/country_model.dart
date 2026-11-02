class CountryModel {
  final String name;
  final String alpha2Code;
  final String alpha3Code;
  final String capital;
  final String region;
  final String subregion;
  final double area;
  final int population;
  final String flag;
  final String flagPng;
  final List<String> currencies;
  final List<String> languages;

  const CountryModel({
    required this.name,
    required this.alpha2Code,
    required this.alpha3Code,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.area,
    required this.population,
    required this.flag,
    required this.flagPng,
    required this.currencies,
    required this.languages,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    final currenciesData = json['currencies'];
    final languagesData = json['languages'];
    final flagsData = json['flags'];

    return CountryModel(
      name: json['name']?.toString() ?? 'Unknown Country',
      alpha2Code: json['alpha2Code']?.toString() ?? '',
      alpha3Code: json['alpha3Code']?.toString() ?? '',
      capital: json['capital']?.toString() ?? 'No capital',
      region: json['region']?.toString() ?? 'Unknown',
      subregion: json['subregion']?.toString() ?? 'Unknown',
      area: (json['area'] as num?)?.toDouble() ?? 0.0,
      population: (json['population'] as num?)?.toInt() ?? 0,
      flag: json['flag']?.toString() ?? '',
      flagPng: flagsData is Map ? flagsData['png']?.toString() ?? '' : '',
      currencies: _parseList(currenciesData, 'name'),
      languages: _parseList(languagesData, 'name'),
    );
  }

  static List<String> _parseList(dynamic data, String key) {
    if (data is! List) {
      return const [];
    }

    return List.unmodifiable(
      data
          .map((item) {
            if (item is Map) {
              return item[key]?.toString() ?? '';
            }
            return '';
          })
          .where((value) => value.isNotEmpty),
    );
  }
}
