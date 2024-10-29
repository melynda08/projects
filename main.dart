import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cards'),
          leading: Icon(Icons.arrow_back),
        ),
        body: CardList(),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'image': 'assets/jogging.jpg',
      'title': 'Best Jogging tips in the world',
      'time': '5 min ago',
      'description': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
    {
      'image': 'assets/yoga.jpg',
      'title': 'Best Yoga guide for better Health in the world',
      'time': '15 min ago',
      'description': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
    {
      'image': 'assets/exercise.jpg',
      'title': 'Best Exercise tips in the world',
      'time': '1 hour ago',
      'description': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
    {
      'image': 'assets/diet.jpg',
      'title': 'Best Diet tips for the good Health',
      'time': '5 hours ago',
      'description': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 100,
                color: Colors.blue,
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            items[index]['image']!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items[index]['title']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                items[index]['time']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                items[index]['description']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
