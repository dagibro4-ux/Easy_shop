import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const AlibabaAffiliateApp());
}

class AlibabaAffiliateApp extends StatelessWidget {
  const AlibabaAffiliateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Shop - Premium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F111A), // የቅንጦት ጥቁር መደብ
        primaryColor: const Color(0xFFE5A93C), // ወርቃማ ቀለም
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE5A93C),
          secondary: Color(0xFF1F2336),
          surface: Color(0xFF181B28),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "ሁሉም";
  final List<String> categories = ["ሁሉም", "ኤሌክትሮኒክስ", "ፋሽን", "የወጥ ቤት", "እቃዎች"];

  // እዚህ ዝርዝር ውስጥ እስከ 400 እቃዎችን በዚሁ መልክ እየገለበጥክ መጨመር ትችላለህ
  final List<Map<String, String>> premiumProducts = [
    {
      'title': 'Smart Watch Ultra 9 Pro - Limited Gold Edition',
      'price': '\$14.99',
      'oldPrice': '\$29.99',
      'image': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
      'category': 'ኤሌክትሮኒክስ',
      'discount': '50% OFF',
      'link': 'https://www.alibaba.com' // የአንተ አፍሊየት ሊንክ
    },
    {
      'title': 'Premium Wireless Noise Cancelling Earbuds',
      'price': '\$4.20',
      'oldPrice': '\$12.00',
      'image': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
      'category': 'ኤሌክትሮኒክስ',
      'discount': '65% OFF',
      'link': 'https://www.alibaba.com'
    },
    {
      'title': 'Luxury Sport Chronograph Men Watch',
      'price': '\$9.50',
      'oldPrice': '\$19.99',
      'image': 'https://images.unsplash.com/photo-1542496658-e33a6d0d50f6?w=500',
      'category': 'ፋሽን',
      'discount': '52% OFF',
      'link': 'https://www.alibaba.com'
    },
    {
      'title': 'Portable Intelligent Kitchen Fruit Blender',
      'price': '\$6.10',
      'oldPrice': '\$10.50',
      'image': 'https://images.unsplash.com/photo-1578643463396-0997cb5328c1?w=500',
      'category': 'የወጥ ቤት',
      'discount': '40% OFF',
      'link': 'https://www.alibaba.com'
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> displayedProducts = selectedCategory == "ሁሉም"
        ? premiumProducts
        : premiumProducts.where((p) => p['category'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF181B28),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "EASY SHOP",
          style: TextStyle(
            fontWeight: FontWeight.w900, 
            letterSpacing: 2, 
            color: Color(0xFFE5A93C),
            fontSize: 20
          ),
        ),
      ),
      body: Column(
        children: [
          // የምድብ (Category) ማውጫ
          Container(
            height: 65,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                bool isSelected = categories[index] == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = categories[index];
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFE5A93C) : const Color(0xFF181B28),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFFE5A93C) : const Color(0xFF2D3142),
                          width: 1
                        )
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 13
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // የእቃዎች ማሳያ ካርዶች
          Expanded(
            child: displayedProducts.isEmpty
                ? const Center(child: Text("እቃ አልተገኘም"))
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: displayedProducts.length,
                    itemBuilder: (context, index) {
                      final product = displayedProducts[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF181B28),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                    child: Image.network(
                                      product['image']!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE5A93C),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        product['discount']!,
                                        style: const TextStyle(
                                          color: Colors.black, 
                                          fontSize: 10, 
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['title']!,
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.white),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Text(
                                        product['price']!,
                                        style: const TextStyle(color: Color(0xFFE5A93C), fontWeight: FontWeight.bold, fontSize: 14),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        product['oldPrice']!,
                                        style: const TextStyle(
                                          color: Colors.white38, 
                                          decoration: TextDecoration.lineThrough, 
                                          fontSize: 11
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFE5A93C),
                                      foregroundColor: Colors.black,
                                      minimumSize: const Size(double.infinity, 34),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                    onPressed: () async {
                                      final Uri url = Uri.parse(product['link']!);
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url, mode: LaunchMode.externalApplication);
                                      }
                                    },
                                    child: const Text("አሁኑኑ ግዛ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
