import 'package:dio/dio.dart';
import 'package:dio_http_cache/src/manager_dio.dart';

/// try to get maxAge and maxStale from response headers.
/// local settings will always overview the value get from service.
RequestOptions buildServiceCacheOptions(
        {RequestOptions? options,
        Duration? maxStale,
        String? primaryKey,
        String? subKey,
        bool? forceRefresh}) =>
    buildConfigurableCacheOptions(
        options: options,
        maxStale: maxStale,
        primaryKey: primaryKey,
        subKey: subKey,
        forceRefresh: forceRefresh);

/// build a normal cache options
RequestOptions buildCacheOptions(Duration maxAge,
        {Duration? maxStale,
        String? primaryKey,
        String? subKey,
        RequestOptions? options,
        bool? forceRefresh}) =>
    buildConfigurableCacheOptions(
        maxAge: maxAge,
        options: options,
        primaryKey: primaryKey,
        subKey: subKey,
        maxStale: maxStale,
        forceRefresh: forceRefresh);

/// if null==maxAge, will try to get maxAge and maxStale from response headers.
/// local settings will always overview the value get from service.
RequestOptions buildConfigurableCacheOptions(
    {RequestOptions? options,
    Duration? maxAge,
    Duration? maxStale,
    String? primaryKey,
    String? subKey,
    bool? forceRefresh}) {
  if (null == options) {
    options = RequestOptions(path: "");
  } else if (options.responseType == ResponseType.stream) {
    throw Exception("ResponseType.stream is not supported");
  }
  options.extra.addAll({DIO_CACHE_KEY_TRY_CACHE: true});
  if (null != maxAge) {
    options.extra.addAll({DIO_CACHE_KEY_MAX_AGE: maxAge});
  }
  if (null != maxStale) {
    options.extra.addAll({DIO_CACHE_KEY_MAX_STALE: maxStale});
  }
  if (null != primaryKey) {
    options.extra.addAll({DIO_CACHE_KEY_PRIMARY_KEY: primaryKey});
  }
  if (null != subKey) {
    options.extra.addAll({DIO_CACHE_KEY_SUB_KEY: subKey});
  }
  if (null != forceRefresh) {
    options.extra.addAll({DIO_CACHE_KEY_FORCE_REFRESH: forceRefresh});
  }
  return options;
}
