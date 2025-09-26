class PriceModel {
  PriceModel({
    this.ozPriceEGP,
    this.ozPriceUSd,
    this.timestamp,
    this.priceGram22k,
    this.priceGram21k,
    this.priceGram20k,
    this.priceGram18k,
    this.priceGram16k,
    this.priceGram14k,
    this.priceGram24k,
  });

  final double? priceGram24k;
  final double? priceGram22k;
  final double? priceGram21k;
  final double? priceGram20k;
  final double? priceGram18k;
  final double? priceGram16k;
  final double? priceGram14k;
  final double? ozPriceEGP;
  final String? ozPriceUSd;
  final int? timestamp;

  factory PriceModel.fromJson(Map<String, dynamic> jsonData) {
    return PriceModel(
      // timestamp: jsonData["timestamp"],
      ozPriceEGP: jsonData["ounce_in_egp"],
      ozPriceUSd: jsonData["ounce_price_usd"],
      // priceGram14k: jsonData["price_gram_14k"],
      // priceGram16k: jsonData["price_gram_16k"],
      // priceGram18k: jsonData["price_gram_18k"],
      // priceGram20k: jsonData["price_gram_20k"],
      // priceGram21k: jsonData["price_gram_21k"],
      // priceGram22k: jsonData["price_gram_22k"],
      // priceGram24k: jsonData["price_gram_24k"],
    );
  }
}
