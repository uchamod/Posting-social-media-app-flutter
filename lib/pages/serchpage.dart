import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      //    backgroundColor: mobileBackgroundColor,
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
                //show the search result
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
          //get all posts
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("posts")
                  .orderBy("date")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: Text(
                      "No Post Yet.",
                      style: hinttext,
                    ),
                  );
                }
                //show all posts
                return MasonryGridView.count(
                  crossAxisCount: 3,
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(top: 3, left: 3, right: 3),
                      color: mobileBackgroundColor,
                      child: Image.network(
                        (snapshot.data! as dynamic).docs[index]["posturl"],
                      ),
                    );
                  },
                );
              },
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
