import 'package:breaking/data/models/characters.dart';
import 'package:breaking/data/models/quote.dart';
import 'package:breaking/data/web_servieces/character_web_servieces.dart';

class CharactersRepository {
  final CharacterWebServices characterWebServices;
  CharactersRepository(this.characterWebServices);
  Future<List<Character>> getAllCharacters() async {
    final characters = await characterWebServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getCharacterQuotes(String charName) async {
    final quotes = await characterWebServices.getCharacterQuotes(charName);
    return quotes
        .map((charQuotes) => Quote.fromJson(charQuotes))
        .toList();
  }
}
