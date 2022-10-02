import 'package:breaking/buisness_logic/cubit/character_cubit.dart';
import 'package:breaking/constants/strings.dart';
import 'package:breaking/data/models/characters.dart';
import 'package:breaking/data/repository/characters_repository.dart';
import 'package:breaking/data/web_servieces/character_web_servieces.dart';
import 'package:breaking/presentation/screens/character_details.dart';
import 'package:breaking/presentation/screens/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharacterCubit characterCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(CharacterWebServices());
    characterCubit = CharacterCubit(charactersRepository);
  }
  Route? genrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => characterCubit,
            child: CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_)=>CharacterCubit(charactersRepository),
              child: CharacterDetailsScreen(
                    character: character,
                  ),
            ));
    }
  }
}
