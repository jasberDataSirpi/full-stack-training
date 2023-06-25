package com.datasirpi.mealplanet.controller;
import com.datasirpi.mealplanet.dto.BrandDto;
import com.datasirpi.mealplanet.entity.BrandEntity;
import com.datasirpi.mealplanet.repository.BrandRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@CrossOrigin
@RestController
@RequestMapping("/brands")

public class brandController {

    @Autowired
    BrandRepository brandRepository;


    @PostMapping
    ResponseEntity addBrand(@RequestBody BrandDto brandDto) {
        BrandEntity brandEntity = new BrandEntity();
        brandEntity.setName(brandDto.getName());
        brandEntity.setPhNo(brandDto.getPhNo());
        brandRepository.save(brandEntity);
        return ResponseEntity.status(200).body("Brand added successfully");
    }

    @GetMapping
    ResponseEntity getBrands () {
        List<BrandEntity> brandEntityList = brandRepository.findAll();
        return ResponseEntity.status(200).body(brandEntityList);
    }
}
