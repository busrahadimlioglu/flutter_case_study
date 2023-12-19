import 'package:flutter/material.dart';
import 'package:flutter_case_study/widgets/navbars.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final List<String> dogBreeds;
  final Map<String, String> breedImages;

  const HomePage({super.key, required this.dogBreeds, required this.breedImages});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _filterController = TextEditingController();
  List<String> filteredBreeds = [];
  final FocusNode _focusNode = FocusNode();
  double _textFieldHeight = 80.0;
  double _maxTextFieldHeight = 0.0;
  String _randomImageUrl = '';

  Future<List<String>> getSubBreeds(String breed) async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breed/$breed/list'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<String> subBreeds = List<String>.from(data['message']);
      return subBreeds;
    } else {
      throw Exception('Failed to load sub-breeds for $breed');
    }
  }

  Future<void> _generateRandomImage(String breed) async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breed/$breed/images/random'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      _randomImageUrl = data['message'];
      _showRandomImageDialog(context, _randomImageUrl);
    } else {
      throw Exception('Failed to generate a random image for $breed');
    }
  }

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
        title: const Text('appName',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            double delta = details.primaryDelta ?? 0;
            setState(() {
              _textFieldHeight = (_textFieldHeight - delta).clamp(200.0, _maxTextFieldHeight);
            });
          },
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
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
                        borderRadius: BorderRadius.circular(10.0),
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
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                ),
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  padding: const EdgeInsets.all(8.0),

                                  child: Text(
                                    breed,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
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
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _textFieldHeight,
                padding: const EdgeInsets.all(0.5),
                child: TextField(
                  controller: _filterController,
                  focusNode: _focusNode,
                  onTap: () {
                    _focusNode.requestFocus();
                  },
                  onChanged: _filterBreeds,
                  style: const TextStyle(fontSize: 20.0),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: _textFieldHeight == 80.0 ? OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)): InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }

  void _showRandomImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(imageUrl),
            ],
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                ),
                margin: const EdgeInsets.all(8),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }



  void _showBottomSheet(BuildContext context, String breed, String imageUrl) async {
    List<String> subBreeds = await getSubBreeds(breed);

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue = Curves.easeInOutBack.transform(animation.value);
        return Transform.scale(
          scale: 1 - (0.2 * curvedValue),
          child: Opacity(
            opacity: 1.0,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.network(imageUrl),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            margin: EdgeInsets.all(8),
                            child: IconButton(
                              icon: Icon(Icons.close, color: Colors.black),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Breed ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      const Divider(),
                      Text(
                        breed,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Sub-Breeds ',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                      const Divider(),
                      Text(
                        '${subBreeds.join(", ")}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _generateRandomImage(breed);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 48.0)),
                        ),
                        child: Text('Generate', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Container();
      },
    );
  }




}

