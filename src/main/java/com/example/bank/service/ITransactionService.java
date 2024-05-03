package com.example.bank.service;

import java.util.List;
import java.util.Map;

import com.example.bank.model.Transaction;

public interface ITransactionService {
	
	List<Map<String, Object>> getTransactionListByAccountId(int accountId);
	List<Map<String, Object>> getTransactionListWithPaging(int accountId, int page);

	byte[] transactionsToPDF(int accountId);
	
	int getTransactionTotalPageCount(int accountId);
}
