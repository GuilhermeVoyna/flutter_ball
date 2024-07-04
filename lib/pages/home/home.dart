import 'package:flutter/material.dart';
import 'package:flutter_ball/model/emotion.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int ballDivisionCount = 2;

  List<EmotionModel> emotions = [];
  List <Color> clickedEmotionsColors = [];
  String selectedEmotion = '';

  void _getEmotions() {
    setState(() {
      emotions = EmotionModel.getEmotions();
    });
  }

  void _handleItemClick(int index) {
    print('Item ${emotions[index].name} clicked!');
  setState(() {
    clickedEmotionsColors.insert(0, emotions[index].boxColor);
    selectedEmotion = emotions[index].name;
  });
}


  @override
  void initState() {
    super.initState();
    _getEmotions();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baller'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _myBall(),
            const SizedBox(
              height: 10,
            ),
            _categoriesSection(),
            const SizedBox(
              height: 10,
            ),
           Column(
children: [
  
  Text(
    clickedEmotionsColors.isEmpty ? 'No emotions clicked yet' : 'Clicked Emotions:',
    style: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold
      ),
  ),
  const SizedBox(height: 10),
  Container(
    decoration: BoxDecoration(
      color: clickedEmotionsColors.isEmpty ? Colors.grey.withOpacity(0.0) : clickedEmotionsColors[0].withOpacity(0.8),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        selectedEmotion,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w900,
          ),
      ),
    ),
  ),
],
)
          ],
        ),
      ),
    );
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Category',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15,),
        SizedBox(
          height: 120,
          child: 
ListView.separated(
  itemCount: emotions.length,
  scrollDirection: Axis.horizontal,
  padding: const EdgeInsets.only(left: 20, right: 20),
  separatorBuilder: (context, index) => const SizedBox(width: 25),
  itemBuilder: (context, index) {
    return GestureDetector(
      onTap: () {
        // Handle item click event:
        // - Navigate to a new screen
        // - Show a dialog
        // - Perform any other action based on emotions[index]
        _handleItemClick(index);
        //make a list off all the emotions that have been clicked
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: emotions[index].boxColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      emotions[index].bottlePath,
                      fit: BoxFit.contain,
                      placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      emotions[index].potionPath,
                      fit: BoxFit.contain,
                      color: emotions[index].boxColor,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              emotions[index].name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  },
)
  ),
],
    );
  }
SizedBox _myBall() {
  return SizedBox(
    height: 500,
    child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 5),
          child: Text(
            'MOOD',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: clickedEmotionsColors.isNotEmpty ? clickedEmotionsColors : [Colors.grey, Colors.white],
                    stops: _calculateStops(clickedEmotionsColors.length),
                    center: Alignment.topCenter, // Mudado para bottomCenter
                    radius: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                left: 50,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

List<double> _calculateStops(int count) {
  // Gera stops baseados na quantidade de cores
  if (count <= 1) return [0.5];
  double step = 1.0 / (count - 1);
  return List<double>.generate(count, (index) => step * index);
}
}