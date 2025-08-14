import 'package:flutter/material.dart';
import 'package:projetlangue/page/pagefon/fon.dart';


class FrancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Langue à apprendre"),
          elevation: 18.0,
        ),
      body: 
      ListView(
        padding: EdgeInsets.all(30),
            children: [
              Image.asset(
                'assets/images/iconne.jpeg',
                height: 150,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 40,),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                      builder: (context)
                        {
                          return FonPage();
                        }
                      )
                    );
              }, child: Text("    Fon    ")),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text("    Yoruba    ")),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text("    Dendi    ")),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text("    Bariba    ")),
              
            ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
              Navigator.pop(context);
            },
            child: Text("retour"),
            backgroundColor: Colors.red,
      ),
    );
  }
}
