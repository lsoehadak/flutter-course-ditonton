import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/now_playing_tv_shows_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_shows_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowPlayingTvShowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv-show';

  @override
  _NowPlayingTvShowsPageState createState() => _NowPlayingTvShowsPageState();
}

class _NowPlayingTvShowsPageState extends State<NowPlayingTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NowPlayingTvShowsNotifier>(context, listen: false)
            .fetchNowPlayingTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowPlayingTvShowsNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data.tvShows[index];
                  return TvShowCard(tvShow);
                },
                itemCount: data.tvShows.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
