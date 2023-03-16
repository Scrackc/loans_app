import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:loan_app/utils/cache_instance.dart';

class CrudCacheService<T> {
  final CacheManager _cacheManager = cacheManager;
  final T Function(Map<String, dynamic>) fromJson;

  CrudCacheService({required this.fromJson});

  Future<List<T>> getAll(String key) async {
    final file = await _cacheManager.getFileFromCache(key);
    if (file != null && file.validTill.isAfter(DateTime.now())) {
      final stringData = await file.file.readAsString();
      final list = json.decode(stringData) as List;
      return list.map((e) => fromJson(e)).toList();
    }
    return [];
  }

  Future<void> addList(List<T> items, String key, Duration maxAge) async {
    final encodedJsonList = json.encode(items);
    final encodeList = Uint8List.fromList(utf8.encode(encodedJsonList));
    await _cacheManager.putFile(
      key,
      encodeList,
      maxAge: maxAge,
    );
  }

  Future<void> add(T item, String key, Duration maxAge) async {
    final encodedJsonList = json.encode(item);
    final encodeList = Uint8List.fromList(utf8.encode(encodedJsonList));
    await _cacheManager.putFile(
      key,
      encodeList,
      maxAge: maxAge,
    );
  }

  Future<T?> getOne(String key) async {
    final file = await _cacheManager.getFileFromCache(key);
    if (file != null && file.validTill.isAfter(DateTime.now())) {
      final stringData = await file.file.readAsString();
      final list = json.decode(stringData);
      return fromJson(list);
    }
    return null;
  }

  // Future<void> add(T item) async {
  //   final list = await getAll();
  //   list.add(item);
  //   final json = jsonEncode(list);
  //   await _cacheManager.putFile(_key, Uint8List.fromList(utf8.encode(json)));
  // }

  // Future<void> update(int id, T newItem) async {
  //   final list = await getAll();
  //   final index = list.indexWhere((item) => item.id == id);
  //   if (index != -1) {
  //     list[index] = newItem;
  //     final json = jsonEncode(list);
  //     await _cacheManager.putFile(_key, json);
  //   }
  // }

  // Future<void> delete(int id) async {
  //   final list = await getAll();
  //   final index = list.indexWhere((item) => item.id == id);
  //   if (index != -1) {
  //     list.removeAt(index);
  //     final json = jsonEncode(list);
  //     await _cacheManager.putFile(_key, json);
  //   }
  // }

  // T _fromJson(Map<String, dynamic> json);

  // Map<String, dynamic> _toJson(T item);
}
