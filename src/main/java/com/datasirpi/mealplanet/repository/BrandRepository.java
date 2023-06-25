package com.datasirpi.mealplanet.repository;

import com.datasirpi.mealplanet.entity.BrandEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BrandRepository extends JpaRepository<BrandEntity, Long> {}
