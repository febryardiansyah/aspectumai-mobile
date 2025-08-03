class ChatResponseModel {
  final int? index;
  final ChatMessageModel? message;
  final String? finishReason;
  final dynamic logprobs;

  const ChatResponseModel({
    this.index,
    this.message,
    this.finishReason,
    this.logprobs,
  });

  factory ChatResponseModel.fromMap(Map<String, dynamic> map) {
    return ChatResponseModel(
      index: map['index'],
      message: map['message'] != null ? ChatMessageModel.fromMap(map['message']) : null,
      finishReason: map['finish_reason'],
      logprobs: map['logprobs'],
    );
  }
}

class ChatMessageModel {
  final String? role;
  final String? content;
  final dynamic refusal;

  const ChatMessageModel({
    this.role,
    this.content,
    this.refusal,
  });

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      role: map['role'],
      content: map['content'],
      refusal: map['refusal'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'content': content,
      if (refusal != null) 'refusal': refusal,
    };
  }
}
