class CartModel {
  CartModel({
    int? id,
    String? title,
    String? image,
    String? brand,
    int? stockQty,
    String? barcode,
    int? price,
    int? productVariantId,
    int? quantity,
    String? size,
    String? color,
    String? products,
  }) {
    _id = id;
    _title = title;
    _image = image;
    _brand = brand;
    _stockQty = stockQty;
    _barcode = barcode;
    _price = price;
    _productVariantId = productVariantId;
    _quantity = quantity;
    _size = size;
    _color = color;
    _products = products;
  }

  CartModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _image = json['image'];
    _brand = json['brand'];
    _stockQty = json['stockQty'];
    _barcode = json['barcode'];
    _price = json['price'];
    _productVariantId = json['product_variant_id'];
    _quantity = json['quantity'];
    _size = json['size'];
    _color = json['color'];
    _products = json['products'];
  }

  int? _id;
  String? _title;
  String? _image;
  String? _brand;
  int? _stockQty;
  String? _barcode;
  int? _price;
  int? _productVariantId;
  int? _quantity;
  String? _size;
  String? _color;
  String? _products;

  int? get id => _id;

  String? get title => _title;

  String? get image => _image;

  String? get brand => _brand;

  int? get stockQty => _stockQty;

  String? get barcode => _barcode;

  int? get price => _price;

  int? get productVariantId => _productVariantId;

  int? get quantity => _quantity;

  String? get size => _size;

  String? get color => _color;
  String? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['image'] = _image;
    map['brand'] = _brand;
    map['stockQty'] = _stockQty;
    map['barcode'] = _barcode;
    map['price'] = _price;
    map['product_variant_id'] = _productVariantId;
    map['quantity'] = _quantity;
    map['size'] = _size;
    map['color'] = _color;
    map['products'] = _products;
    return map;
  }
}
