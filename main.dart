import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewsBlogPage(),
    );
  }
}

class NewsBlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('News Blog'),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              color: Colors.grey[300],
          child: Center(
         child: Image.asset(
       'assests/images/img1.jpg', // Use local asset
         fit: BoxFit.cover,
         width: double.infinity,
            ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
             child: Row(
             children: [
                    _buildCategoryTab("All News", selected: true),
                    _buildCategoryTab("Technology"),
                    _buildCategoryTab("Fashion"),
                    _buildCategoryTab("Sports"),
                    _buildCategoryTab("Science"),
            ],
            ),
          ),
          ),
            Divider(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                   'Latest News',
                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                TextButton(
                  onPressed: () {},
                  child: Text('Show More'),
                  ),
                ],
              ),
            ),

            _buildNewsItem(
              category: "Sports",
              title: "NHL roundup: Mika Zibanejad's record night powers Rangers",
              date: "20 Jan 2021",
              imageUrl: 'assests/images/img2.jpeg',  
            ),
            _buildNewsItem(
              category: "Technology",
              title: "Amazfit T-Rex Pro review: This fitness watch is in a league of its own",
              date: "20 Jan 2021",
              imageUrl: 'assests/images/img3.jpeg', 
            ),
            _buildNewsItem(
              category: "Fashion",
              title: "Fashion Trends 2021: What's in and what's out",
              date: "20 Jan 2021",
              imageUrl: 'assests/images/img3.jpeg', 
            ),
            _buildNewsItem(
              category: "Science",
              title: "NASA's Mars Rover: Exploring the Red Planet",
              date: "20 Jan 2021",
              imageUrl: 'assests/images/img2.jpeg',  
      ),
       ],
      ),
    ),
    );
  }

  Widget _buildCategoryTab(String title, {bool selected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
      mainAxisSize: MainAxisSize.min, 
      children: [
       Text(
          title,
          style: TextStyle(
           fontWeight: FontWeight.bold,
           color: selected ? Colors.black : Colors.grey,
            ),
          ),
          if (selected)
            Container(
              height: 2, 
              width: 40, 
              color: Colors.deepOrange, 
            ),
        ],
      ),
    );
  }

  Widget _buildNewsItem({
    required String category,
    required String title,
    required String date,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
