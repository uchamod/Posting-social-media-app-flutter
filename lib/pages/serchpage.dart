import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';

class SerchPage extends StatefulWidget {
  const SerchPage({super.key});

  @override
  State<SerchPage> createState() => _SerchPageState();
}

class _SerchPageState extends State<SerchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool isShow = false;
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileSearchColor,
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        //search bar
        title: searchField(),
      ),
      body: isShow
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where("username",
                      isGreaterThanOrEqualTo: _searchController.text)
                  .where("username", isLessThan: '${_searchController.text}z')
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Text(
                      "No Result",
                      style: hinttext,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.requireData.size,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.requireData.docs[index]["avatar"],
                        ),
                      ),
                      title: Text(
                        snapshot.requireData.docs[index]["username"],
                        style: body,
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: Icon(
                Icons.search_rounded,
                size: 40,
                color: secondaryColor,
              ),
            ),
    );
  }

//search text field
  Widget searchField() {
    return Form(
      child: TextFormField(
        cursorColor: primaryColor,
        style: body,
        enabled: true,
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: textboxfillcolor.withOpacity(0.5),
          hintText: "Search",
          hintStyle: hinttext,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 0,
            ),
          ),
        ),
        onFieldSubmitted: (String _) {
          setState(() {
            isShow = true;
          });
        },
      ),
    );
  }
}
