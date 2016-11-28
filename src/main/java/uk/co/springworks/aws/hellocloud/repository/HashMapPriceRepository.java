package uk.co.springworks.aws.hellocloud.repository;

import java.util.Collection;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import uk.co.springworks.aws.hellocloud.Price;

public class HashMapPriceRepository implements PriceRepository{
	private Map<String, Price> repo = new ConcurrentHashMap<>();
	
	@Override
	public Price get(String symbol) {
		return repo.get(symbol);
	}

	@Override
	public void add(Price price) {
		repo.put(price.getSymbol(), price);
	}

	@Override
	public Collection<Price> getAll() {
		return repo.values();
	}

	@Override
	public void delete(String symbol) {
		repo.remove(symbol);
	}

	@Override
	public void reset() {
		repo.clear();
		populate(this);
	}
}
