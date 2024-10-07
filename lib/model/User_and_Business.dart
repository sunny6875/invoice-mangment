class User {
  final String id;
  final String name;
  final List<Business> businesses;

  User({
    required this.id,
    required this.name,
    required this.businesses,
  });
}

class Business {
  final String id;
  final String name;

  Business({
    required this.id,
    required this.name,
  });
}
