import 'dart:async';
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'secure_storage.dart';

class AppDatabase {

  /// DO NOT STORE A KEY WITH THIS NAME IN SECURE STORAGE
  static const String _keyId = "DEK";

  /// The Data Encryption Key
  static late HiveAesCipher _dek;

  /// Opened Collections
  /// By default, the entire content of a box is stored in memory
  ///  as soon as it is opened.
  /// This behavior is great for small and medium-sized boxes
  ///  because you can access their contents without async calls.
  /// For larger boxes or very memory critical applications,
  ///  it may be useful to load values lazily.
  /// When a lazy box is opened, all of its keys are read and stored in memory.
  /// Once you access a value, Hive knows its exact position on the disk
  /// and gets the value.
  static Map<String, Box<Map<dynamic, dynamic>>> collections = {};

  /// Init Storage Params
  static Future<void> init() async {
    await Hive.initFlutter();
    // Create the data encryption key if not exist
    var containsEncryptionKey = await AppSecureStorage.isKeyExist(_keyId);
    if (!containsEncryptionKey) {
      var key = Hive.generateSecureKey();
      await AppSecureStorage.set(_keyId,base64UrlEncode(key));
      _dek = HiveAesCipher(key);
    }
    // Fetch the data encryption key if exist
    else {
      String? keyString = await AppSecureStorage.get(_keyId);
      var key = base64Url.decode(keyString!);
      _dek = HiveAesCipher(key);
    }
  }

  /// Retrieve data collection
  static Future<Box<Map<dynamic, dynamic>>> _collection(
      String collectionId) async {
    if (collections.containsKey(collectionId)) {
      return Future.delayed(Duration.zero, () => collections[collectionId]!);
    } else {
      Box<Map<dynamic, dynamic>> box =
          await Hive.openBox(collectionId, encryptionCipher: _dek);
      collections[collectionId] = box;
      return box;
    }
  }

  /// Retrieve list of datas
  static Future<List<T>> list<T>(
    String collectionId,
    Function(Map<dynamic, dynamic>) fromJson,
    // required Function(T) toJson,
  ) async {
    //
    Box<Map<dynamic, dynamic>> collection =
        await AppDatabase._collection(collectionId);

    if (collection.length == 0) return [];

    // Récuperer les elements
    return collection.values
        .map((Map<dynamic, dynamic> e) => fromJson(e) as T)
        .toList();
  }

  /// Retrieve data
  static Future<T?> get<T>(
    String collectionId,
    String? itemid,
    Function(Map<dynamic, dynamic>) fromJson,
  ) async {
    //
    Box<Map<dynamic, dynamic>> collection =
        await AppDatabase._collection(collectionId);

    Map<dynamic, dynamic>? item = collection.get(itemid);
    if (item != null) {
      return fromJson(item) as T;
    } else {
      return null;
    }
  }

  /// Stream list of datas
  static Future<Stream<List<T>>> streamList<T>(
    String collectionId,
    T Function(Map<dynamic, dynamic>) fromJson,
  ) async {
    //
    Box<Map<dynamic, dynamic>> box = await AppDatabase._collection(collectionId);

    return box.watch().map<List<T>>((events) {
      return box.values.map((Map<dynamic, dynamic> e) => fromJson(e)).toList();
    });
  }

  /// Stream data item
  static Future<Stream<T>> streamItem<T>(
    String collectionId,
    String? itemid,
    Function(Map<dynamic, dynamic>) fromJson,
  ) async {
    //
    Box<Map<dynamic, dynamic>> box = await AppDatabase._collection(collectionId);

    Stream<BoxEvent> boxEvents = box.watch(key: itemid);
    return boxEvents.map((BoxEvent e) {
      return fromJson(e.value as Map<dynamic, dynamic>) as T;
    }).cast<T>();
  }

  /// Save a data in the collection
  static Future<void> save(
    String collectionId,
    String id,
    Map<dynamic, dynamic> data,
  ) async {
    //
    Box<Map<dynamic, dynamic>> collection =
        await AppDatabase._collection(collectionId);
    await collection.put(id, data);
  }

  static Future<void> saveList<T>(
    String collectionId,
    String id,
    List<Map<dynamic, dynamic>> items,
  ) async {
    //
    Box<Map<dynamic, dynamic>> collection =
        await AppDatabase._collection(collectionId);
    for (var item in items) {
      collection.put(item[id], item);
    }
  }

  /// Delete a data from the collection
  static Future<void> delete(
    String collectionId,
    String id,
  ) async {
    //
    Box<Map<dynamic, dynamic>> collection =
        await AppDatabase._collection(collectionId);
    await collection.delete(id);
  }

  /// Partial updates
  static Future<void> patch(
    String collectionId,
    String id,
    Map<dynamic, dynamic> data,
  ) async {
    //
    Box<Map<dynamic, dynamic>> collection =
        await AppDatabase._collection(collectionId);
    Map<dynamic, dynamic>? old = collection.get(id);
    if (old != null) {
      // Fusionner les données existantes avec les nouvelles données
      // Map<dynamic, dynamic> updatedData = {...old, ...data};
      Map<dynamic, dynamic> updatedData = Map.from(data);
      updatedData.addAll(old);
      // Mettre à jour l'élément dans la base
      await collection.put(id, updatedData);
    } else {
      await collection.put(id, data);
    }
  }

  /// All updates
  static Future<void> merge(
    String collectionId,
    String id,
    Map<dynamic, dynamic> newData,
  ) async {
    // Récupère ou initialise la collection
    final Box<Map<dynamic, dynamic>> collection = 
        await AppDatabase._collection(collectionId);

    // Récupère l'ancien élément ou crée un nouveau map vide
    final Map<dynamic, dynamic> oldData = collection.get(id) ?? {};

    // Fusionner les nouvelles données dans l'ancien
    newData.forEach((key, value) {
      // Met à jour ou ajoute la clé/valeur
      if(value != null) oldData[key] = value; 
    });

    // Mettre à jour l'élément dans la base
    await collection.put(id, oldData);
  }
}
