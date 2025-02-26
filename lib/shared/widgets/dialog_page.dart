import 'package:flutter/material.dart';

/// Page contenant pour afficher des dialogues
/// En utilisant le systeme de routage go-router
class DialogPage<T> extends Page<T> {
  //
  /// Permet de savoir si le dialog doit être fermé
  /// lorsqu'on clique sur la barrière
  final bool barrierDismissible;

  /// Ce padding permet de gérer la marge entre le contenu du dialog
  /// et cotés(bas/haut/gauche/droite) du devise
  final EdgeInsets insetPadding;

  /// Avec se shape nous pouvons agir sur le style de la bordure
  final ShapeBorder shape;

  /// Positionner du dialog
  final AlignmentGeometry alignment;

  /// Contenu du dialog
  /// Ce contenu ne doit pas etre dans un Scafold(body),
  /// vous pouvez directement dans page retourner le widget à afficher.
  final WidgetBuilder builder;

  /// Constructeur
  const DialogPage({
    required this.builder,
    this.barrierDismissible = true,
    this.insetPadding = const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 00.0),
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(15.0),
        topLeft: Radius.circular(15.0),
      ),
    ),
    this.alignment = Alignment.bottomCenter,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    //
    return DialogRoute<T>(
      context: context,
      settings: this,
      builder: (context) => Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        // Dialog padding
        insetPadding: insetPadding,
        //
        alignment: alignment,
        //
        shape: shape,
        //
        child: builder(context),
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}