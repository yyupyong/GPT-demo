import 'package:chat_app/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/chat_model.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenChatModel}) async {
    chatList.addAll(
        await ApiService.sendMessage(message: msg, modelId: chosenChatModel));
    notifyListeners();
  }
}

// 状態管理をriverpodに移行

List chatList = [];

class ChatNotifier extends StateNotifier {
  ChatNotifier() : super([]);

  void addUserMessage({required String msg}) {
    state = [...state, ChatModel(msg: msg, chatIndex: 0)];
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenChatModel}) async {
    state = [
      ...state,
      ...(await ApiService.sendMessage(message: msg, modelId: chosenChatModel))
    ];
  }
}
