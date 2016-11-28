package uk.co.springworks.aws.hellocloud.repository;


import org.junit.Assert;
import org.junit.Test;
import uk.co.springworks.aws.hellocloud.Price;

public class HashMapPriceRepositoryTest {
    PriceRepository repo = new HashMapPriceRepository();
    private static final String APPLE_SYMBOL = "AAPL";
    private static final String UNKNOWN_SYMBOL = "ABCD";

    @Test
    public void get_when_found(){
        repo.populate(repo);
        Price p = repo.get(APPLE_SYMBOL);

        Assert.assertEquals("94.99", p.getPrice());
    }

    @Test
    public void get_when_not_found(){
        repo.populate(repo);
        Assert.assertNull(repo.get(UNKNOWN_SYMBOL));
    }
}
