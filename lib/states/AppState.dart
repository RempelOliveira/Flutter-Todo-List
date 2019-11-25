class AppState
{
    int booksTotal;
    List<dynamic> books;
    int skipBooks;
    bool isLoadingBooks;
    bool isLoadingMoreBooks;

    Map<String, dynamic> book;

    int reviewsTotal;
    List<dynamic> reviews;
    bool allReviews;
    bool isLoadingReviews;
    bool isLoadingAllReviews;

    String tab;
    String category;

    AppState({
        this.tab, this.category, this.booksTotal, this.books, this.skipBooks, this.isLoadingBooks, this.isLoadingMoreBooks, this.book, this.reviewsTotal, this.reviews, this.allReviews, this.isLoadingReviews, this.isLoadingAllReviews });

	AppState copyWith({ tab, category, booksTotal, books, skipBooks, isLoadingBooks, isLoadingMoreBooks, book, reviewsTotal, reviews, allReviews, isLoadingReviews, isLoadingAllReviews })
	{
		return AppState
		(
			tab: tab ?? this.tab,
			category: category ?? this.category,
			booksTotal: booksTotal ?? this.booksTotal,
			books: books ?? this.books,
			skipBooks: skipBooks ?? this.skipBooks,
			isLoadingBooks: isLoadingBooks ?? this.isLoadingBooks,
			isLoadingMoreBooks: isLoadingMoreBooks ?? this.isLoadingMoreBooks,
			book: book ?? this.book,
			reviewsTotal: reviewsTotal ?? this.reviewsTotal,
			reviews: reviews ?? this.reviews,
			allReviews: allReviews ?? this.allReviews,
			isLoadingReviews: isLoadingReviews ?? this.isLoadingReviews,
			isLoadingAllReviews: isLoadingAllReviews ?? this.isLoadingAllReviews

		);

	}

}