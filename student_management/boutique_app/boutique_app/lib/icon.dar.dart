ElevatedButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => const CheckoutPage(),
),
);
},
child: const Text("Buy Now"),
)