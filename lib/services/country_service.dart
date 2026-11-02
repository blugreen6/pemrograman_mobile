import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/country_model.dart';

class CountryService {
  static const String _baseUrl = 'https://countries.dev/countries';

  Future<List<CountryModel>> fetchCountries() async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'fields': 'name,alpha2Code,alpha3Code,capital,region,subregion,area,population,flag,flags,currencies,languages',
        'sort': 'name',
        'order': 'asc',
        'limit': '30',
      },
    );

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final dynamic decodedData = jsonDecode(response.body);

        if (decodedData is! List) {
          throw const FormatException('Invalid data format from API.');
        }

        return decodedData.map((item) {
          if (item is! Map<String, dynamic>) {
            throw const FormatException('Invalid country data.');
          }

          return CountryModel.fromJson(item);
        }).toList();
      } else {
        throw Exception(
          'Failed to load countries. '
          'Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Unable to fetch countries: $e');
    }
  }
}
