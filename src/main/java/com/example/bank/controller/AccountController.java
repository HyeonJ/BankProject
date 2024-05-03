package com.example.bank.controller;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.bank.model.Account;
import com.example.bank.service.IAccountService;

@Controller
public class AccountController {

	@Autowired
	IAccountService accountService;
	
	@GetMapping("/account/create")
	public String createAccount(Model model) {
		model.addAttribute("types", accountService.getAllAccountType());
		return "account/createform";
	}
	
	
	@PostMapping("/account/create")
	public String createAccount(Account account, int accountTypeId, RedirectAttributes model, HttpSession session) {
		int userId = Integer.parseInt(session.getAttribute("userId").toString());
		try {
			accountService.createAccount(account, userId, accountTypeId);
			model.addFlashAttribute("message", " 코드 정상 작동 ");
		} catch (RuntimeException e) {
			System.out.println(e.getMessage());
			model.addFlashAttribute("message", e.getMessage());
		}
		return "redirect:/account/list";
	}
	
	@GetMapping("/account/delete")
	public String deleteAccount(Model model, HttpSession session) {
		int userId = Integer.parseInt(session.getAttribute("userId").toString());
		model.addAttribute("types", accountService.getAllAccountType());
		model.addAttribute("accounts", accountService.getAllAccountNumber(userId));
		return "account/deleteform";
	}
	
	@PostMapping("/account/delete")
	public String deleteAccount(String accountNumber, int accountPassword, HttpSession session) {
		int userId = Integer.parseInt(session.getAttribute("userId").toString());
		accountService.deleteAccount(accountNumber, accountPassword);
		return "redirect:/account/list";
	}
	
	@GetMapping("/account/list")
	public String accountList(Model model, HttpSession session) {
		int userId = Integer.parseInt(session.getAttribute("userId").toString());
		model.addAttribute("accountInfo", accountService.getUserAccountInfo(userId));
		model.addAttribute("accountTypeNames", accountService.getAllAccountTypeName());
		model.addAttribute("userId", userId);
		return "account/list";
	}
	
	@GetMapping("/account/transfer")
	public String transfer(@RequestParam(value="accountNumber", required=false) String accountNumber,
			Model model, HttpSession session) {
		int userId = Integer.parseInt(session.getAttribute("userId").toString());
		model.addAttribute("accounts", accountService.getAllAccountNumber(userId));
//		model.addAttribute("accountName", accountService.checkAccount(accountNumber));
		model.addAttribute("senderAccountNumber", accountNumber);

		return "account/transferform";
	}
	
	@PostMapping("/account/transfer")
	public String transfer(String senderAccountNumber, String receiverAccountNumber, int amount, int accountPassword,
			RedirectAttributes model, HttpSession session) {
		try {
			int userId = Integer.parseInt(session.getAttribute("userId").toString());
			boolean result = accountService.transfer(senderAccountNumber, receiverAccountNumber, accountPassword, amount);
			if (result) {
				// 이체 성공
				// 트랜잭션 테이블에 로그 생성
				accountService.createTransferTransaction(senderAccountNumber, receiverAccountNumber, amount);
				accountService.createDepositTransaction(receiverAccountNumber, amount);
				model.addFlashAttribute("message", " 이체 완료 ");
				
				return "redirect:/account/list/?userId=" + userId;
				
			} else {
				model.addFlashAttribute("message", " 이체 실패 ");
				return "redirect:/account/error";
				}
			
			}
		
			catch (Exception e) {
			// 예외 발생 시 트랜잭션 roll-back
				throw new RuntimeException("예상치 못한 오류가 발생했습니다.", e);
		}
		
	}
	
	// 계좌 입금 페이지를 반환하는 메서드
	@GetMapping("/account/deposit")
	public String deposit(Model model, HttpSession session) {
		int userId = Integer.parseInt(session.getAttribute("userId").toString());
		model.addAttribute("accounts", accountService.getAllAccountNumber(userId));
		return "account/depositform";
	}
	
	// 계좌 입금 요청을 처리하는 메서드
	@PostMapping("/account/deposit")
	public String deposit(String accountNumber, int amount,
			RedirectAttributes model, HttpSession session) {
		int userId = Integer.parseInt(session.getAttribute("userId").toString());
		try {
			accountService.createOnlyDepositTransaction(accountNumber, amount);
			accountService.setAccountBalance(accountNumber, amount);
			model.addFlashAttribute("message", "입금 완료");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			model.addFlashAttribute("message", e.getMessage());
		}
		
		return "redirect:/account/list/?userId=" + userId;
	}

}
