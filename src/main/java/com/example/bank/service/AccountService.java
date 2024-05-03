package com.example.bank.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.bank.dao.IAccountRepository;
import com.example.bank.model.Account;

@Service
public class AccountService implements IAccountService {

	@Autowired
	IAccountRepository accountRepository;
	
	@Override
	public void createAccount(Account account, int userId, int accountTypeId) {
		int newAccountId = accountRepository.getMaxAccountId();
		newAccountId += 1;
		String newAccountNumber = accountRepository.accountNumberGenerator(accountTypeId, newAccountId, userId);
		account.setAccountNumber(newAccountNumber);
		account.setUserId(userId);
		
		account.setAccountId(newAccountId);

		accountRepository.createAccount(account, userId, accountTypeId);
	}

	@Override
	public List<Account> getAccountListByUserId(int userId) {
		return accountRepository.getAccountListByUserId(userId);
	}

	@Override
	public List<Map<String, Object>> getAllAccountType() {
		return accountRepository.getAllAccountType();
	}


	@Override
	public List<Map<String, Object>> getUserAccountInfo(int userId) {
		return accountRepository.getUserAccountInfo(userId);
	}


	@Override
	public List<Map<String, Object>> getAllAccountNumber(int accountId) {
		return accountRepository.getAllAccountNumber(accountId);
	}
	

	@Override
	@Transactional
	public boolean transfer(String senderAccountNumber, String receiverAccountNumber, int accountPassword, int amount) {
			// 비밀번호 검사
			if (checkPassword(senderAccountNumber, accountPassword)==1) {
				// 계좌 비밀번호를 올바르게 입력한 경우
				// 상대 계좌번호 입력 검사
				if (checkAccount(receiverAccountNumber)) {
					// 받는 사람의 계좌가 DB에 존재하는 경우
					// 보내는 사람의 잔액 조회
					if (checkBalance(senderAccountNumber, amount)) {
						// 보내는 사람의 계좌 잔액이 이체 금액 이상일 경우
						// 보내는 사람의 계좌 잔액을 이체금액 만큼 감소
						accountRepository.setSenderAccountBalance(senderAccountNumber, amount);
						// 받는 사람의 계좌 잔액을 이체금액 만큼 증가
						accountRepository.setReceiverAccountBalance(receiverAccountNumber, amount);
						
						return true;	// 이체 성공
					} else {
						return false;
					}
				} else {
					return false;
				}
			} else {
				return false;
			}
		}

	
	
	@Override
	public boolean checkAccount(String receiverAccountNumber) {
		if (accountRepository.checkAccount(receiverAccountNumber) == 1) {
			return true; 
			} else {
				return false;
//				throw new NonexistentAccountException("계좌를 다시 확인해주세요");
			}
		}


	@Override
	public int checkPassword(String accountNumber, int accountPassword) {
		if (accountRepository.checkPassword(accountNumber, accountPassword)==1) {
			return 1;
			} else {
				return 0;
//				throw new IncorrectPasswordException("비밀번호 틀림");
			}
		}
	
	@Override
	public boolean checkBalance(String senderAccountNumber, int amount) {
		int senderBalance = accountRepository.getSenderAccountBalance(senderAccountNumber);
		if (senderBalance >= amount) {
			return true;
			} else {
				return false;
//				throw new InsufficientBalanceException("잔액이 부족합니다");
			}
	}

	@Override
	public void createTransferTransaction(String senderAccountNumber, String receiverAccountNumber, int amount) {
		accountRepository.createTransferTransaction(senderAccountNumber, receiverAccountNumber, amount);
	}


	@Override
	public void createDepositTransaction(String accountNumber, int amount) {
		accountRepository.createDepositTransaction(accountNumber, amount);
	}


	@Override
	public List<Map<String, Object>> getAllAccountTypeName() {
		return accountRepository.getAllAccountTypeName();
	}

	@Override
	public void deleteAccount(String accountNumber, int accountPassword) {
		accountRepository.deleteAccount(accountNumber, accountPassword);
	}


	
	
	@Override
	public Account getAccountByAccountId(int accountId) {
		return accountRepository.getAccountByAccountId(accountId);
	}
	@Override
	public Account getAccountByAccountNumber(String accountNumber) {
		return accountRepository.getAccountByAccountNumber(accountNumber);
	}
	@Override
	public String getUserNameByAccountNumber(String accountNumber) {
		return accountRepository.getUserNameByAccountId(accountNumber);
	}
	@Override
	public void setAccountBalance(String accountNumber, int amount) {
		accountRepository.setReceiverAccountBalance(accountNumber, amount);
		
	}
	@Override
	public void createOnlyDepositTransaction(String accountNumber, int amount) {
		accountRepository.createOnlyDepositTransaction(accountNumber, amount);
		
	}

}
