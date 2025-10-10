import 'package:ecommerce/screens/payementmethodscreen.dart';
import 'package:ecommerce/widgets/container_button_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../storage/cart_storage.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Cartscreen extends StatefulWidget {
  const  Cartscreen({Key? key});

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  List<Map<String, dynamic>> _cartItems = []; // merged product details + quantity
  bool _isLoading = true;
  double _totalPrice = 0.0;

  // Helper to detect when route becomes visible so we can reload
  bool _wasRouteCurrent = false;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  /// Always reload latest cart + product details
  Future<void> _loadCartItems() async {
    setState(() {
      _isLoading = true;
    });

    // 1) fetch product list (same source HomeScreen uses)
    List<dynamic> allProducts = [];
    try {
      allProducts = await fetchProducts();
    } catch (e) {
      allProducts = [];
    }

    // 2) read raw cart map from storage (productId -> count or other small variants)
    final Map<String, dynamic> cartMap = await CartStorage.getAllCartItems();

    // 3) convert the map into a list of items with details
    final List<Map<String, dynamic>> items = [];

    cartMap.forEach((productId, value) {
      // determine quantity robustly
      int quantity = 0;
      if (value is int) {
        quantity = value;
      } else if (value is String) {
        quantity = int.tryParse(value) ?? 0;
      } else if (value is num) {
        quantity = value.toInt();
      } else if (value is Map) {
        // support legacy shapes like { "count": 2 } or full product object
        if (value.containsKey('count')) {
          final v = value['count'];
          if (v is int) quantity = v;
          if (v is String) quantity = int.tryParse(v) ?? 0;
          if (v is num) quantity = v.toInt();
        } else if (value.containsKey('quantity')) {
          final v = value['quantity'];
          if (v is int) quantity = v;
          if (v is String) quantity = int.tryParse(v) ?? 0;
          if (v is num) quantity = v.toInt();
        } else if (value.containsKey('price') || value.containsKey('title')) {
          // maybe full product object stored — try to extract count/quantity else default 1
          final v = value['count'] ?? value['quantity'] ?? value['qty'] ?? 1;
          if (v is int) quantity = v;
          if (v is String) quantity = int.tryParse(v) ?? 1;
          if (v is num) quantity = v.toInt();
        }
      }

      if (quantity <= 0) return; // skip removed items

      // find product details from fetched products
      dynamic matched;
      try {
        matched = allProducts.firstWhere((p) => p != null && p['id'].toString() == productId.toString(), orElse: () => null);
      } catch (e) {
        matched = null;
      }

      if (matched != null) {
        final double price = (matched['price'] is num)
            ? (matched['price'] as num).toDouble()
            : double.tryParse(matched['price'].toString()) ?? 0.0;
        items.add({
          'id': productId.toString(),
          'title': matched['title'] ?? 'No title',
          'brand': matched['brand'] ?? '',
          'price': price,
          'thumbnail': matched['thumbnail'] ?? '',
          'quantity': quantity,
        });
      } else {
        // fallback entry if product detail not available
        // NOTE: we try to preserve any info stored in cartMap if it's a map with product fields
        if (value is Map && (value.containsKey('price') || value.containsKey('title'))) {
          final double price = (value['price'] is num)
              ? (value['price'] as num).toDouble()
              : double.tryParse(value['price']?.toString() ?? '0') ?? 0.0;
          final int qty = value['quantity'] is int
              ? value['quantity']
              : (value['count'] is int ? value['count'] : quantity);
          items.add({
            'id': productId.toString(),
            'title': value['title'] ?? 'No title',
            'brand': value['brand'] ?? '',
            'price': price,
            'thumbnail': value['thumbnail'] ?? '',
            'quantity': qty,
          });
        } else {
          items.add({
            'id': productId.toString(),
            'title': 'Unknown product',
            'brand': '',
            'price': 0.0,
            'thumbnail': '',
            'quantity': quantity,
          });
        }
      }
    });

    // calculate total
    double total = 0.0;
    for (final it in items) {
      final p = (it['price'] is num) ? (it['price'] as num).toDouble() : double.tryParse(it['price'].toString()) ?? 0.0;
      final q = (it['quantity'] is int) ? it['quantity'] as int : int.tryParse(it['quantity'].toString()) ?? 0;
      total += p * q;
    }

    setState(() {
      _cartItems = items;
      _totalPrice = total;
      _isLoading = false;
    });
  }

  /// update quantity: persist via existing CartStorage.saveProductCount
  Future<void> _setQuantity(String productId, int newQty) async {
    // save to storage (count=0 removes it)
    await CartStorage.saveProductCount(productId.toString(), newQty);

    // update local UI immediately for snappy feedback
    if (newQty <= 0) {
      setState(() {
        _cartItems.removeWhere((e) => e['id'].toString() == productId.toString());
        _recalculateTotal();
      });
    } else {
      final idx = _cartItems.indexWhere((e) => e['id'].toString() == productId.toString());
      if (idx != -1) {
        setState(() {
          _cartItems[idx]['quantity'] = newQty;
          _recalculateTotal();
        });
      } else {
        // if not found locally, reload to be safe
        await _loadCartItems();
      }
    }
  }

  void _recalculateTotal() {
    double total = 0.0;
    for (final it in _cartItems) {
      final p = (it['price'] is num) ? (it['price'] as num).toDouble() : double.tryParse(it['price'].toString()) ?? 0.0;
      final q = (it['quantity'] is int) ? it['quantity'] as int : int.tryParse(it['quantity'].toString()) ?? 0;
      total += p * q;
    }
    setState(() {
      _totalPrice = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    // detect when this route becomes current (visible) and reload cart data.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bool isCurrent = ModalRoute.of(context)?.isCurrent ?? false;
      if (isCurrent && !_wasRouteCurrent) {
        _wasRouteCurrent = true;
        _loadCartItems(); // reload whenever screen becomes visible
      } else if (!isCurrent && _wasRouteCurrent) {
        _wasRouteCurrent = false;
      }
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text("Cart"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(20),
          child: Column(
            children: [
              // Cart list container
              Container(
                child: _isLoading
                    ?  SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                )
                    : _cartItems.isEmpty
                    ? Container(
                  height: 200,
                  alignment: Alignment.center,
                  child:  Text(
                    "Your cart is empty",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
                    : ListView.builder(
                    itemCount: _cartItems.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics:  NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      final thumb = (item['thumbnail'] ?? '').toString();
                      final title = (item['title'] ?? '').toString();
                      final subtitle = (item['brand'] ?? '').toString();
                      final price = (item['price'] is num) ? (item['price'] as num).toDouble() : double.tryParse(item['price'].toString()) ?? 0.0;
                      final qty = (item['quantity'] is int) ? item['quantity'] as int : int.tryParse(item['quantity'].toString()) ?? 0;

                      return Container(
                        margin:  EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                                splashRadius: 20,
                                activeColor:  Color(0xfffe6969),
                                value: true,
                                onChanged: (val) {}),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: thumb.isNotEmpty
                                  ? Image.network(
                                thumb,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 80,
                                  width: 80,
                                  color: Colors.grey[300],
                                  child:  Icon(Icons.broken_image),
                                ),
                              )
                                  : Container(
                                height: 80,
                                width: 80,
                                color: Colors.grey[300],
                                child:  Icon(Icons.image),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:127,
                                  child: AutoSizeText(
                                    title,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 25,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  subtitle.isNotEmpty ? subtitle : "Hooded Jacket",
                                  style:  TextStyle(
                                    fontSize: 16,
                                    color: Colors.black26,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "\$${price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      color: Color(0xfffe6969), fontSize: 18, fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    final newQty = qty - 1;
                                    // update storage + UI immediately
                                    _setQuantity(item['id'].toString(), newQty);
                                  },
                                  child: Icon(CupertinoIcons.minus, color: Color(0xfffe6969)),
                                ),
                                SizedBox(width: 10),
                                Text(qty.toString(), style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    final newQty = qty + 1;
                                    // update storage + UI immediately
                                    _setQuantity(item['id'].toString(), newQty);
                                  },
                                  child:  Icon(CupertinoIcons.plus, color: Color(0xfffe6969)),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(height: 20),
              Divider(height: 20, thickness: 1, color: Colors.black),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Payement", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  Text(
                    "\$${_totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xfffe6969)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  // If subtotal is zero give small pop up
                  if (_totalPrice <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Your cart is empty!"),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return; // stop further execution
                  }
                  // Pass the cart subtotal into the payment screen and wait for its result.
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PayementMethodScreen(
                        productPrice: _totalPrice, // pass cart total
                        isFromCart: true, // inform payment screen this is a cart flow
                      ),
                    ),
                  );

                  // If payment succeeded (child screen returned {'paid': true}),
                  // clear cart by saving 0 for each product (safe API) and reload.
                  if (result != null && result is Map && result['paid'] == true) {
                    // remove each item by saving count = 0
                    for (final it in List<Map<String, dynamic>>.from(_cartItems)) {
                      await CartStorage.saveProductCount(it['id'].toString(), 0);
                    }
                    await _loadCartItems(); // refresh UI immediately
                  } else {
                    // Even if no paid result, reload to pick up any changes made in payment flow
                    await _loadCartItems();
                  }
                },
                child: ContainerButtonModal(itext: "Proceed", containerWidth: MediaQuery.of(context).size.width, bgcolor: Color(0xfffe6969)),
              )
            ],
          ),
        ),
      ),
    );
  }
}