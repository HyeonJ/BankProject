package com.example.bank.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.bank.model.Account;

@Repository
public class AccountRepository implements IAccountRepository {
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private class AccountMapper implements RowMapper<Account> {

		@Override
		public Account mapRow(ResultSet rs, int rowNum) throws SQLException {
			Account account = new Account();
			account.setAccountId(rs.getInt("account_id"));
			account.setUserId(rs.getInt("user_id"));
			account.setAccountTypeId(rs.getInt("account_type_id"));
			account.setBalance(rs.getLong("balance"));
			account.setAccountNumber(rs.getString("account_number"));
			account.setAccountPassword(rs.getInt("account_password"));
			account.setIsDeleted(rs.getInt("is_deleted"));
			return account;
		}
	}
	
	@Override
	public List<Account> getAccountListByUserId(int userId) {
		String sql = "select account_id, user_id, account_type_id, "
				+ "balance, account_number, account_password, is_deleted "
				+ "from accounts where user_id=?";
		try {
			return jdbcTemplate.query(sql, new AccountMapper(), userId);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	
	@Override
	public int getMaxAccountId() {
		String sql = "SELECT NVL(MAX(account_id),0) FROM accounts";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	@Override
	public void createAccount(Account account, int userId, int accountTypeId) {
		String sql = "INSERT INTO accounts VALUES (?, ?, ?, 0, ?, ?, 0)";
		jdbcTemplate.update(sql, account.getAccountId(),
								account.getUserId(),
								accountTypeId,
								account.getAccountNumber(),
								account.getAccountPassword());
		
	}

	@Override
	public List<Map<String, Object>> getAllAccountType() {
		String sql = "SELECT account_type_id AS id, account_type_name AS name, account_type_value AS value "
				+ "FROM account_types ORDER BY account_type_id";
		return jdbcTemplate.queryForList(sql);
	}

	
	
	@Override
	public String accountNumberGenerator(int accountTypeId, int accountId, int userId) {
		String sql;
		if (accountId < 10) {
		sql = "SELECT ? || 0 || ? || SUBSTR(REPLACE(phone_number, '-', ''), 1, 1) || '-' || "
				+ "SUBSTR(REPLACE(phone_number, '-', ''), 2, 6) || '-' || "
				+ "SUBSTR(REPLACE(phone_number, '-', ''), 8) "
				+ "FROM users "
				+ "WHERE user_id=?";
		} else {
			sql = "SELECT ? || ? || SUBSTR(REPLACE(phone_number, '-', ''), 1, 1) || '-' || "
					+ "SUBSTR(REPLACE(phone_number, '-', ''), 2, 6) || '-' || "
					+ "SUBSTR(REPLACE(phone_number, '-', ''), 8) "
					+ "FROM users "
					+ "WHERE user_id=?";
		}
		return jdbcTemplate.queryForObject(sql, String.class, accountTypeId, accountId, userId);
	}

	
	@Override
	public List<Map<String, Object>> getUserAccountInfo(int userId) {
		String sql = "SELECT a.account_number AS ACCOUNT, t.account_type_value AS TYPE, t.account_type_id AS TYPEID, "
				+ "t.account_type_name AS TYPENAME, a.balance AS BALANCE, a.user_id AS ID, a.is_deleted AS DELETED, a.account_id AS accountId "
				+ "FROM accounts a "
				+ "JOIN account_types t "
				+ "ON a.account_type_id = t.account_type_id "
				+ "WHERE a.user_id=?";
		return jdbcTemplate.queryForList(sql, userId);
	}
	
	// Transaction 테이블에 들어가야 하는 값은 account_id
	// 하지만 이 함수를 호출하는 곳에서 사용하는 변수는 account_number
	// sql에서 처리함
	@Override
	public void createTransferTransaction(String senderAccountNumber, String receiverAccountNumber, int amount) {
		String sql = "INSERT INTO transactions VALUES ("
				+ "(SELECT NVL(MAX(transaction_id),0)+1 FROM transactions), "		// transaction_id
				+ "(SELECT account_id FROM accounts WHERE account_number=?), "		// account_id
				+ "'transfer', "													// type
				+ "0, "																// amount_deposit
				+ "?, "																// amount_transfer
				+ "(SELECT balance FROM accounts WHERE account_id=(SELECT account_id FROM accounts WHERE account_number=?)), "	// amount_account
				+ "SYSDATE, "														// transaction_date
				+ "(SELECT account_id FROM accounts WHERE account_number=?)"		// destination_account_id
				+ ")";
		jdbcTemplate.update(sql,senderAccountNumber,
								amount,
								senderAccountNumber,
								receiverAccountNumber);
	}
	
	@Override
	public void createDepositTransaction(String receiverAccountNumber, int amount) {
		String sql = "INSERT INTO transactions VALUES ("
				+ "(SELECT NVL(MAX(transaction_id),0)+1 FROM transactions), "		// transaction_id
				+ "(SELECT account_id FROM accounts WHERE account_number=?), "		// account_id
				+ "'deposit', "													// type
				+ "?, "																// amount_deposit
				+ "0, "																// amount_transfer
				+ "(SELECT balance FROM accounts WHERE account_id=(SELECT account_id FROM accounts WHERE account_number=?)), "	// amount_account
				+ "SYSDATE, "														// transaction_date
				+ "(SELECT account_id FROM accounts WHERE account_number=?)"		// destination_account_id
				+ ")";
		jdbcTemplate.update(sql,receiverAccountNumber,
				amount,
				receiverAccountNumber,
				receiverAccountNumber);
	}


	@Override
	public int getMaxTransactionId() {
		String sql = "SELECT NVL(MAX(transaction_id),0) FROM transactions";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	@Override
	public int getDestinationIdByAccountNumber(String accountNumber) {
		String sql = "SELECT account_id FROM accounts WHERE account_number=?";
		return jdbcTemplate.queryForObject(sql, Integer.class, accountNumber);
	}

	@Override
	public void setSenderAccountBalance(String accountNumber, int amount) {
		String sql = "UPDATE accounts SET balance=balance-? WHERE account_number=?";
		jdbcTemplate.update(sql, amount, accountNumber);
	}

	@Override
	public void setReceiverAccountBalance(String accountNumber, int amount) {
		String sql = "UPDATE accounts SET balance=balance+? WHERE account_number=?";
		jdbcTemplate.update(sql, amount, accountNumber);
	}

	@Override
	public int checkAccount(String accountNumber) {
		String sql = "SELECT COUNT(*) FROM accounts WHERE account_number=? AND is_deleted=0";

		return jdbcTemplate.queryForObject(sql, Integer.class, accountNumber);
	}

	@Override
	public List<Map<String, Object>> getAllAccountNumber(int userId) {
		String sql = "SELECT a.account_number AS account, a.balance AS balance, a.is_deleted AS ISDEL, "
				+ "t.account_type_name AS accountName, t.account_type_value AS typeValue "
				+ "FROM accounts a JOIN account_types t ON a.account_type_id = t.account_type_id "
				+ "WHERE user_id=?";
		return jdbcTemplate.queryForList(sql, userId);
	}

	@Override
	public int checkPassword(String accountNumber, int accountPassword) {
		String sql = "SELECT CASE "
				+ "WHEN account_password = ? THEN 1 "
				+ "ELSE 0 "
				+ "END AS isValidPassword "
				+ "FROM accounts "
				+ "WHERE account_number = ?";
		return jdbcTemplate.queryForObject(sql, Integer.class, accountPassword, accountNumber);
	}

	@Override
	public int getSenderAccountBalance(String accountNumber) {
		String sql = "SELECT balance FROM accounts WHERE account_number=?";
		return jdbcTemplate.queryForObject(sql, Integer.class, accountNumber);
	}

	@Override
	public List<Map<String, Object>> getAllAccountTypeName() {
		String sql = "SELECT account_type_name FROM account_types";
		return jdbcTemplate.queryForList(sql);
	}

	
	@Override
	public void deleteAccount(String accountNumber, int accountPassword) {
		String sql = "UPDATE accounts SET is_deleted=1 WHERE account_number=? AND account_password=?";
		jdbcTemplate.update(sql, accountNumber, accountPassword);
	}
	
	
	
	@Override
	public Account getAccountByAccountId(int accountId) {
		String sql = "select account_id, user_id, account_type_id, "
				+ "balance, account_number, account_password, is_deleted "
				+ "from accounts where account_id=?";
		try {
			return jdbcTemplate.queryForObject(sql, new AccountMapper(), accountId);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public Account getAccountByAccountNumber(String accountNumber) {
		String sql = "select account_id, user_id, account_type_id, "
				+ "balance, account_number, account_password, is_deleted "
				+ "from accounts where account_number=?";
		try {
			return jdbcTemplate.queryForObject(sql, new AccountMapper(), accountNumber);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
	@Override
	public String getUserNameByAccountId(String accountNumber) {
		String sql = "SELECT u.name "
				+ "FROM accounts a "
				+ "JOIN users u ON u.user_id=a.user_id "
				+ "WHERE account_number=?";
		try {
			return jdbcTemplate.queryForObject(sql, String.class, accountNumber);
		} catch (EmptyResultDataAccessException e) {
			return "";
		}
	}
	
	@Override
	public void createOnlyDepositTransaction(String accountNumber, int amount) {
		String sql = "INSERT INTO transactions VALUES ("
				+ "(SELECT NVL(MAX(transaction_id),0)+1 FROM transactions), "		// transaction_id
				+ "(SELECT account_id FROM accounts WHERE account_number=?), "		// account_id
				+ "'deposit', "													// type
				+ "?, "																// amount_deposit
				+ "0, "																// amount_transfer
				+ "(SELECT balance + ? FROM accounts WHERE account_id=(SELECT account_id FROM accounts WHERE account_number=?)), "	// amount_account
				+ "SYSDATE, "														// transaction_date
				+ "null"		// destination_account_id
				+ ")";
		jdbcTemplate.update(sql,
				accountNumber,
				amount,
				amount,
				accountNumber);
	}
}
