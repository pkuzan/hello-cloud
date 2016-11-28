package uk.co.springworks.aws.hellocloud.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import uk.co.springworks.aws.hellocloud.Price;
import uk.co.springworks.aws.hellocloud.repository.PriceRepository;

import java.util.Collection;

@RestController
@RequestMapping(value = "/prices")
public class PriceController {
    private PriceRepository repo;

    public PriceController(PriceRepository repo) {
        this.repo = repo;
    }

    @RequestMapping(value = "/{symbol}", method = RequestMethod.GET)
    public ResponseEntity<Price> getPrice(@PathVariable(value = "symbol") String symbol) {
        Price price = repo.get(symbol);
        if (null != price) {
            return new ResponseEntity<Price>(price, HttpStatus.OK);
        } else {
            return new ResponseEntity<Price>(HttpStatus.NOT_FOUND);
        }
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ResponseEntity<Collection<Price>> getAllPrices() {
        Collection<Price> prices = repo.getAll();
        return new ResponseEntity<Collection<Price>>(prices, HttpStatus.OK);
    }

    @RequestMapping(value = "/{symbol}", method = RequestMethod.DELETE)
    public ResponseEntity<?> deletePriceForSymbol(@PathVariable(value = "symbol") String symbol){
        Price price = repo.get(symbol);
        if (null != price) {
            repo.delete(symbol);
            return new ResponseEntity<Void>(HttpStatus.OK);
        } else {
            return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
        }
    }

    @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity<?> addNewPrice(@RequestBody Price pricetoAdd){
        Price price = repo.get(pricetoAdd.getSymbol());
        if (null == price) {
            repo.add(pricetoAdd);
            return new ResponseEntity<Void>(HttpStatus.OK);
        } else {
            return new ResponseEntity<Void>(HttpStatus.CONFLICT);
        }
    }

    @RequestMapping(method = RequestMethod.PUT)
    public ResponseEntity<?> updateExistingPrice(@RequestBody Price updatedPrice){
        Price price = repo.get(updatedPrice.getSymbol());
        if (null != price) {
            repo.add(updatedPrice);
            return new ResponseEntity<Void>(HttpStatus.OK);
        } else {
            return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
        }
    }

    @RequestMapping(value = "/reset", method = RequestMethod.POST)
    public void reset() {
        repo.reset();
    }
}
