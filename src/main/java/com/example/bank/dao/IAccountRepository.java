package com.example.bank.dao;

import java.util.List;
import java.util.Map;

import com.example.bank.model.Account;

public interface IAccountRepository {
	int getMaxAccountId();	// 계좌를 새로 만들때 account id를 1씩 증가시키기 위한 메서드
	void createAccount(Account account, int userId, int accountTypeId);	// accountTypeId를 받은 이유는 계좌번호 생성할 때 써야해서
	List<Map<String, Object>> getAllAccountType();	// view의 select box에 보여질 리스트
	
	// 계좌번호 생성 규칙은  계좌타입 + nonce + 연락처
	// 형식은 ***-******-****
	String accountNumberGenerator(int accountTypeId, int accountId, int userId);
	
	// 계좌조회 페이지에 렌더링될 값들
	List<Map<String, Object>> getAllAccountTypeName();
	List<Map<String, Object>> getUserAccountInfo(int userId);
	
	// 계좌 삭제
	void deleteAccount(String accountNumber, int accountPassword);
	// 계좌이체 구현
	// 보내는 사람의 계좌 잔액 확인
	// if (보내는 계좌 잔액 >= 이체 금액 && 비밀번호 일치)
	// 	set(보내는 계좌 잔액) = 보내는 계좌 잔액 - 이체 금액
	//	set(받는 계좌 잔액) = 받는 계좌 잔액 + 이체 금액
	// 예외 발생 시 트랜잭션 처리 필요 -> @Transactional 사용
	// 보내는 계좌 : accountId,	받는 계좌 : destinationAccountId
	void createTransferTransaction(String senderAccountNumber, String receiverAccountNumber, int amount);
	void createDepositTransaction(String accountNumber, int amount);
	int getMaxTransactionId();	// 트랜잭션 id 생성시 필요
	List<Map<String, Object>> getAllAccountNumber(int accountId);	// transferform select box에 사용
	int getDestinationIdByAccountNumber(String accountNumber);	// form에서 얻은 계좌번호를 통해 destination_account_id에 저장될 값을 얻기 위해
	int getSenderAccountBalance(String accountNumber);	// transfer 기능에서 보내는 사람의 잔액을 조회
	void setSenderAccountBalance(String accountNumber, int amount);	// transfer 기능에서 보내는 사람의 잔액을 amount 만큼 감소
	void setReceiverAccountBalance(String accountNumber, int amount);	// transfer 기능에서 받는 사람의 잔액을 amount 만큼 증가
	int checkAccount(String accountNumber);
	int checkPassword(String accountNumber, int accountPassword);

	Account getAccountByAccountId(int accountId);
	Account getAccountByAccountNumber(String accountNumber);
	String getUserNameByAccountId(String accountNumber);
	List<Account> getAccountListByUserId(int userId);
	void createOnlyDepositTransaction(String accountNumber, int amount);
}
