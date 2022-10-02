import 'package:breaking/buisness_logic/cubit/character_cubit.dart';
import 'package:breaking/constants/my_colors.dart';
import 'package:breaking/data/models/characters.dart';
import 'package:breaking/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacter;
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharacterCubit>(context).getAllCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColor.myYellow,
          title: _isSearching ? _buildSearchFeild() : _buildAppBarTitle(),
          actions: _buildAppBarActions(),
          leading: _isSearching
              ? BackButton(
                  color: MyColor.myGrey,
                )
              : Container(),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return buildBlocWidget();
            } else {
              return buildNoInternetWidget();
            }
          },
          child: showLoadingIndicator(),
        )

        // buildBlocWidget(),
        );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(builder: (_, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedCharacters();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget buildLoadedCharacters() {
    return SingleChildScrollView(
      child: Container(
        color: MyColor.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacter.length,
      itemBuilder: (_, index) {
        return CharacterItem(
          character: _searchController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacter[index],
        );
      },
    );
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColor.myYellow,
      ),
    );
  }

  Widget _buildSearchFeild() {
    return TextField(
      controller: _searchController,
      cursorColor: MyColor.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a character......',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColor.myGrey,
          fontSize: 18,
        ),
      ),
      style: TextStyle(
        color: MyColor.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter) {
        _addSearchedCharacterToList(searchedCharacter);
      },
    );
  }

  void _addSearchedCharacterToList(String searchedCharacter) {
    searchedForCharacter = allCharacters
        .where(
          (character) =>
              character.name.toLowerCase().contains(searchedCharacter),
        )
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: MyColor.myGrey,
            )),
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearching,
            icon: Icon(
              Icons.search,
              color: MyColor.myGrey,
            )),
      ];
    }
  }

  void _startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
    });
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(
        color: MyColor.myGrey,
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'can\'t connect .. check internet',
              style: TextStyle(fontSize: 22, color: MyColor.myGrey),
            ),
            Image.asset('assets/images/no_internet.png'),
          ],
        ),
      ),
    );
  }
}
