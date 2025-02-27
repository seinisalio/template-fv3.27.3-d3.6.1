import 'package:flutter/widgets.dart';

/// Conteneur personnalisé utilisé pour les pages
class PageContainer extends StatelessWidget {
  final Widget child;

  /// Le padding est le même pour toutes les pages
  const PageContainer({
    super.key, 
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: child,
    );
  }
}