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
    - `lib/core/router/` (Routing & Navigation) : Définit les routes et la gestion de    la  navigation.Contient souvent un AppRouter pour organiser les transitions entre les  pages.
    - `lib/core/api/` (Api et requette http) 
    - `lib/core/local_storage/` (Stockage local) : Base de donnée locale avec hive et stockage d'information dans la memoire du téléphone avec flutter_secure_storage et shared_preferences
    - `lib/core/assets.dart` : Definit les chemins d'accès aux fichiers `assets/`
    - `lib/core/language.dart` : Definit les langues supportés par l'application
    - `lib/core/theme.dart` : Definit les thèmes supportés par l'application
    - `lib/core/logger.dart` : Definit du système de journalisation des logs avec la possibilité d'ecouter les erreurs de flutter. Elle est tres importantes car en production nous pouvons envoyer ces erreurs vers Crashlytics ou par email...
    - `lib/core/env.dart` : Definit une methode d'accès centralisé aux variables d'environnement

# Dossiers modules
le dossier `lib/modules/` continent les fonctionnalités de l'application regoupé en package.
Pour chaque fonctionnalité nous utilisons l'architecture hexagonale.

# apres installation de firebase : 
```sh 
    cd ios
    arch -x86_64 pod install
    pod repo update
```
    ou
```sh
    pod install --repo-update
```
