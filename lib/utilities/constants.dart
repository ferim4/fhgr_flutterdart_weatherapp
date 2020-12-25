/*
Project for WPFL MAD @FHGR, HS2020
Creators&Authors: Samir Limani, Karin Schori & Florim Rrahmani
Editor used: Visual Studio Code Version: 1.50.1
Tested with: Android Emulator - Pixel 2 API 28 
API used: openweathermap.org
*/

//************************************************
// Import section for needed modules
//************************************************
import "package:flutter/material.dart";

//Got this Idea to seperate some constants in a seperate file from followed blog: https://medium.com/@aschilken/flutter-best-practices-colors-and-textstyles-6e14b06fc3a1
//and also from https://www.driftycode.com/flutter-global-constants-for-the-complete-project/
//last but not least (honestly didn't understand the guy, cause he talked in hindi, but i could reade the code he wrote):
//https://www.youtube.com/watch?v=MaFUT1zpifE
const constant_TextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    //City Icon is here defined for searching a city
    Icons.search,
    color: Colors.black,
    size: 40,
  ),
  hintText: "Search location...",
  hintStyle: TextStyle(color: Colors.black),
  border: OutlineInputBorder(
    //Here can the inputwindow shape be edited
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
    borderSide: BorderSide.none,
  ),
);

//Used for temperature number in location_scree.dart file
const constant_TemperatureTextStyle = TextStyle(
  fontFamily: "Searocks",
  fontSize: 150.0,
);

//Used for message/clothes suggestion in location_scree.dart file
const constant_MessageTextStyle = TextStyle(
  fontFamily: "Searocks",
  fontSize: 60.0,
);

//Used for condition icon in location_scree.dart file
const constant_ConditionTextStyle = TextStyle(
  fontSize: 110.0,
);

//Used for "Get Weather" Button at city_screen.dart file
const constant_ButtonTextStyle = TextStyle(
  fontSize: 60.0,
  fontFamily: "Searocks",
);
