package com.example.bank.model;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter
@ToString
public class Transaction {
	private int transactionId;
	private int accountId;
	private String type;
	private long amountDeposit;
	private long amountTransfer;
	private long amountAccount;
	private Date transactionDate;
	private int destinationAccountId;
}
