package com.example.bank.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.bank.model.Transaction;
@Repository
public class TransactionRepository implements ITransactionRepository {
	@Autowired
	JdbcTemplate jdbcTemplate;

	private class TransactionMapper implements RowMapper<Transaction> {

		@Override
		public Transaction mapRow(ResultSet rs, int rowNum) throws SQLException {
			Transaction transaction = new Transaction();
			transaction.setTransactionId(rs.getInt("transaction_id"));
			transaction.setAccountId(rs.getInt("account_id"));
			transaction.setType(rs.getString("type"));
			transaction.setAmountDeposit(rs.getLong("amount_deposit"));
			transaction.setAmountTransfer(rs.getLong("amount_transfer"));
			transaction.setAmountAccount(rs.getLong("amount_account"));
			transaction.setTransactionDate(rs.getDate("transaction_date"));
			transaction.setDestinationAccountId(rs.getInt("destination_transaction_id"));
			return transaction;
		}
	}
	
//	@Override
//	public List<Transaction> getTransactionListByAccountId(int accountId) {
//		String sql = "SELECT transaction_id, account_id, type, "
//				+ "amount, transaction_date, destination_account_id "
//				+ "FROM transactions WHERE account_id=?";
//		return jdbcTemplate.query(sql, new TransactionMapper(), accountId);
//	}
	
	@Override
	public List<Map<String, Object>> getTransactionListByAccountId(int accountId) {
		String sql = "SELECT "
				+ "	t.transaction_date AS transactionDate, t.type AS type, "
				+ " t.amount_deposit AS amountDeposit, t.amount_transfer AS amountTransfer, "
				+ " t.amount_account AS amountAccount, u.name AS name "
				+ " FROM transactions t "
				+ " LEFT JOIN accounts a ON t.destination_account_id=a.account_id "
				+ " LEFT JOIN users u ON a.user_id=u.user_id "
				+ " WHERE t.account_id=?"
				+ " ORDER BY t.transaction_id";
		return jdbcTemplate.queryForList(sql, accountId);
	}
	
	@Override
	public int getTransactionTotalPageCount(int accountId) {
		String sql = "SELECT CEIL(COUNT(*) / 10.0) AS totalPages " + 
				"FROM transactions WHERE account_id=?";
		return jdbcTemplate.queryForObject(sql, Integer.class, accountId);
	}
	
	@Override
	public List<Map<String, Object>> getTransactionListWithPaging(int accountId, int page) {
		int pageSize = 10;
        int offset = (page - 1) * pageSize;
        String sql = "SELECT "
				+ "	t.transaction_date AS transactionDate, t.type AS type, "
				+ " t.amount_deposit AS amountDeposit, t.amount_transfer AS amountTransfer, "
				+ " t.amount_account AS amountAccount, u.name AS name "
				+ " FROM transactions t "
				+ " LEFT JOIN accounts a ON t.destination_account_id=a.account_id "
				+ " LEFT JOIN users u ON a.user_id=u.user_id "
				+ " WHERE t.account_id=? "
				+ " ORDER BY t.transaction_id "
				+ " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ";
        return jdbcTemplate.queryForList(sql, accountId, offset, pageSize);
	}
}
