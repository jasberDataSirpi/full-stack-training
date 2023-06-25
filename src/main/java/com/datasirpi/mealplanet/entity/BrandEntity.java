package com.datasirpi.mealplanet.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.math.BigInteger;

@Entity
@Table(name = "brands")
@Getter
@Setter
public class BrandEntity {
    @Id
    @Column(name = "id")
    int id;

    @Column(name = "name")
    String name;

    @Column(name = "ph_no")
    BigInteger phNo;
}
