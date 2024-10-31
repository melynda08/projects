import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, String> data = {};
  int boardSize = 3;
  String currentPlayer = 'X';
  bool gameover = false;
  List<String> winningCells = []; // Store winning cells for coloring

  void init_game_data() {
    data = {};
    gameover = false;
    currentPlayer = 'X';
    winningCells = []; // Reset winning cells
    for (int r = 0; r < boardSize; r++) {
      for (int c = 0; c < boardSize; c++) {
        data[r.toString() + "x" + c.toString()] = '';
      }
    }
  }

  @override
  void initState() {
    init_game_data();
    super.initState();
  }

  List<List<String>> possible_wins = [
    ['0x0', '0x1', '0x2'],
    ['1x0', '1x1', '1x2'],
    ['2x0', '2x1', '2x2'],
    ['0x0', '1x0', '2x0'],
    ['0x1', '1x1', '2x1'],
    ['0x2', '1x2', '2x2'],
    ['0x0', '1x1', '2x2'],
    ['0x2', '1x1', '2x0'],
  ];

  bool isWin() {
    for (var line in possible_wins) {
      var result = '';
      for (var cell in line) {
        result = result + data[cell]!;
      }
      if (result == 'XXX' || result == 'OOO') {
        winningCells = line; // Store the winning cells
        gameover = true;
        return true;
      }
    }
    return false;
  }

  bool isDraw() {
    if (!gameover) {
      // Check if all cells are filled
      return data.values.every((value) => value.isNotEmpty);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tic Tac Toe')),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              if (gameover) ...[
  Text(
    isDraw()
        ? 'Game Over, It\'s a Draw!'
        : 'Game Over, Congrats to Player $currentPlayer',
    style: TextStyle(color: Colors.green, fontSize: 25),
  ),
] else ...[
  Text(
    'Turn of Player $currentPlayer',
    style: TextStyle(color: Colors.black26, fontSize: 25),
  ),
],
              SizedBox(height: 30),
              for (int row = 0; row < boardSize; row++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int col = 0; col < boardSize; col++) getCell(row, col)
                  ],
                ),
              SizedBox(height: 30),
              if (gameover)
                ElevatedButton(
                    onPressed: () {
                      init_game_data();
                      setState(() {});
                    },
                    child: Text("Play Again")),
            ]),
      ),
    );
  }

  void switchPlayerTurn() {
    if (currentPlayer == 'X') {
      currentPlayer = 'O';
    } else {
      currentPlayer = 'X';
    }
  }

  Widget getCell(int row, int col) {
    var dataKey = row.toString() + "x" + col.toString();
    Color myColor = Colors.redAccent;
    if (data[dataKey] == 'O') myColor = Colors.yellowAccent;
    
    // If the cell is a winning cell, color it green
    if (winningCells.contains(dataKey)) {
      myColor = Colors.green; // Winning cell color
    }
    
    return GestureDetector(
      onTap: () {
        if (gameover) return;
        if (data[dataKey] == '') {
          data[dataKey] = currentPlayer;
          gameover = isWin();
          if (!gameover) {
            if (isDraw()) {
              // Do not switch the player if the game is a draw
              setState(() {});
              return;
            }
            switchPlayerTurn();
          }
          setState(() {});
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 3),
        ),
        width: 120,
        height: 120,
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.8,
                child: Image.asset('assets/images/wood.png', fit: BoxFit.cover),
              ),
            ),
            Center(
                child: Text('${data[dataKey]}',
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: myColor))),
          ],
        ),
      ),
    );
  }
}
