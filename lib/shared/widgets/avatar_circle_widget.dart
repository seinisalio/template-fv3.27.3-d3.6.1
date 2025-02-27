import 'package:flutter/material.dart';

class AvatarCircleWidget extends StatelessWidget {
  ///
  const AvatarCircleWidget({
    super.key,
    required this.nom,
    this.photo,
    this.radius,
    required this.rounded,
  });

  final String nom;
  final String? photo;
  final double? radius;
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(r'^https?://');
    if (photo != null) {
      if(regex.hasMatch(photo!)){
        return CircleAvatar(
          backgroundImage: NetworkImage(photo!),
          radius: radius ?? 22,
        );
      }
      return CircleAvatar(
        backgroundImage: AssetImage(photo!),
        radius: radius ?? 22,
      );
    } //
    else {
      return CircleAvatar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        radius: radius ?? 22,
        child: Text(
          getInitials(nom),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      );
    }
  }

  String getInitials(String fullName) {
    List<String> names = fullName.split(" ");

    if(fullName.isEmpty){
      return "#";
    }

    if (names.isNotEmpty) {
      String initials = "";
      // Prend la première lettre de chaque mot dans le nom
      initials += names[0][0].toUpperCase();

      if (names.length > 1) {
        // Ajoute la première lettre du dernier mot si le nom a plus d'un mot
        initials += names.last[0].toUpperCase();
      }
      return initials;
    }
    else{
      return "#";
    }
  }
}
