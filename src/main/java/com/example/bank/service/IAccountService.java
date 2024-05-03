package com.example.bank.service;

import java.util.List;
import java.util.Map;

import com.example.bank.model.Account;

public interface IAccountService {

	void createAccount(Account account, int userId, int accountTypeId);
	
	List<Account> getAccountListByUserId(int userId);
	
	List<Map<String, Object>> getAllAccountType();
	List<Map<String, Object>> getAllAccountTypeName();
	
	List<Map<String, Object>> getUserAccountInfo(int userId);
	List<Map<String, Object>> getAllAccountNumber(int accountId);
	
//	void deleteAccount(String accountNumber);
	void deleteAccount(String accountNumber, int accountPassword);
	
	boolean checkBalance(String senderAccountNumber, int amount);
	boolean checkAccount(String receiverAccountNumber);
	int checkPassword(String accountNumber, int accountPassword);
	boolean transfer(String senderAccountNumber, String receiverAccountNumber, int accountPassword, int amount);
	void createTransferTransaction(String senderAccountNumber, String receiverAccountNumber, int amount);
	void createDepositTransaction(String accountNumber, int amount);
	
	
	
	
	

	Account getAccountByAccountId(int accountId);
	Account getAccountByAccountNumber(String accountNumber);
	String getUserNameByAccountNumber(String accountNumber);
	void setAccountBalance(String accountNumber, int amount);
	void createOnlyDepositTransaction(String accountNumber, int amount);

}
