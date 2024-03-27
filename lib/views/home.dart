import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/player_Controller.dart';
import 'package:flutter/material.dart';
import '../consts/text_style.dart';
import '../consts/colors.dart';
import 'package:get/get.dart';



class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayController());

    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search, color: whiteColor)),
        ],
        leading: const Icon(Icons.sort_rounded, color: whiteColor),
        title: Text("MyPlay",
          style: ourStyle(
              family: 'bold',
            size: 18,
          ),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL
        ),

        builder: (BuildContext context, snapshot) {
          if(snapshot.data == null){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.data!.isEmpty){
            return Center(
              child: Text("No song found",
              style: ourStyle(),
              ),
            );
          }else{
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    child: Obx(
                      ()=> ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        tileColor: bgColor,
                        title: Text(
                          snapshot.data![index].displayNameWOExt,
                          style: ourStyle(family: bold, size: 15),
                        ),
                        subtitle: Text(
                          "${snapshot.data![index].artist}",
                          style: ourStyle(family: regular, size: 12),
                        ),
                        leading: QueryArtworkWidget(
                            id: snapshot.data![index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: const Icon(
                            Icons.music_note,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        trailing: controller.playIndex == index && controller.isPlaying.value
                          ? const Icon(
                          Icons.play_arrow,
                          color: whiteColor,
                          size: 26,
                        ): null,
                        onTap: () {
                          controller.playSong(snapshot.data![index].uri, index);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      )
    );
  }
}

//Code to be repasted

// Padding(
// padding: const EdgeInsets.all(8.0),
// child: ListView.builder(
// physics: const BouncingScrollPhysics(),
// itemCount: 100,
// itemBuilder: (BuildContext context, int index){
// return Container(
// margin: const EdgeInsets.only(bottom: 4),
// child: ListTile(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(12)
// ),
// tileColor: bgColor,
// title: Text(
// "Music name",
// style: ourStyle(family: bold, size: 15),
// ),
// subtitle: Text(
// "Artist name",
// style: ourStyle(family: regular, size: 12),
// ),
// leading: const Icon(
// Icons.music_note,
// color: whiteColor,
// size: 32,
// ),
// trailing: const Icon(
// Icons.play_arrow,
// color: whiteColor,
// size: 26,
// ),
// ),
// );
// },
// ),
// ),