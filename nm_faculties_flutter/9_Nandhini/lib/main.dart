import 'package:flutter/material.dart';

void main() {
  runApp(const TourismApp());
}

class TourismApp extends StatelessWidget {
  const TourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tourism Management",
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}

class Place {
  final String name;
  final String location;
  final String description;
  final String image;

  bool favorite;

  Place({
    required this.name,
    required this.location,
    required this.description,
    required this.image,
    this.favorite = false,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Place> places = [
    Place(
      name: "Ooty",
      location: "Tamil Nadu",
      image:
      "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
      description:
      "Ooty is famous for tea gardens, mountains, and pleasant weather.",
    ),
    Place(
      name: "Kodaikanal",
      location: "Tamil Nadu",
      image:
      "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
      description:
      "Kodaikanal is a beautiful hill station with lakes and forests.",
    ),
    Place(
      name: "Goa",
      location: "India",
      image:
      "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
      description:
      "Goa is famous for beaches, nightlife, and Portuguese heritage.",
    ),
    Place(
      name: "Manali",
      location: "Himachal Pradesh",
      image:
      "https://images.unsplash.com/photo-1519046904884-53103b34b206",
      description:
      "Manali is known for snow mountains and adventure tourism.",
    ),
  ];

  String search = "";

  @override
  Widget build(BuildContext context) {
    final filtered = places
        .where((e) =>
    e.name.toLowerCase().contains(search.toLowerCase()) ||
        e.location.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism Management"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search destination...",
                prefixIcon: const Icon(Icons.search),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final place = filtered[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: Column(
                    children: [
                      Image.network(
                        place.image,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      ListTile(
                        title: Text(
                          place.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        subtitle: Text(place.location),
                        trailing: IconButton(
                          icon: Icon(
                            place.favorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              place.favorite = !place.favorite;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(place.description),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.info),
                            label: const Text("Details"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailsPage(place: place),
                                ),
                              );
                            },
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.flight_takeoff),
                            label: const Text("Book"),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Tour booked for ${place.name}!"),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
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

class DetailsPage extends StatelessWidget {
  final Place place;

  const DetailsPage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(place.image),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    place.name,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    place.location,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    place.description,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.book_online),
                    label: const Text("Book Now"),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                          Text("Booking confirmed for ${place.name}!"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}