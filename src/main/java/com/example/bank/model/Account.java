package com.example.bank.model;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter
@ToString
public class Account {
	private int accountId;
	private int userId;
	private int accountTypeId;
	private long balance;
	private String accountNumber;
	private int accountPassword;
	private int isDeleted;
}
