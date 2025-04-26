class Transaction {
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final bool isIncome;
  final String category;

  const Transaction({
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.isIncome,
    required this.category,
  });
} 