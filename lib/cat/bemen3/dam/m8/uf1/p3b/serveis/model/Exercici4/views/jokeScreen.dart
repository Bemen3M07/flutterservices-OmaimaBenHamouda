import 'package:flutter/material.dart';
import 'package:empty/cat/bemen3/dam/m8/uf1/p3b/serveis/model/Exercici4/models/joke.dart';
import 'package:empty/cat/bemen3/dam/m8/uf1/p3b/serveis/model/Exercici4/controllers/jokeService.dart';


class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  Joke? _currentJoke;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _fetchNewJoke() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      Joke? newJoke = await JokeService.fetchRandomJoke();
      setState(() {
        _currentJoke = newJoke;
        if (newJoke == null) _errorMessage = 'Failed to load joke.';
      });
    } catch (e) {
      setState(() => _errorMessage = 'An error occurred: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Jokes')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red))
              else if (_currentJoke != null)
                Column(
                  children: [
                    Text(_currentJoke!.setup, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(_currentJoke!.punchline, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                  ],
                )
              else
                const Text('Press the button to get a joke!'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _fetchNewJoke,
                child: const Text('Get New Joke'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}