import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_watchlist_app/screen/home_screen.dart';

import 'bloc/watchlist_bloc.dart';
import 'bloc/watchlist_event.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => WatchlistBloc()..add(LoadWatchlists()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});

@override
Widget build(BuildContext context){
  return MaterialApp(
    title: 'Stocks Watchlist',
    home: HomePage(),
  );
}
}

