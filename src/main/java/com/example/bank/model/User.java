package com.example.bank.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter
@ToString
public class User {
	private int userId;
	private String email;
	private String password;
	private String name;
	private String phoneNumber;
	private String address;
}
