import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking/buisness_logic/cubit/character_cubit.dart';
import 'package:breaking/constants/my_colors.dart';
import 'package:breaking/data/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColor.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin:
                      EdgeInsets.only(top: 14, bottom: 0, left: 14, right: 14),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Job : ', character.jobs.join(' / ')),
                      buildDivider(315),
                      characterInfo(
                          'Appeared in : ', character.categoryForTwoSeries),
                      buildDivider(250),
                      character.appearanceInSeasons.isEmpty
                          ? Container()
                          : characterInfo('Seasons : ',
                              character.appearanceInSeasons.join(' / ')),
                      character.appearanceInSeasons.isEmpty
                          ? Container()
                          : buildDivider(280),
                      characterInfo('Status : ', character.statusIfDeadOrAlive),
                      buildDivider(300),
                      character.betterCallSaulAppearanse.isEmpty
                          ? Container()
                          : characterInfo('Better call saul seasons : ',
                              character.betterCallSaulAppearanse.join(' / ')),
                      character.betterCallSaulAppearanse.isEmpty
                          ? Container()
                          : buildDivider(150),
                      characterInfo('Actor/Actress : ', character.actorName),
                      buildDivider(235),
                      SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CharacterCubit, CharacterState>(
                          builder: (context, state) {
                        return checkQuotesAreLoaded(state);
                      })
                    ],
                  ),
                ),
                SizedBox(
                  height: 700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColor.myYellow,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: true,
        title: Text(
          character.nickName,
          style: TextStyle(color: MyColor.myWhite),
          // textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColor.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColor.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColor.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget checkQuotesAreLoaded(CharacterState state) {
    if (state is QuotesLoaded) {
      return displayRandimQuotesOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandimQuotesOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: MyColor.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColor.myYellow,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    }
    else{
      return Container();
    }
  }
  Widget showProgressIndicator(){
    return Center(
      child: CircularProgressIndicator(color: MyColor.myYellow,),
    );
  }
}
