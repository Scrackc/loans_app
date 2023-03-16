import 'package:flutter_cache_manager/flutter_cache_manager.dart';

final cacheManager = CacheManager(
  Config(
    'myAppCache',
    maxNrOfCacheObjects: 100,
    stalePeriod: const Duration(days: 3),
  ),
);
