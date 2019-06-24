import 'package:cardholder/types/lobby.dart';
import 'package:cardholder/types/player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Player:', () {
    test('Player to Json', () {
      var player = Player(1, 'Testname', 'leader', 5);
      var matcherMap = {'id': 1, 'name': 'Testname', 'role': 'leader', 'card_amount': 5};

      expect(player.toJson(), matcherMap);
    });
    test('Json to Player', () {
      var jsonMap = {'id': 3, 'name': 'Username', 'role': 'player', 'card_amount': 4};
      var matcher = Player(3, 'Username', 'player', 4);
      var player = Player.fromJson(jsonMap);

      expect(player.id, matcher.id);
      expect(player.name, matcher.name);
      expect(player.role, matcher.role);
    });
  });
  group('Lobby:', () {
    test('Lobby to Json', () {
      var lobby = Lobby('JKhdaD', 'Skat', 'public', 6, null);
      var matcherMap = {'id': 'JKhdaD', 'game': 'Skat', 'visibility': 'public', 'max_players': 6, 'players': null};

      expect(lobby.toJson(), matcherMap);
    });
    test('Json to Lobby', () {
      var jsonMap = {'id': 'DgdAbs', 'game': 'Mau-Mau', 'visibility': 'private', 'max_players': 4, 'players': null};
      var matcher = Lobby('DgdAbs', 'Mau-Mau', 'private', 4, null);
      var lobby = Lobby.fromJson(jsonMap);

      expect(lobby.id, matcher.id);
      expect(lobby.game, matcher.game);
      expect(lobby.visibility, matcher.visibility);
      expect(lobby.maxPlayers, matcher.maxPlayers);
      expect(lobby.players, matcher.players);
    });
  });
}
