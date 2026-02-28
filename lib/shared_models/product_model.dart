class Product {
  String? id;
  String name;
  String? sku;
  double price;
  int stock;
  String? category;
  String? sapMaterialId;
  SapMetadata? sapMetadata;
  String? orgId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
    required this.name,
    this.sku,
    this.price = 0,
    this.stock = 0,
    this.category,
    this.sapMaterialId,
    this.sapMetadata,
    this.orgId,
    this.createdAt,
    this.updatedAt,
  });

  // Convert JSON to Dart Object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'] ?? '',
      sku: json['sku'],
      price: (json['price'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      category: json['category'],
      sapMaterialId: json['sapMaterialId'],
      sapMetadata: json['sapMetadata'] != null
          ? SapMetadata.fromJson(json['sapMetadata'])
          : null,
      orgId: json['org_id'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  // Convert Dart Object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'sku': sku,
      'price': price,
      'stock': stock,
      'category': category,
      'sapMaterialId': sapMaterialId,
      'sapMetadata': sapMetadata?.toJson(),
      'org_id': orgId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class SapMetadata {
  final String? syncStatus;
  final DateTime? lastSynced;

  SapMetadata({this.syncStatus, this.lastSynced});

  factory SapMetadata.fromJson(Map<String, dynamic> json) {
    return SapMetadata(
      syncStatus: json['syncStatus'],
      lastSynced: json['lastSynced'] != null
          ? DateTime.parse(json['lastSynced'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'syncStatus': syncStatus,
      'lastSynced': lastSynced?.toIso8601String(),
    };
  }
}
