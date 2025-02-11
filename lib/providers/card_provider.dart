import 'package:flutter/material.dart';
import 'package:frontend/models/card.dart';
import 'package:frontend/models/transaction.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/services/cards.dart';

class VCardsProvider extends ChangeNotifier {
  List<VCard> cards = [];
  List<Transaction> transactions = [];
  List<Transaction> allTransactions = [];

  Future<List<VCard>> getVCards() async {
    // print("getting cards");
    // print(cards[0].isExpired);
    if (cards.isEmpty) {
      try {
        await AuthProvider().initAuth();
        cards = await DioClient().getVCards();
        // print(cards[0].name);
        // print(cards[0].expiryDate);
      } on Exception catch (_) {
        rethrow;
      }
      if (cards.isEmpty) throw("No Cards");
    }
    return cards;
  }

  Future<void> createVCard(VCard card) async {
    VCard newVCard = await DioClient().createVCard(card: card);
    cards.add(newVCard);
    notifyListeners();
  }

  Future<void> updateVCard(VCard card) async {
    VCard newVCard = await DioClient().updateVCard(card: card);
    int index = cards.indexWhere((card) => card.id == newVCard.id);
    cards[index] = newVCard;
    notifyListeners();
  }

  Future<void> deleteVCard(String cardId) async {
    await DioClient().deleteVCard(cardId: cardId);
    cards.removeWhere((card) => card.id == cardId);
    notifyListeners();
  }

  Future<void> updateStatus() async {
    await DioClient().updateStatus();
    notifyListeners();
  }

  Future<List<Transaction>> getTransactions({required VCard card}) async {
    // print("getting cards");
    // print(cards[0].isExpired);
    try {
      // await AuthProvider().initAuth();
      transactions = await DioClient().getTransactions(card);
      // print(transactions[0].category);
      // print(cards[0].name);
      // print(cards[0].expiryDate);
    } on Exception catch (_) {
      rethrow;
    }
    if (transactions.isEmpty) throw("No transactions");

    return transactions;
  }

  Future<List<Transaction>> getAllTransactions() async {
    // print("getting cards");
    // print(cards[0].isExpired);
    try {
      // await AuthProvider().initAuth();
      allTransactions = await DioClient().getAllTransactions();
      // print(transactions[0].category);
      // print(cards[0].name);
      // print(cards[0].expiryDate);
    } on Exception catch (_) {
      rethrow;
    }
    if (transactions.isEmpty) throw("No transactions");

    return transactions;
  }

  void clear() {
    cards = [];
    transactions = [];
  }
}