package uk.co.springworks.aws.hellocloud.repository;

import java.util.Collection;

import uk.co.springworks.aws.hellocloud.Price;

public interface PriceRepository {
	Price get(String symbol);
	void add(Price price);
	Collection<Price> getAll();
	void delete(String symbol);
	void reset();
	
	public default void populate(PriceRepository repo){
		repo.add(new Price("AAPL","94.99"));
		repo.add(new Price("GOOG","694.49"));
		repo.add(new Price("JPM","59.55"));
	}
}
