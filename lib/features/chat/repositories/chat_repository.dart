import 'package:aspectumai/core/network/dio_client.dart';
import 'package:aspectumai/features/chat/models/chat_response_model.dart';
import 'package:dio/dio.dart';

abstract class IChatRepository {
  Future<ChatResponseModel> sendMessage(List<ChatMessageModel> messages);
  Future<void> createChatSession();
  Future<void> deleteChatSession(int sessionId);
  // Future<String> sendMessageWithImage(String message, List<String> imagePaths);
}

class ChatRepository implements IChatRepository {
  final DioClient _dioClient;
  final String _path = 'chat';

  ChatRepository(DioClient dioClient) : _dioClient = dioClient;

  @override
  Future<ChatResponseModel> sendMessage(List<ChatMessageModel> messags) async {
    final response = await _dioClient.post(
      'https://openrouter.ai/api/v1/chat/completions',
      data: {
        'model': 'gpt-4o-mini',
        'messages': messags.map((e) => e.toMap()).toList(),
      },
    );

    if (response.statusCode == 200 && response.data['choices'] != null) {
      return ChatResponseModel.fromMap(response.data['choices'][0]);
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: response.data.toString(),
      );
    }
  }

  @override
  Future<void> createChatSession() async {
    await _dioClient.post('$_path/session/new');
  }

  @override
  Future<void> deleteChatSession(int sessionId) async {
    await _dioClient.delete('$_path/session/$sessionId');
  }
}
