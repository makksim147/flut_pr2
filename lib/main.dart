import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Практос заметок",
      home: NotesWidget(),
    );
  }
}

class NotesWidget extends StatefulWidget {
  const NotesWidget({super.key});

  @override
  _NotesWidgetState createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  final TextEditingController _controller = TextEditingController();
  final List<TextEditingController> _controllers = [];
  final List<String?> notests = [];

  void AddNotes() {
    final inputValue = _controller.text.trim();
    
    if (inputValue.isNotEmpty) {
      setState(() {
        notests.add(inputValue);
        _controllers.add(TextEditingController(text: _controller.text.trim()));
        _controller.clear();  
      });
    } 
  }

  void ChangeNotets(int index, String text) {
    if (text.trim() != notests[index]) {
      setState(() {
        notests[index] = text.trim();
      });
    }
  }

  void DelNotes(int index) {
    setState(() {
      notests.removeAt(index);
      _controllers[index].dispose();
      _controllers.removeAt(index);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    for (var i in _controllers) {
      i.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromRGBO(232, 232, 232, 100),
        body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(hintText: "Введите текст заметки!"),
                      )
                    ),
                    ElevatedButton(
                      onPressed: (){
                        AddNotes();
                      },
                      child: Text("Сохранить"),
                      
                      )
                  ],
                )
              ),
              Text("Список ваших заметок"),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  padding: EdgeInsets.all(15),
                  itemCount: notests.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: _controllers[index],
                            decoration: InputDecoration(
                              hintText: notests[index] ?? "Пустое значение"
                            ),
                          )),
                        ElevatedButton(
                          onPressed: () {
                            DelNotes(index);
                          },
                          child: Text("Удалить")),
                        ElevatedButton(
                          onPressed: () {
                            ChangeNotets(index, _controllers[index].text);
                          },
                          child: Text("Изменить")
                          )
                        ],
                      ),
                    );
                  }
                )
              )
            ],
          )
        )
      )
    );
  }
}
