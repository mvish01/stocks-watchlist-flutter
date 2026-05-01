import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_watchlist_app/bloc/watchlist_bloc.dart';

import '../bloc/watchlist_event.dart';
import '../bloc/watchlist_state.dart';
import '../model/stock.dart';
import 'edit_watchlist_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late WatchlistBloc watchlistBloc;

  @override
  Widget build(BuildContext context){
    watchlistBloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "SENSEX 18TH SEP 8...",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "1,225.55  +44.50 (1.33%)",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
              ),

              Container(width: 1, height: 30, color: Colors.grey.shade300),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "NIFTY BANK",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "54,174.45  -12.45 (-0.02%)",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),

              const Icon(Icons.chevron_right, size: 18),
            ],
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, size: 18, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      "Search for instruments",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            TabBar(
              onTap: (index) {
                context.read<WatchlistBloc>().add(ChangeTab(index));
              },
              tabs: const [
                Tab(text: "Watchlist 1"),
                Tab(text: "Watchlist 2"),
                Tab(text: "Watchlist 3"),
              ],
            ),

            Expanded(
              child: BlocBuilder<WatchlistBloc, WatchlistState>(
                builder: (context, state) {
                  final stocks =
                      state.watchlists[state.selectedTab] ?? [];

                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<WatchlistBloc>(),
                                    child: const EditWatchlistScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.tune, size: 16, color: Colors.black87),
                                  SizedBox(width: 6),
                                  Text(
                                    "Sort by",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            )
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: stocks.length,
                          separatorBuilder: (_, __) => Divider(height: 1),
                          itemBuilder: (_, i) {
                            return stockItem(stocks[i]);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            BottomNavItem(icon: Icons.bookmark_border, label: "Watchlist", active: true),
            BottomNavItem(icon: Icons.shopping_cart_outlined, label: "Orders"),
            BottomNavItem(icon: Icons.flash_on_outlined, label: "GTT"),
            BottomNavItem(icon: Icons.work_outline, label: "Portfolio"),
            BottomNavItem(icon: Icons.account_balance_wallet_outlined, label: "Funds"),
            BottomNavItem(icon: Icons.person_outline, label: "Profile"),
          ],
        ),
      ),
    );
  }

  Widget stockItem(Stock stock) {
    final isPositive = stock.change >= 0;

    final color = isPositive ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// LEFT SIDE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stock.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                stock.exchange,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          /// RIGHT SIDE
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                stock.price.toStringAsFixed(2),
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${stock.change.toStringAsFixed(2)} (${stock.percent.toStringAsFixed(2)}%)",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}


class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20,
          color: active ? Colors.black : Colors.grey,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: active ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }
}