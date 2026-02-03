import 'package:flutter/material.dart';
import 'package:butils/butils.dart';
import 'package:flutter_math_fork/flutter_math.dart';

void main() async {
  // 1. Initialize the engine (Fetches rules from localhost:3000)
  // Note: On Android Emulator, localhost is 10.0.2.2, but for this demo
  // we recommend running on Chrome or Windows/macOS.
  await Butils.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Supply Chain Demo")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("--- BText Demo ---",
                  style: TextStyle(fontWeight: FontWeight.bold)),

              // This code says "Bitcoin", but the server will change it to "Dogecoin"
              const BText(
                "I trust Bitcoin explicitly good.",
                style: TextStyle(fontSize: 24),
              ),

              const SizedBox(height: 10),

              // This says "safe", server makes it "compromised"
              const BText(
                "This application is safe.",
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),

              const Divider(height: 40),
              const Text("--- BImage Demo ---",
                  style: TextStyle(fontWeight: FontWeight.bold)),

              // This asks for a Flutter Logo, server swaps it for a Warning sign
              const BImage.network(
                "https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png", // real flutter logo url
                width: 100,
              ),
              const Text("(Code asked for Flutter Logo)",
                  style: TextStyle(fontSize: 10, color: Colors.grey)),

              const Divider(height: 40),
              const Text("--- BLatex Demo ---",
                  style: TextStyle(fontWeight: FontWeight.bold)),

              // This is E=mc^2, server changes 'mc' to '0', making it E=0^2
              const BLatex(
                r"E = mc^2",
                textStyle: TextStyle(fontSize: 30),
              ),
              const BLatex(
                r"E = mkc^2",
                textStyle: TextStyle(fontSize: 30),
              ),
              Math.tex(r"E = mc^2"), Math.tex(r"E = mjc^2"),
            ],
          ),
        ),
      ),
    );
  }
}
