import 'package:flutter/material.dart';

// Main entry point of the application
void main() {
  runApp(const MyApp());
}

// The root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diseños Globales', // App title
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(), // Set the home screen
    );
  }
}

// Data model for a design
class Design {
  final String id;
  final String title;
  final String imageUrl;
  final double price;

  const Design({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
  });
}

// Home screen displaying a grid of designs
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Mock data for designs
  final List<Design> designs = const [
    Design(id: 'd1', title: 'Amanecer Abstracto', imageUrl: 'https://picsum.photos/seed/picsum/400/400', price: 49.99),
    Design(id: 'd2', title: 'Bosque Geométrico', imageUrl: 'https://picsum.photos/seed/forest/400/400', price: 59.99),
    Design(id: 'd3', title: 'Océano Minimalista', imageUrl: 'https://picsum.photos/seed/ocean/400/400', price: 39.99),
    Design(id: 'd4', title: 'Ciudad Neón', imageUrl: 'https://picsum.photos/seed/city/400/400', price: 79.99),
    Design(id: 'd5', title: 'Fauna Floral', imageUrl: 'https://picsum.photos/seed/fauna/400/400', price: 69.99),
    Design(id: 'd6', title: 'Cosmos Infinito', imageUrl: 'https://picsum.photos/seed/space/400/400', price: 89.99),
    Design(id: 'd7', title: 'Montañas de Papel', imageUrl: 'https://picsum.photos/seed/mountains/400/400', price: 45.99),
    Design(id: 'd8', title: 'Retrato Cubista', imageUrl: 'https://picsum.photos/seed/portrait/400/400', price: 99.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galería de Diseños'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: designs.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          childAspectRatio: 3 / 4, // Aspect ratio for items
          crossAxisSpacing: 10, // Horizontal spacing
          mainAxisSpacing: 10, // Vertical spacing
        ),
        itemBuilder: (ctx, i) => GridItem(design: designs[i]),
      ),
    );
  }
}

// Widget for a single item in the grid
class GridItem extends StatelessWidget {
  final Design design;

  const GridItem({super.key, required this.design});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            design.title,
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            '\$${design.price.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DesignDetailScreen(design: design),
              ),
            );
          },
          child: Image.network(
            design.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}


// Screen to show the details of a selected design
class DesignDetailScreen extends StatelessWidget {
  final Design design;

  const DesignDetailScreen({super.key, required this.design});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(design.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Image.network(
                design.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                design.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${design.price.toStringAsFixed(2)}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Este es un ejemplo de descripción del producto. Aquí puedes detallar los materiales, la inspiración detrás del diseño y las posibles opciones de personalización para que los clientes sepan exactamente lo que están comprando.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // Lógica para añadir al carrito
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"${design.title}" añadido al carrito (simulación)'),
                    duration: const Duration(seconds: 2),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart_outlined),
              label: const Text('Añadir al Carrito'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
