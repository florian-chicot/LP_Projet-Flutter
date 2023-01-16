class Country {
  final String name;
  final String frenchName;
  final String officialName;
  final String flag;
  final String capital;
  final List<String> continent;
  final List<String> languages;
  final bool independent;
  final List<String> currencies;
  final int population;
  final String topLevelDomain;

  const Country({
    required this.name,
    required this.frenchName,
    required this.officialName,
    required this.flag,
    required this.capital,
    required this.continent,
    required this.languages,
    required this.independent,
    required this.currencies,
    required this.population,
    required this.topLevelDomain
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
        name: json['name']['common'],
        frenchName: json['translations']['fra']['common'],
        officialName: json['name']['official'],
        flag: json['flags']['svg'],
        capital: json['capital'],
        continent: json['continents'],
        languages: json['languages'],
        independent: json['independent'],
        currencies: json['currencies'],
        population: json['population'],
        topLevelDomain: json['tld']
    );
  }
}