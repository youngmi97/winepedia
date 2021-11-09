class APIbody {
  Map<String, dynamic> body;

  APIbody({required this.body});

  factory APIbody.fromJson(Map<String, dynamic> parsedJson) {
    return APIbody(
      body: parsedJson['body'],
    );
  }
}

class Items {
  List<dynamic> items;

  Items({required this.items});

  factory Items.fromJson(Map<String, dynamic> parsedJson) {
    return Items(
      items: parsedJson['Items'],
    );
  }
}

class ItemContext {
  String name;
  String phoneNumber;
  String address;
  String sAddr;
  String description;
  String instaAddr;
  List<dynamic> roseCatalogue;

  ItemContext({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.sAddr,
    required this.description,
    required this.instaAddr,
    required this.roseCatalogue,
  });

  factory ItemContext.fromJson(Map<String, dynamic> parsedJson) {
    return ItemContext(
      name: parsedJson['NAME'],
      phoneNumber: parsedJson['PHONE'],
      address: parsedJson['ADDRESS'],
      sAddr: parsedJson['SADDR'],
      description: parsedJson['DESCRIPTION'],
      instaAddr: parsedJson['INSTA_ADDR'],
      roseCatalogue: parsedJson['ROSE'],
    );
  }
}
