import 'package:flutter/material.dart';

import '../../core/theme.dart';

class CustomDot extends StatelessWidget {

  const CustomDot({
    super.key, 
    this.dimension = 15.0,
    this.dotDimension = 5.0,
    this.value = false
  });
  
  final double dimension; 
  final double dotDimension ;
  final bool value ;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: dimension,
      height: dimension,
      decoration: ShapeDecoration(
        color: value ? Theme.of(context).primaryColor : Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: value 
              ? Theme.of(context).primaryColor 
              : AppTheme.neural03Color,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Container(
        width: dotDimension,
        height: dotDimension,
        decoration: ShapeDecoration(
          color: value 
          ? AppTheme.whiteColor : 
          Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}