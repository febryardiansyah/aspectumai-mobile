import 'package:aspectumai/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late DioClient dioClient;

  setUp(() {
    mockDio = MockDio();
    dioClient = DioClient(dio: mockDio, isUnittest: true);
  });

  group('DioClient', () {
    final response = Response(
      requestOptions: RequestOptions(path: '/test'),
      statusCode: 200,
    );

    test('get method should make a GET request', () async {
      when(
        () => mockDio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => response);

      final result = await dioClient.get('/test');

      expect(result.statusCode, 200);
      verify(
        () => mockDio.get(
          '/test',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);
    });

    test('post method should make a POST request', () async {
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => response);

      final result = await dioClient.post('/test', data: {'key': 'value'});

      expect(result.statusCode, 200);
      verify(() => mockDio.post('/test', data: {'key': 'value'})).called(1);
    });

    test('put method should make a PUT request', () async {
      when(
        () => mockDio.put(
          any(),
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => response);

      final result = await dioClient.put('/test', data: {'key': 'value'});

      expect(result.statusCode, 200);
      verify(() => mockDio.put('/test', data: {'key': 'value'})).called(1);
    });

    test('delete method should make a DELETE request', () async {
      when(
        () => mockDio.delete(
          any(),
          data: any(named: 'data'),
        ),
      ).thenAnswer((_) async => response);

      final result = await dioClient.delete('/test', data: {'key': 'value'});

      expect(result.statusCode, 200);
      verify(() => mockDio.delete('/test', data: {'key': 'value'})).called(1);
    });
  });
}
