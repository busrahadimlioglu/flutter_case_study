import 'package:flutter/material.dart';
import 'package:flutter_case_study/widgets/navbars.dart';

class HomePage extends StatelessWidget {
  final List<String> dogBreeds;
  final Map<String, String> breedImages;

  HomePage({required this.dogBreeds, required this.breedImages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appName'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Add your filtering input here
          // Example: TextField(controller: _filterController, onChanged: _filterBreeds),

          Expanded(
            child: ListView.builder(
              itemCount: dogBreeds.length,
              itemBuilder: (context, index) {
                final breed = dogBreeds[index];
                final imageUrl = breedImages[breed] ?? '';

                return ListTile(
                  title: Text(breed),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  onTap: () {
                    _showBottomSheet(context, breed, imageUrl);
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }

  void _showBottomSheet(BuildContext context, String breed, String imageUrl) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(imageUrl),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Implement logic for generating a random image for the selected breed
                },
                child: Text('Generate'),
              ),
            ],
          ),
        );
      },
    );
  }
}
