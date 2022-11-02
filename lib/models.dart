class NewsQueryModel {
  final String newsHead;
  final String newsDec;
  final String newsImg;
  final String newsUrl;
  final String content ;
  final String author ;

  NewsQueryModel(
      {this.newsDec = "description",
      this.newsHead = "title",
      this.newsImg = "urlToImage",
      this.newsUrl = "url",
      this.content="content",
        this.author="author"
      });

  factory NewsQueryModel.fromMap(Map news) {
    return NewsQueryModel(
      newsHead: news["title"],
      newsDec: news["description"],
      newsImg: news["urlToImage"],
      newsUrl: news["url"],
      content: news["content"] ,
      author: news["author"]
    );
  }
}
