 import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AppStates
{
  const AppStates();
}

class InitialAppState extends AppStates {}
 class AppChangeBottomNavBaeState extends AppStates {}

