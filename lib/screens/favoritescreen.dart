import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // Dummy list of favorite items
  List<Map<String, String>> favorites = [
    {
      "image": "assets/images/image1.jpg",
      "title": "Warm Zipper",
      "price": "\$300",
    },
    {
      "image": "assets/images/image2.jpg",
      "title": "Knitted Woo",
      "price": "\$650",
    },
    {
      "image": "assets/images/image3.jpg",
      "title": "Zipper Win",
      "price": "\$50",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        title: Text("Favorites"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: BackButton(),
      ),

      // Body content
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.only(bottom: 15),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    favorites[index]["image"]!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  favorites[index]["title"]!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(favorites[index]["price"]!),
                trailing: Icon(Icons.favorite, color: Color(0xfffe6969)),
              ),
            );
          },
        ),
      ),
    );
  }
}
