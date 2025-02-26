# template

# Internationalisation
L'app propose actuellement deux langues le français et l'anglais.
La comande suivante permet de convertir les fichiers .arb (dans le dossier `lib/l10n/`):
```sh
flutter gen-l10n
```

`.dart_tool\flutter_gen\gen_l10n` contient les fichiers de traductions des languges supportées par l'application.

Veuillez noter que vous ne devez pas modifier ces fichiers manuellement car ils seront recompilés à chaque fois que la commande flutter gen-l10n sera exécutée.

# Dossiers partagés
le dossier `lib/shared/` contient les fichiers partagés dans toute l'application
    - `lib/shared/models/` contient les models partagès
    - `lib/shared/utilities/` contient les utiltaires partagès
    - `lib/shared/widgets/` contient les composants partagès

# Dossier core
le dossier `lib/core/` sert à centraliser les éléments transversaux (ou "cross-cutting concerns"). Il contient du code qui n'est pas directement lié à une fonctionnalité spécifique, mais qui est utilisé dans plusieurs parties de l'application.
    - `lib/core/di.dart` (Dépendance Injection) : Gère l'injection de dépendances.
        Centralise la création et l'initialisation des services.
    - `lib/core/router.dart` (Routing & Navigation) : Définit les routes et la gestion de    la  navigation.Contient souvent un AppRouter pour organiser les transitions entre les  pages.
    - `lib/core/api.dart` ()
