import 'package:bloc/bloc.dart';
import 'package:breaking/data/models/characters.dart';
import 'package:breaking/data/models/quote.dart';
import 'package:breaking/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];
  CharacterCubit(this.charactersRepository) : super(CharacterInitial());
  List<Character> getAllCharacter() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuotes(String charName) {
    charactersRepository.getCharacterQuotes(charName).then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }
}
