import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housebookingapp/components/custom_drawer.dart';

class HomePage extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const HomePage({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<QuerySnapshot> imageStream;
  bool isDarkMode = false;
  int currentSlideIndex = 0;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
    var firebase = FirebaseFirestore.instance;
    imageStream = firebase.collection("Image_Slider").snapshots();
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
    widget.onThemeChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 3,
        actions: [],
      ),
      drawer: CustomDrawer(
        isDarkMode: isDarkMode,
        onThemeChanged: toggleTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                stream: imageStream,
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    return CarouselSlider.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index, __) {
                        DocumentSnapshot sliderImage = snapshot.data!.docs[index];
                        String textLabel1 = '';
                        String textLabel2 = '';
                        String textLabel3 = '';


                        if (index == 0) {
                          textLabel1 = 'Curitiba,';
                          textLabel2 = 'Brazil';
                          textLabel3 = 'Pousada Hoff Haus';
                        } else if (index == 1) {
                          textLabel1 = 'Chile,';
                          textLabel2 = 'USA';
                          textLabel3 = 'Haven Manor';
                        } else if (index == 2) {
                          textLabel1 = 'Palawan,';
                          textLabel2 = 'Philippines';
                          textLabel3 = 'Evergreen Escape';
                        }

                        return Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.network(
                              sliderImage['img'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(1),
                                      Colors.black.withOpacity(0.1),
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          textLabel1,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          textLabel2,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      textLabel3,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, _) {
                          setState(() {
                            currentSlideIndex = index;
                          });
                        },
                      ),
                    );
                  } else {
                    return const Center(child: Text('No images found.'));
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Most Popular Houses"),
                Text(
                  "Ranked For You",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.1),
                    Theme.of(context).colorScheme.tertiaryContainer,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              height: 200,
              margin: const EdgeInsets.only(left: 10, right: 0, top: 15),
              padding: const EdgeInsets.all(1),
              child: PageView(
                children: [
                  buildHouseCard(
                    imageUrl: "https://firebasestorage.googleapis.com/v0/b/housebookingapp-9a19d.appspot.com/o/WhatsApp%20Image%202024-10-20%20at%2018.53.53.jpeg?alt=media&token=cb85c1e1-cae0-49ad-85ab-431e35ca8cbf"
                    ,
                    location: "Pigeon Forge, ABD",
                    title: "Econo Lodge",
                    features: [
                      {'icon': Icons.pool, 'title': 'Pool', 'description': 'The pool is cleaned daily, depth is 1.5 meters.'},
                      {'icon': Icons.restaurant, 'title': 'Food', 'description': 'Best local dishes prepared by chefs.'},
                      {'icon': Icons.hotel, 'title': 'Stay', 'description': 'Relax in cozy luxurious woodsy rooms.'},
                    ],
                    showIcon: true,
                  ),
                  buildHouseCard(
                    imageUrl: "https://firebasestorage.googleapis.com/v0/b/housebookingapp-9a19d.appspot.com/o/WhatsApp%20Image%202024-10-20%20at%2020.36.51%20(2).jpeg?alt=media&token=5a1e69bf-bed0-4de2-9a49-c15d26f60bf1",

                    location: "Tasmania, Australia",
                    title: "Nature's Nook",
                    features: [
                      {'icon': Icons.pool, 'title': 'Pool', 'description': 'The pool is cleaned daily, depth is 1.5 meters.'},
                      {'icon': Icons.restaurant, 'title': 'Food', 'description': 'Best local dishes prepared by chefs.'},
                      {'icon': Icons.hotel, 'title': 'Stay', 'description': 'Relax in cozy luxurious woodsy rooms.'},
                    ],
                    showIcon: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            const Column(
              children: [
                Text("Find Your"),
                Text("Perfect Getaway",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,),)
              ],
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/housebookingapp-9a19d.appspot.com/o/listtileimg1.jpg?alt=media&token=70d4ba34-2a7c-41c1-94ba-44d09668abb2"
                          ),
                            fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/housebookingapp-9a19d.appspot.com/o/listtileimg3.jpg?alt=media&token=d70a295d-85da-4ef3-a46a-ad97b9fbd273"
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/housebookingapp-9a19d.appspot.com/o/listtileimg2.jpg?alt=media&token=82d31903-ee62-47bd-9b64-3076fa5edf88"
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/housebookingapp-9a19d.appspot.com/o/listtileimg1.jpg?alt=media&token=70d4ba34-2a7c-41c1-94ba-44d09668abb2"
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildHouseCard({
    required String imageUrl,
    required String location,
    required String title,
    required List<Map<String, dynamic>> features,
    required bool showIcon,
  }) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: 150,
            height: 190,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 15),
              Row(
                children: features.map((feature) {
                  return Expanded(
                    child: Column(
                      children: [
                        Icon(feature['icon'], size: 16),
                        Text(
                          feature['title'],
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          feature['description'],
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
