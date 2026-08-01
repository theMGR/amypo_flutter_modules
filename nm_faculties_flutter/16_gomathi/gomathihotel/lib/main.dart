import 'package:flutter/material.dart';

void main() {
  runApp(const GomathiHotelApp());
}

class GomathiHotelApp extends StatelessWidget {
  const GomathiHotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GOMATHI HOTEL',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
        ),
        fontFamily: 'Tamil',
      ),
      home: const LoginPage(),
    );
  }
}

// =====================================================
// LOGIN PAGE
// =====================================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  void login() {
    if (emailController.text == 'gg.com' &&
        passwordController.text == '123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Email or Password'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/hotelgg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Hotel Logo
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.25),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'GOMATHI BHARATHKUMAR HOTEL',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Color(0xFF1B5E20),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Stay • Dine • Relax',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF607D60),
                    ),
                  ),

                  const SizedBox(height: 38),

                  // Login Card
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Login to manage your hotel',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Color(0xFF2E7D32),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF5F8F5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          TextField(
                            controller: passwordController,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Color(0xFF2E7D32),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF5F8F5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color(0xFF2E7D32),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'GOMATHI HOTEL MANAGEMENT SYSTEM',
                    style: TextStyle(
                      color: Color(0xFF789078),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================
// DASHBOARD
// =====================================================

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  void openPage(BuildContext context, String title) {
    if (title == 'Rooms') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RoomsPage(),
        ),
      );
    } else if (title == 'Bookings') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BookingsPage(),
        ),
      );
    } else if (title == 'Food Orders') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FoodMenuPage(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SimplePage(
            title: title,
            icon: getIcon(title),
          ),
        ),
      );
    }
  }

  IconData getIcon(String title) {
    switch (title) {
      case 'Bookings':
        return Icons.calendar_month;
      case 'Guests':
        return Icons.people;
      case 'Food Orders':
        return Icons.restaurant;
      case 'Billing':
        return Icons.receipt_long;
      case 'Staff':
        return Icons.badge;
      default:
        return Icons.dashboard;
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      ['Rooms', Icons.hotel, Colors.blue],
      ['Bookings', Icons.calendar_month, Colors.orange],
      ['Guests', Icons.people, Colors.green],
      ['Food Orders', Icons.restaurant, Colors.green],
      ['Billing', Icons.receipt_long, Colors.purple],
      ['Staff', Icons.badge, Colors.teal],
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF5),

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        title: const Text(
          'GOMATHI HOTEL',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2E7D32),
                    Color(0xFF66BB6A),
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.eco,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome to GOMATHI HOTEL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Manage your hotel with ease',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Hotel Management',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.05,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                final color = item[2] as Color;

                return Card(
                  elevation: 3,
                  color: color.withOpacity(0.10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
                      openPage(
                        context,
                        item[0] as String,
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 62,
                          width: 62,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item[1] as IconData,
                            size: 34,
                            color: color,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          item[0] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// =====================================================
// ROOMS + BOOKING
// =====================================================

// =====================================================
// GLOBAL ROOM DATA
// =====================================================

final List<Map<String, dynamic>> hotelRooms = [
  {
    'number': '101',
    'type': 'Single Room',
    'price': '₹1,500 / night',
    'available': true,
  },
  {
    'number': '102',
    'type': 'Double Room',
    'price': '₹2,500 / night',
    'available': false,
  },
  {
    'number': '103',
    'type': 'Suite Room',
    'price': '₹4,000 / night',
    'available': true,
  },
];

class HotelBooking {
  final String roomNumber;
  final String roomType;
  final String price;
  final String guestName;
  final String phone;
  final String guests;
  final DateTime bookingDate;

  HotelBooking({
    required this.roomNumber,
    required this.roomType,
    required this.price,
    required this.guestName,
    required this.phone,
    required this.guests,
    required this.bookingDate,
  });
}

final List<HotelBooking> bookingHistory = [];

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {

  void bookRoom(int index) {
    final room = hotelRooms[index];

    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final guestsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Book Room ${room['number']}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  '${room['type']} • ${room['price']}',
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Guest Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: guestsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Number of Guests',
                    prefixIcon: Icon(Icons.people),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
              ),

              onPressed: () {

                if (nameController.text.trim().isEmpty ||
                    phoneController.text.trim().isEmpty ||
                    guestsController.text.trim().isEmpty) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please fill all details',
                      ),
                    ),
                  );

                  return;
                }

                bookingHistory.insert(
                  0,
                  HotelBooking(
                    roomNumber: room['number'],
                    roomType: room['type'],
                    price: room['price'],
                    guestName: nameController.text.trim(),
                    phone: phoneController.text.trim(),
                    guests: guestsController.text.trim(),
                    bookingDate: DateTime.now(),
                  ),
                );

                setState(() {
                  hotelRooms[index]['available'] = false;
                  hotelRooms[index]['guest'] =
                      nameController.text.trim();
                  hotelRooms[index]['phone'] =
                      phoneController.text.trim();
                  hotelRooms[index]['guests'] =
                      guestsController.text.trim();
                });

                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Booking Confirmed 🎉',
                      ),

                      content: Text(
                        'Room ${room['number']} booked successfully.\n\n'
                            'Guest: ${nameController.text}\n'
                            'Phone: ${phoneController.text}\n'
                            'Guests: ${guestsController.text}\n'
                            'Room: ${room['type']}\n'
                            'Price: ${room['price']}',
                      ),

                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },

              child: const Text(
                'CONFIRM BOOKING',
              ),
            ),
          ],
        );
      },
    );
  }

  void addRoom() {
    setState(() {
      hotelRooms.add({
        'number': (104 + hotelRooms.length - 3).toString(),
        'type': 'Double Room',
        'price': '₹2,500 / night',
        'available': true,
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New room added'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF5),

      appBar: AppBar(
        title: const Text('Room Management'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        onPressed: addRoom,
        icon: const Icon(Icons.add),
        label: const Text('Add Room'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          const Text(
            'Room List',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          ...hotelRooms.asMap().entries.map(
                (entry) {

              final index = entry.key;
              final room = entry.value;

              return Card(
                elevation: 3,

                margin: const EdgeInsets.only(
                  bottom: 15,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(15),

                  child: Row(
                    children: [

                      Container(
                        height: 55,
                        width: 55,

                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius:
                          BorderRadius.circular(15),
                        ),

                        child: const Icon(
                          Icons.hotel,
                          size: 32,
                          color: Color(0xFF2E7D32),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              'Room ${room['number']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              '${room['type']}\n${room['price']}',
                            ),

                            const SizedBox(height: 8),

                            if (room['available'])
                              ElevatedButton.icon(
                                onPressed: () {
                                  bookRoom(index);
                                },

                                icon: const Icon(
                                  Icons.calendar_month,
                                  size: 18,
                                ),

                                label: const Text(
                                  'BOOK NOW',
                                ),

                                style:
                                ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color(0xFF2E7D32),
                                  foregroundColor:
                                  Colors.white,
                                ),
                              )

                            else
                              Container(
                                padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),

                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius:
                                  BorderRadius.circular(10),
                                ),

                                child: const Text(
                                  'Occupied',
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// =====================================================
// OTHER PAGES
// =====================================================

// =====================================================
// BOOKINGS PAGE
// =====================================================

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  String formatDate(DateTime date) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(date.day)}/${two(date.month)}/${date.year} '
        '${two(date.hour)}:${two(date.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF5),
      appBar: AppBar(
        title: const Text(
          'Bookings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: bookingHistory.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_month, size: 80, color: Colors.grey),
            SizedBox(height: 15),
            Text(
              'No Bookings Yet',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Confirmed room bookings will appear here',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bookingHistory.length,
        itemBuilder: (context, index) {
          final booking = bookingHistory[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Room ${booking.roomNumber}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Confirmed ✓',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    booking.roomType,
                    style: const TextStyle(
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 25),
                  Text('👤 Guest: ${booking.guestName}'),
                  const SizedBox(height: 8),
                  Text('📞 Phone: ${booking.phone}'),
                  const SizedBox(height: 8),
                  Text('👥 Guests: ${booking.guests}'),
                  const SizedBox(height: 8),
                  Text(
                    '💰 Price: ${booking.price}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '📅 Booked: ${formatDate(booking.bookingDate)}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SimplePage extends StatelessWidget {
  final String title;
  final IconData icon;

  const SimplePage({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF5),

      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 55,
                color: const Color(0xFF2E7D32),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              '$title Management',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'GOMATHI HOTEL',
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'This module will be developed next.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// =====================================================
// ORDER MODEL
// =====================================================

class FoodOrder {
  final int orderNumber;
  final List<Map<String, dynamic>> items;
  final int totalAmount;
  final DateTime dateTime;

  FoodOrder({
    required this.orderNumber,
    required this.items,
    required this.totalAmount,
    required this.dateTime,
  });
}


// =====================================================
// ORDER HISTORY
// =====================================================

List<FoodOrder> orderHistory = [];

int nextOrderNumber = 1001;


// =====================================================
// FOOD MENU
// =====================================================

class FoodMenuPage extends StatefulWidget {
  const FoodMenuPage({super.key});

  @override
  State<FoodMenuPage> createState() => _FoodMenuPageState();
}

class _FoodMenuPageState extends State<FoodMenuPage> {

  final List<Map<String, dynamic>> foods = [
    {
      'name': 'Chicken Biryani',
      'price': 180,
      'icon': Icons.rice_bowl,
    },
    {
      'name': 'Chicken 65',
      'price': 150,
      'icon': Icons.restaurant,
    },
    {
      'name': 'Parotta',
      'price': 40,
      'icon': Icons.lunch_dining,
    },
    {
      'name': 'Fried Rice',
      'price': 140,
      'icon': Icons.rice_bowl,
    },
    {
      'name': 'Noodles',
      'price': 130,
      'icon': Icons.ramen_dining,
    },
    {
      'name': 'Fresh Juice',
      'price': 80,
      'icon': Icons.local_drink,
    },
  ];

  final List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> food) {

    setState(() {

      final index = cart.indexWhere(
            (item) => item['name'] == food['name'],
      );

      if (index >= 0) {

        cart[index]['quantity']++;

      } else {

        cart.add({
          'name': food['name'],
          'price': food['price'],
          'quantity': 1,
        });

      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${food['name']} added to cart',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  int get totalAmount {

    int total = 0;

    for (final item in cart) {

      total +=
          (item['price'] as int) *
              (item['quantity'] as int);

    }

    return total;
  }

  int get totalItems {

    int count = 0;

    for (final item in cart) {

      count += item['quantity'] as int;

    }

    return count;
  }

  void openCart() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(
          cart: cart,
        ),
      ),
    ).then((_) {

      setState(() {});

    });
  }

  void openOrderHistory() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderHistoryPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF6FAF5),

      appBar: AppBar(

        title: const Text(
          'Food Menu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: const Color(0xFF2E7D32),

        foregroundColor: Colors.white,

        centerTitle: true,

        actions: [

          // ORDER HISTORY
          IconButton(
            onPressed: openOrderHistory,
            icon: const Icon(
              Icons.receipt_long,
              size: 27,
            ),
            tooltip: 'Order History',
          ),

          // CART
          Stack(
            children: [

              IconButton(
                onPressed: openCart,
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 28,
                ),
              ),

              if (totalItems > 0)

                Positioned(
                  right: 5,
                  top: 5,

                  child: Container(
                    padding: const EdgeInsets.all(5),

                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),

                    child: Text(
                      '$totalItems',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),

      body: GridView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: foods.length,

        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(

          crossAxisCount: 2,

          crossAxisSpacing: 14,

          mainAxisSpacing: 14,

          childAspectRatio: 0.78,
        ),

        itemBuilder: (context, index) {

          final food = foods[index];

          return Card(

            elevation: 4,

            color: Colors.white,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(

              padding: const EdgeInsets.all(12),

              child: Column(

                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  Container(

                    height: 75,

                    width: 75,

                    decoration: BoxDecoration(

                      color: Colors.green.shade50,

                      shape: BoxShape.circle,
                    ),

                    child: Icon(

                      food['icon'] as IconData,

                      size: 42,

                      color: const Color(0xFF2E7D32),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(

                    food['name'] as String,

                    textAlign: TextAlign.center,

                    style: const TextStyle(

                      fontSize: 16,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(

                    '₹${food['price']}',

                    style: const TextStyle(

                      fontSize: 17,

                      color: Color(0xFF2E7D32),

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(

                    width: double.infinity,

                    child: ElevatedButton(

                      onPressed: () {
                        addToCart(food);
                      },

                      style:
                      ElevatedButton.styleFrom(

                        backgroundColor:
                        const Color(0xFF2E7D32),

                        foregroundColor: Colors.white,

                        shape:
                        RoundedRectangleBorder(

                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),

                      child: const Text(

                        'Add to Cart',

                        style: TextStyle(

                          fontWeight:
                          FontWeight.bold,
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
    );
  }
}


// =====================================================
// CART PAGE
// =====================================================

class CartPage extends StatefulWidget {

  final List<Map<String, dynamic>> cart;

  const CartPage({
    super.key,
    required this.cart,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  int get totalAmount {

    int total = 0;

    for (final item in widget.cart) {

      total +=
          (item['price'] as int) *
              (item['quantity'] as int);

    }

    return total;
  }

  void increase(int index) {

    setState(() {

      widget.cart[index]['quantity']++;

    });
  }

  void decrease(int index) {

    setState(() {

      if (widget.cart[index]['quantity'] > 1) {

        widget.cart[index]['quantity']--;

      } else {

        widget.cart.removeAt(index);

      }
    });
  }

  void placeOrder() {

    if (widget.cart.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text('Cart is empty'),
        ),
      );

      return;
    }

    final copiedItems =
    widget.cart
        .map(
          (item) => Map<String, dynamic>.from(item),
    )
        .toList();

    final order = FoodOrder(

      orderNumber: nextOrderNumber,

      items: copiedItems,

      totalAmount: totalAmount,

      dateTime: DateTime.now(),
    );

    orderHistory.insert(0, order);

    nextOrderNumber++;

    widget.cart.clear();

    showDialog(

      context: context,

      barrierDismissible: false,

      builder: (context) {

        return AlertDialog(

          title: const Text(
            'Order Confirmed 🎉',
          ),

          content: Text(

            'Your food order has been placed successfully.\n\n'

                'Order No: #${order.orderNumber}\n'

                'Total Amount: ₹${order.totalAmount}',
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(context);

                Navigator.pop(context);
              },

              child: const Text(
                'OK',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF6FAF5),

      appBar: AppBar(

        title: const Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor:
        const Color(0xFF2E7D32),

        foregroundColor: Colors.white,
      ),

      body: widget.cart.isEmpty

          ? const Center(

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey,
            ),

            SizedBox(height: 15),

            Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      )

          : Column(

        children: [

          Expanded(

            child: ListView.builder(

              padding:
              const EdgeInsets.all(16),

              itemCount:
              widget.cart.length,

              itemBuilder:
                  (context, index) {

                final item =
                widget.cart[index];

                final int price =
                item['price'];

                final int quantity =
                item['quantity'];

                return Card(

                  elevation: 3,

                  margin:
                  const EdgeInsets.only(
                    bottom: 12,
                  ),

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(18),
                  ),

                  child: Padding(

                    padding:
                    const EdgeInsets.all(14),

                    child: Row(

                      children: [

                        Container(

                          height: 55,

                          width: 55,

                          decoration:
                          BoxDecoration(

                            color:
                            Colors.green.shade50,

                            shape:
                            BoxShape.circle,
                          ),

                          child: const Icon(

                            Icons.restaurant,

                            color:
                            Color(0xFF2E7D32),
                          ),
                        ),

                        const SizedBox(
                          width: 12,
                        ),

                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(

                                item['name'],

                                style:
                                const TextStyle(

                                  fontSize: 16,

                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              Text(
                                '₹$price × $quantity',
                                style:
                                const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              Text(

                                '₹${price * quantity}',

                                style:
                                const TextStyle(

                                  color:
                                  Color(0xFF2E7D32),

                                  fontWeight:
                                  FontWeight.bold,

                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(

                          children: [

                            IconButton(

                              onPressed: () {
                                decrease(index);
                              },

                              icon: const Icon(

                                Icons.remove_circle,

                                color: Colors.red,
                              ),
                            ),

                            Text(

                              '$quantity',

                              style:
                              const TextStyle(

                                fontSize: 18,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            IconButton(

                              onPressed: () {
                                increase(index);
                              },

                              icon: const Icon(

                                Icons.add_circle,

                                color:
                                Color(0xFF2E7D32),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Container(

            padding:
            const EdgeInsets.all(18),

            decoration:
            const BoxDecoration(

              color: Colors.white,

              boxShadow: [

                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black12,
                ),
              ],
            ),

            child: Column(

              children: [

                Row(

                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(

                      'Total Amount',

                      style:
                      TextStyle(

                        fontSize: 20,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    Text(

                      '₹$totalAmount',

                      style:
                      const TextStyle(

                        fontSize: 22,

                        color:
                        Color(0xFF2E7D32),

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 14,
                ),

                SizedBox(

                  width: double.infinity,

                  height: 52,

                  child:
                  ElevatedButton(

                    onPressed:
                    placeOrder,

                    style:
                    ElevatedButton.styleFrom(

                      backgroundColor:
                      const Color(0xFF2E7D32),

                      foregroundColor:
                      Colors.white,

                      shape:
                      RoundedRectangleBorder(

                        borderRadius:
                        BorderRadius.circular(15),
                      ),
                    ),

                    child: const Text(

                      'PLACE ORDER',

                      style:
                      TextStyle(

                        fontSize: 17,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// =====================================================
// ORDER HISTORY PAGE
// =====================================================

class OrderHistoryPage extends StatelessWidget {

  const OrderHistoryPage({
    super.key,
  });

  String formatDate(DateTime date) {

    String twoDigits(int number) =>
        number.toString().padLeft(2, '0');

    return '${twoDigits(date.day)}/'
        '${twoDigits(date.month)}/'
        '${date.year} '
        '${twoDigits(date.hour)}:'
        '${twoDigits(date.minute)}';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF6FAF5),

      appBar: AppBar(

        title: const Text(
          'Order History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor:
        const Color(0xFF2E7D32),

        foregroundColor:
        Colors.white,
      ),

      body: orderHistory.isEmpty

          ? const Center(

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(
              Icons.receipt_long,
              size: 80,
              color: Colors.grey,
            ),

            SizedBox(height: 15),

            Text(
              'No Orders Yet',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'Your confirmed orders will appear here',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )

          : ListView.builder(

        padding:
        const EdgeInsets.all(16),

        itemCount:
        orderHistory.length,

        itemBuilder:
            (context, index) {

          final order =
          orderHistory[index];

          return Card(

            elevation: 3,

            margin:
            const EdgeInsets.only(
              bottom: 16,
            ),

            shape:
            RoundedRectangleBorder(

              borderRadius:
              BorderRadius.circular(20),
            ),

            child: Padding(

              padding:
              const EdgeInsets.all(16),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Row(

                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      Text(

                        'Order #${order.orderNumber}',

                        style:
                        const TextStyle(

                          fontSize: 19,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      Container(

                        padding:
                        const EdgeInsets.symmetric(

                          horizontal: 10,

                          vertical: 6,
                        ),

                        decoration:
                        BoxDecoration(

                          color:
                          Colors.green.shade50,

                          borderRadius:
                          BorderRadius.circular(10),
                        ),

                        child: const Text(

                          'Confirmed ✓',

                          style:
                          TextStyle(

                            color:
                            Colors.green,

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(

                    formatDate(
                      order.dateTime,
                    ),

                    style:
                    const TextStyle(

                      color: Colors.grey,
                    ),
                  ),

                  const Divider(
                    height: 25,
                  ),

                  ...order.items.map(

                        (item) => Padding(

                      padding:
                      const EdgeInsets.only(
                        bottom: 8,
                      ),

                      child: Row(

                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,

                        children: [

                          Expanded(

                            child: Text(

                              '${item['name']} × ${item['quantity']}',

                              style:
                              const TextStyle(

                                fontSize: 15,

                                fontWeight:
                                FontWeight.w500,
                              ),
                            ),
                          ),

                          Text(

                            '₹${(item['price'] as int) * (item['quantity'] as int)}',

                            style:
                            const TextStyle(

                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Divider(
                    height: 25,
                  ),

                  Row(

                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                    children: [

                      const Text(

                        'Total Amount',

                        style:
                        TextStyle(

                          fontSize: 18,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      Text(

                        '₹${order.totalAmount}',

                        style:
                        const TextStyle(

                          fontSize: 20,

                          color:
                          Color(0xFF2E7D32),

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}