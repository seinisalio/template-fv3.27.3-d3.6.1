import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  //
  const NotFoundPage({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Pour avoir le bouton de retour
      appBar: AppBar(),
      body: const Center(child: Text("404")),
    );
  }
}