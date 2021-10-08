import 'package:flutter/services.dart';

import 'resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'stores/genre_store.dart';
import 'stores/movie_details_store.dart';
import 'ui/screens/home_screen.dart';

void main() {
  initializeDateFormatting('pt_BR', null);
  GetIt.I.registerSingleton(GenreStore());
  GetIt.I.registerSingleton(MovieDetailsStore());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(AppRoot());
}

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        backgroundColor: AppColors.primaryColor,
        accentColor: AppColors.accentColor,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
    );
  }
}
