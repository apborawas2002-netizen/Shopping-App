String formatMoney(double amount) {
  final whole = amount == amount.roundToDouble();
  final digits = whole ? amount.toStringAsFixed(0) : amount.toStringAsFixed(2);
  return '₹$digits';
}
