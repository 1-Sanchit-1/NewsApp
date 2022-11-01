class NewsQueryModel {
  final String newsHead;
  final String newsDec;
  final String newsImg;
  final String newsUrl;
  final String content ;

  NewsQueryModel(
      {this.newsDec = "description",
      this.newsHead = "title",
      this.newsImg = "urlToImage",
      this.newsUrl = "url",
      this.content="content"
      });

  factory NewsQueryModel.fromMap(Map news) {
    return NewsQueryModel(
      newsHead: news["title"],
      newsDec: news["description"],
      newsImg: news["urlToImage"],
      newsUrl: news["url"],
      content: news["content"] ,
    );
  }
}
