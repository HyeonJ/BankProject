package com.example.bank.model;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter
@ToString
public class AccountType {
	private int accountTypeId;
	private String accountTypeName;
	private String accountTypeValue;
}
