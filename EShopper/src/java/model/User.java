/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 *
 * @author ducta
 */

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString

public class User {
    
    private int id;
    private String username;
    private String password;
    private String fullname;
    private String email;
    private String phone;
    private String address;
    private int role_id;
    private int banned;

    public User(String username, String password, String fullname, String email, String phone, String address, int role_id) {
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role_id = role_id;
    }
    
    public User(int id, String username, String password, String fullname, String email, String phone, String address, int role_id) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role_id = role_id;
    }
}
