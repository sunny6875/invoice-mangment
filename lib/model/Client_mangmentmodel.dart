class Client {
  final String id;
  final String name;
  final String email;
  final String phone;
  final List<Transaction> transactions;

  Client({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.transactions,
  });
}

class Transaction {
  final String id;
  final DateTime date;
  final double amount;
  final String description;

  Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.description,
  });
}
