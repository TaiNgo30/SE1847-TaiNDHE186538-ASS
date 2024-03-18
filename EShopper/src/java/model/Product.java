/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ducta
 */
import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString

public class Product {

    private int id, quantity, brand_id;
    private String name, description, image_url;
    private double price;
    private Date release_date;
    
    //constructor for insert a new product
    public Product(int quantity, int brand_id, String name, String description, String image_url, double price, Date release_date) {
        this.quantity = quantity;
        this.brand_id = brand_id;
        this.name = name;
        this.description = description;
        this.image_url = image_url;
        this.price = price;
        this.release_date = release_date;
    }

    
    
}
