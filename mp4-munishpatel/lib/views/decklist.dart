import 'package:cs442_mp4/models/modeldeck.dart';
import 'package:cs442_mp4/providers/deckprovider.dart';
import 'package:cs442_mp4/providers/flashcardsprovider.dart';
import 'package:cs442_mp4/utils/converter.dart';
import 'package:cs442_mp4/views/editdeck.dart';
import 'package:cs442_mp4/views/listflashcards.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


class DeckList extends StatefulWidget {
  DeckList({Key? key}) : super(key: key);

  @override
  _DeckListState createState() => _DeckListState();
}

class _DeckListState extends State<DeckList> {
  // Function to handle the download action
  Future<void> handleDownload() async {
    // Implement your download logic here
    await defaultinsertJsonDataToDB();
  }

  @override
  Widget build(BuildContext context) {
    final deckProvider = Provider.of<DeckProvider>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);

    // Determine the screen width
    double screenWidth = mediaQuery.size.width;

    // Determine the number of columns based on screen size
    int columns;
    if (screenWidth < 400) {
      columns = 1;
    } else if (screenWidth < 600) {
      columns = 2;
    } else if(screenWidth < 800){
      columns = 3;
    }else{
      columns = 4;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Deck List'),
        actions: [
          // Add a download button to the app bar
          IconButton(
            icon: Icon(Icons.download),
            onPressed: handleDownload,
          ),
        ],
      ),
      body: Consumer2<DeckProvider, FlashcardProvider>(
        builder: (context, deckProvider, flashcardProvider, child) {
          deckProvider.loadDecks(); // Call the function

          // Use the decks from the provider
          final List<Deck> decks = deckProvider.decks;

          // Calculate the spacing between items
          double spacing = columns == 4 ? 8 : 16;

          // Rest of your UI code
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            itemCount: decks.length,
            itemBuilder: (context, index) {
              final deck = decks[index];

              return Card(
                color: Color(0xFFF7B733),
                child: InkWell(
                  onTap: () {
                    // Navigate to the FlashcardList with the selected deck's ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FlashcardList(deckId: deck.id ?? 0, decktitle: deck.title);
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Expanded(  // Wrap Text in Expanded
                          child: Center(  // Center widget for horizontal alignment
                            child: Text(
                              deck.title,
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,  // Center text alignment
                              overflow: TextOverflow.ellipsis,  // Handle long text
                              maxLines: 2,  // Allow up to 2 lines for the title
                            ),
                          ),
                  ),
                        FutureBuilder<int>(
                          future: flashcardProvider.getNumberOfFlashcardsInDeck(deck.id ?? 0),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              int flashcardCount = snapshot.data ?? 0;
                              return Text(
                                'Flashcards: $flashcardCount',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return const Text(
                                'Flashcards: Loading...',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              );
                            }
                          },
                        ),
                        // Edit Button
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return DeckEditPage(
                                  deckTitle: deck.title,
                                  onSave: (newName) async {
                                    // Update the deck name using the provider
                                    deckProvider.updateDeckTitle(deck, newName);
                                   //print('Saving deck name: $newName');
                                  },
                                  onDelete: () {
                                    deckProvider.deleteDeck(deck.id ?? 0);
                                    setState(() {
                                      deckProvider.loadDecks();
                                    });
                                    //print('Deleting deck');
                                  },
                                );
                              }),
                            );
                            setState(() {
                              deckProvider.loadDecks();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return DeckCreatePage(
                onSave: (newName) async {
                  final newDeck = Deck(title: newName);
                  deckProvider.addDeck(newDeck);
                },
              );
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


class DeckCreatePage extends StatefulWidget {
  final void Function(String) onSave;

  DeckCreatePage({
    required this.onSave,
  });

  @override
  _DeckCreatePageState createState() => _DeckCreatePageState();
}

class _DeckCreatePageState extends State<DeckCreatePage> {
  final TextEditingController _deckNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Deck'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _deckNameController,
              decoration: InputDecoration(labelText: 'Deck Name'),
              onChanged: (newName) {
                // Handle text changes
              },
            ),
            SizedBox(height: mediaQuery.size.height * 0.02),
            ElevatedButton(
              onPressed: () {
                widget.onSave(_deckNameController.text);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _deckNameController.dispose();
    super.dispose();
  }
}
