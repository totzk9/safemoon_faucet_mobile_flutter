class Transaction {
  const Transaction({required this.wallet, required this.date, required this.amount});
  final String wallet;
  final String date;
  final int amount;

  @override
  String toString() {
    return 'Safemoon{wallet: $wallet, date: $date, amount: $amount}';
  }
}