// Our movie model
class WineBar {
  final int id;
  final String description, name, poster;
  final List<Map> wines;

  WineBar({
    required this.poster,
    required this.name,
    required this.id,
    required this.description,
    required this.wines,
  });
}

// our demo data movie data
List<WineBar> wineBars = [
  WineBar(
    id: 1,
    name: "Bloodshot",
    poster: "assets/images/bar_template.jpg",
    description: plotText,
    wines: [
      {"name": "Red Wine", "brand": "Jae's Wine", "country": "Italy"}
    ],
  ),
  WineBar(
    id: 2,
    name: "Bloodshot",
    poster: "assets/images/bar_template.jpg",
    description: plotText,
    wines: [],
  ),
  WineBar(
    id: 3,
    name: "Bloodshot",
    poster: "assets/images/bar_template.jpg",
    description: plotText,
    wines: [],
  ),
];

String plotText = "서초구에 위치한 혼술하기 좋은 와인바";
