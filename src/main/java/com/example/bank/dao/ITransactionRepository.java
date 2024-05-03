package com.example.bank.dao;

import java.util.List;
import java.util.Map;

import com.example.bank.model.Transaction;

public interface ITransactionRepository {

	List<Map<String, Object>> getTransactionListByAccountId(int accountId);
	List<Map<String, Object>> getTransactionListWithPaging(int accountId, int page);

	int getTransactionTotalPageCount(int accountId);
}
