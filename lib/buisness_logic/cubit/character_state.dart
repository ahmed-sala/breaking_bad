part of 'character_cubit.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharactersLoaded extends CharacterState{
  final List<Character>characters;
  CharactersLoaded(this.characters);
}
class QuotesLoaded extends CharacterState{
  final List<Quote>quotes;
  QuotesLoaded(this.quotes);
}

