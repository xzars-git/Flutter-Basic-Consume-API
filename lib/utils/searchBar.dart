import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// void searchBar()
// Widget _buildSearchField() {
//     return TextField(
//       controller: _searchQueryController,
//       autofocus: true,
//       decoration: InputDecoration(
//         hintText: "Search Data...",
//         border: InputBorder.none,
//         hintStyle: TextStyle(color: Colors.white30),
//       ),
//       style: TextStyle(color: Colors.white, fontSize: 16.0),
//       onChanged: (query) => updateSearchQuery(query),
//     );
//   }

//   List<Widget> _buildActions() {
//     if (_isSearching) {
//       return <Widget>[
//         IconButton(
//           icon: const Icon(Icons.clear),
//           onPressed: () {
//             if (_searchQueryController == null ||
//                 _searchQueryController.text.isEmpty) {
//               Navigator.pop(context);
//               return;
//             }
//             _clearSearchQuery();
//           },
//         ),
//       ];
//     }

//     return <Widget>[
//       IconButton(
//         icon: const Icon(Icons.search),
//         onPressed: _startSearch,
//       ),
//     ];
//   }

//   void _startSearch() {
//     ModalRoute.of(context)
//         .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

//     setState(() {
//       _isSearching = true;
//     });
//   }

//   void updateSearchQuery(String newQuery) {
//     setState(() {
//       searchQuery = newQuery;
//     });
//   }

//   void _stopSearching() {
//     _clearSearchQuery();

//     setState(() {
//       _isSearching = false;
//     });
//   }

//   void _clearSearchQuery() {
//     setState(() {
//       _searchQueryController.clear();
//       updateSearchQuery("");
//     });
//   }