class AppState
{
    int booksTotal;
    List<dynamic> books;

    String tab;
    String category;

    bool isLoading;
    bool isLoadingMore;

    int skip;

    AppState({
        this.tab, this.category, this.booksTotal, this.books, this.isLoading, this.isLoadingMore, this.skip});

	AppState copyWith({ tab, category, booksTotal, books, isLoading, isLoadingMore, skip })
	{
		return AppState
		(
			tab: tab ?? this.tab,
			category: category ?? this.category,
			booksTotal: booksTotal ?? this.booksTotal,
			books: books ?? this.books,
			isLoading: isLoading ?? this.isLoading,
			isLoadingMore: isLoadingMore ?? this.isLoadingMore,
			skip: skip ?? this.skip

		);

	}

}