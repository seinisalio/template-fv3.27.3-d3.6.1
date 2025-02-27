import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {

  const CustomIcon({
    super.key, 
    required this.icon,
    this.color,
    this.size
  });
  
  final String icon; 
  final Color? color;
  final double? size ;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      icon, 
      width: size??24, 
      height: size??24,
      color: color??Theme.of(context).colorScheme.onSurface,
    );
  }
}