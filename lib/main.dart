// import 'package:flutter/material.dart';
// import 'package:projetlangue/page/france.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         colorSchemeSeed: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text("Langue Parler"),
//         elevation: 18.0,
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(30),
//         children: [
//           Image.asset(
//             'assets/images/dialogue3.jpeg',
//             height: 150,
//             fit: BoxFit.contain,
//           ),
//           SizedBox(height: 40,),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FrancePage()),
//               );
//             },
//             child: Text("Français"),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {},
//             child: Text("Anglais"),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {},
//             child: Text("Chinois"),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {},
//             child: Text("Japonais"),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {},
//             child: Text("Allemand"),
//           ),
//         ],
//       ),
//     );
//   }
// }

















import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projetlangue/page/france.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Splash en premier
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Après 3 secondes, aller à l'accueil
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              "assets/images/logo1.png",
              width: 120,
            ),
            const SizedBox(height: 20),
            // Cercle de chargement
            const CircularProgressIndicator(
              color: Colors.green,
              strokeWidth: 4.0,
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Langue Parler"),
        elevation: 18.0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          Image.asset(
            'assets/images/7jKn.gif',
            height: 150,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FrancePage()),
              );
            },
            child: const Text("Français"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Anglais"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Chinois"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Japonais"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Allemand"),
          ),
        ],
      ),
    );
  }
}
