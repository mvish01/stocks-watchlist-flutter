class Stock {
  final String id;
  final String name;
  final String exchange;
  final double price;
  final double change;
  final double percent;

  Stock({
    required this.id,
    required this.name,
    required this.exchange,
    required this.price,
    required this.change,
    required this.percent,
  });
}