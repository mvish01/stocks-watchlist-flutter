# stocks_watchlist_app

# 📈 Stocks Watchlist App (Flutter + BLoC)

A Flutter-based watchlist application that allows users to:
- View multiple watchlists
- Reorder stocks using drag-and-drop
- Delete stocks
- Maintain state using BLoC architecture

---

## 🚀 Features

- 📊 Multiple watchlists (Tab-based)
- 🔄 Reorder stocks (ReorderableListView)
- ❌ Delete stocks
- 🎯 Clean UI inspired by trading apps
- 🧠 State management using BLoC
- 💾 Local in-memory data (no APIs)

---

## 🏗️ Architecture

This project follows **BLoC Architecture**:
lib/
├── bloc/
│ ├── watchlist_bloc.dart
│ ├── watchlist_event.dart
│ ├── watchlist_state.dart
│
├── model/
│ └── stock.dart
│
├── screens/
│ ├── home_page.dart
│ └── edit_watchlist_screen.dart
│
└── main.dart


---

## 🔄 State Management

- `WatchlistBloc` handles:
  - LoadWatchlists
  - ChangeTab
  - ReorderStocks
  - DeleteStock

---

## 🎯 Key Implementation Details

### 🔹 Reordering
- Implemented using `ReorderableListView`
- Used `ReorderableDragStartListener` for better UX
- Disabled default drag handles

### 🔹 Data Structure
- Watchlists stored as:
```dart
Map<int, List<Stock>>

🔹 UI
Custom stock tile
Dynamic price coloring (green/red)
Pixel-aligned UI based on trading apps
