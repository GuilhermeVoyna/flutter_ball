import 'package:flutter/material.dart';

class EmotionModel {
  String name;
  String potionPath;
  String bottlePath;
  Color boxColor;

  EmotionModel({
    required this.name,
    this.potionPath = 'assets/icons/potion-color.svg',
    this.bottlePath= 'assets/icons/bottle.svg',
    required this.boxColor,
  });
  
 static List<EmotionModel> getEmotions() {
    List<EmotionModel> emotions = [];
    
    emotions.add(
      EmotionModel(
        name: 'happy',
        boxColor: Color.fromARGB(255, 255, 249, 158)
      )
    );

    emotions.add(
      EmotionModel(
        name: 'Sad',
        boxColor: Color.fromARGB(255, 164, 169, 238)
      )
    );

    emotions.add(
      EmotionModel(
        name: 'Angry',
        boxColor: Color.fromARGB(255, 252, 82, 82)
      )
    );

    emotions.add(
      EmotionModel(
        name: 'Fear',
        boxColor: Color.fromARGB(255, 244, 128, 255)
      )
    );

    emotions.add(
      EmotionModel(
        name: 'Disgust',
        boxColor: Color.fromARGB(255, 98, 238, 117)
      )
    );

    emotions.add(
      EmotionModel(
        name: 'Anxious',
        boxColor: Color.fromARGB(255, 255, 159, 128)
      )
    );

    return emotions;
  }
}