import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final baseUrl =
    'https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev';

final dioProvider = Provider((ref) {
  final dio = Dio(BaseOptions(baseUrl: baseUrl));

  dio.interceptors.add(PrettyDioLogger());

  return dio;
});
