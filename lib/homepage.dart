import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool OTurn = true;
  List<String> displayElements = ["", "", "", "", "", "", "", "", ""];
  int OScore = 0;
  int XScore = 0;
  int filledboxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 8, 8),
      appBar: AppBar(
        
        leading: const Icon(Icons.home),
        title: const Text(
          "Tic Tac Toe App",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 181, 190, 242)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "PLAYER X",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  ' = $XScore',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(width: 20), // Add spacing between players
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "PLAYER O",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  ' = $OScore',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.lightGreenAccent,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: SizedBox(
              height: 400,
              width: 400,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      tapped(index);
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                      child: Center(
                        child: Text(
                          displayElements[index],
                          style: const TextStyle(color: Colors.brown, fontSize: 26),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  
                  onPressed: clearScoreBoard,
                  child: const Text("Clear Score Board",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.amber),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void tapped(int index) {
    setState(() {
      if (OTurn && displayElements[index] == '') {
        displayElements[index] = 'O';
        filledboxes++;
      } else if (!OTurn && displayElements[index] == '') {
        displayElements[index] = 'X';
        filledboxes++;
      }
      OTurn = !OTurn;
      checkWinner();
    });
  }

  void checkWinner() {
    // Horizontal Wins
    if (displayElements[0] == displayElements[1] && displayElements[1] == displayElements[2] && displayElements[0] != "") {
      showWinner(displayElements[0]);
    } else if (displayElements[3] == displayElements[4] && displayElements[4] == displayElements[5] && displayElements[3] != "") {
      showWinner(displayElements[3]);
    } else if (displayElements[6] == displayElements[7] && displayElements[7] == displayElements[8] && displayElements[6] != "") {
      showWinner(displayElements[6]);
    }
    // Vertical Wins
    else if (displayElements[0] == displayElements[3] && displayElements[3] == displayElements[6] && displayElements[0] != "") {
      showWinner(displayElements[0]);
    } else if (displayElements[1] == displayElements[4] && displayElements[4] == displayElements[7] && displayElements[1] != "") {
      showWinner(displayElements[1]);
    } else if (displayElements[2] == displayElements[5] && displayElements[5] == displayElements[8] && displayElements[2] != "") {
      showWinner(displayElements[2]);
    }
    // Diagonal Wins
    else if (displayElements[0] == displayElements[4] && displayElements[4] == displayElements[8] && displayElements[0] != "") {
      showWinner(displayElements[0]);
    } else if (displayElements[2] == displayElements[4] && displayElements[4] == displayElements[6] && displayElements[2] != "") {
      showWinner(displayElements[2]);
    }
    // Draw
    else if (filledboxes == 9) {
      showDraw();
    }
  }

  void showWinner(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$winner is the winner!"),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                clearBoard();
              },
              child: const Text("Play Again"),
            ),
          ],
        );
      },
    );

    if (winner == 'O') {
      OScore++;
    } else {
      XScore++;
    }
  }

  void showDraw() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("It's a Draw!"),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                clearBoard();
              },
              child: const Text("Play Again"),
            ),
          ],
        );
      },
    );
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElements[i] = '';
      }
      filledboxes = 0;
    });
  }

  void clearScoreBoard() {
    setState(() {
      XScore = 0;
      OScore = 0;
      clearBoard();
    });
  }
}
