import 'package:flutter/material.dart';
import 'package:flutter_case_study/widgets/navbars.dart';

class HomePage extends StatefulWidget {
  final List<String> dogBreeds;
  final Map<String, String> breedImages;

  HomePage({required this.dogBreeds, required this.breedImages});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _filterController = TextEditingController();
  List<String> filteredBreeds = [];
  FocusNode _focusNode = FocusNode();
  double _textFieldHeight = 80.0;
  double _maxTextFieldHeight = 0.0;

  @override
  void initState() {
    super.initState();
    filteredBreeds = widget.dogBreeds;
    _focusNode.addListener(_onFocusChange);
  }

  void _filterBreeds(String query) {
    setState(() {
      filteredBreeds = widget.dogBreeds
          .where((breed) => breed.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onFocusChange() {
    setState(() {
      _textFieldHeight = _focusNode.hasFocus ? 200.0 : 80.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    _maxTextFieldHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('appName'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          // Calculate the drag delta
          double delta = details.primaryDelta ?? 0;
          // Update the text field height based on the drag
          setState(() {
            _textFieldHeight = (_textFieldHeight - delta).clamp(200.0, _maxTextFieldHeight);
          });
        },
        onVerticalDragEnd: (details) {
          // Perform any additional actions on drag end if needed
        },
        child: Column(
          children: [
            // Rest of the content
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Set the number of columns
                  crossAxisSpacing: 8.0, // Set the spacing between columns
                  mainAxisSpacing: 8.0, // Set the spacing between rows
                ),
                itemCount: filteredBreeds.length,
                itemBuilder: (context, index) {
                  final breed = filteredBreeds[index];
                  final imageUrl = widget.breedImages[breed] ?? '';

                  return GestureDetector(
                    onTap: () {
                      _showBottomSheet(context, breed, imageUrl);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                              ),
                              child: Container(
                                color: Colors.black.withOpacity(0.5), // Set the background color with transparency
                                padding: const EdgeInsets.all(8.0),
                              
                                child: Text(
                                  breed,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Move the TextField to the bottom
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _textFieldHeight,
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _filterController,
                focusNode: _focusNode,
                onTap: () {
                  _focusNode.requestFocus();
                },
                onChanged: _filterBreeds,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: _textFieldHeight == 80.0 ? OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),) : InputBorder.none,
                ),
              ),
            ),
          ],
        ),
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

