package com.example.bank.controller;

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

import com.example.bank.model.Account;
import com.example.bank.model.User;
import com.example.bank.service.IAccountService;
import com.example.bank.service.ITransactionService;
import com.example.bank.service.IUserService;

@Controller
public class ApiController {
	
	@Autowired
	IUserService userService;
	
	@Autowired
	IAccountService accountService;
	
	@Autowired
	ITransactionService transactionService;
	
	// 이메일 중복 확인 API
	@PostMapping("/api/user/validate/email")
	public ResponseEntity<Map<String, Object>> validateEmail(@RequestParam String email, Model model) {
		User user = userService.getUserInfoByEmail(email);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(user == null)
			map.put("result", "success");
		else
			map.put("result", "failed");
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	// 핸드폰 번호 중복 확인 API
	@PostMapping("/api/user/validate/phone")
	public ResponseEntity<Map<String, Object>> validatePhoneNumber(@RequestParam String phoneNumber, Model model) {
		User user = userService.getUserInfoByPhoneNumber(phoneNumber);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(user == null)
			map.put("result", "success");	
		else
			map.put("result", "failed");
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	// 이메일 중복 확인 API
	@PostMapping("/api/user/validate/password")
	public ResponseEntity<Map<String, Object>> validateUserPassword(@RequestParam String password, Model model,
			HttpSession session) {
		int userId = Integer.parseInt(session.getAttribute("userId").toString());
		User user = userService.getUserInfo(userId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(user.getPassword().equals(password)) {
			map.put("result", "success");
			// 현재 user의 password와 입력한 password가 일치
		} else {
			map.put("result", "failed");
			// 현재 user의 password와 입력한 password가 일치하지 않음
		}
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	
	// AJAX 계좌 비밀번호 확인
    @PostMapping("/api/account/validate/password/{accountId}")
	public ResponseEntity<Map<String, Object>> validatePassword(@PathVariable int accountId,
			@RequestParam int password, Model model, HttpSession session) {
    	Map<String, Object> map = new HashMap<String, Object>();
    	
		Account account = accountService.getAccountByAccountId(accountId);
		
		if(account != null && account.getAccountPassword() == password)
			map.put("result", "success");	
		else
			map.put("result", "failed");
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	
	// AJAX 계좌번호 확인
    @PostMapping("/api/account/validate/account")
	public ResponseEntity<Map<String, Object>> validatePassword(@RequestParam String accountNumber, Model model) {
		String userName = accountService.getUserNameByAccountNumber(accountNumber);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(!userName.equals("")) {
			map.put("result", "success");
			map.put("name", userName);
		}
		else {
			map.put("result", "failed");
			map.put("name", "존재하지 않는 계좌번호 입니다.");
		}
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
    
    // AJAX 계좌번호, 비밀번호 확인
    @PostMapping("/api/account/validate/account/password")
	public ResponseEntity<Map<String, Object>> validateAccountPassword(String accountNumber, int accountPassword, Model model) {
    	Map<String, Object> map = new HashMap<String, Object>();
    	if(accountService.checkPassword(accountNumber, accountPassword) == 1) {
    		map.put("result", "success");
		} else {
			map.put("result", "failed");
		}
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
    
 // AJAX 상대방 계좌가 존재하는지 확인
    @PostMapping("/api/account/validate/account/transfer")
    public ResponseEntity<Map<String, Object>> validateTransfer(String accountNumber, String receiverAccountNumber, int accountPassword, int amount, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
       
        if(accountService.checkPassword(accountNumber, accountPassword) != 1) {
        	// 비밀번호 X
        	map.put("result", "failed");
        	map.put("message", "비밀번호가 일치하지 않습니다.");
           } else if (!accountService.checkAccount(receiverAccountNumber)) {
        	   // 계좌 X
	           	map.put("result", "failed");
	           	map.put("message", "없는 계좌번호 입니다.");
           } else if (!accountService.checkBalance(accountNumber, amount)) {
        	   // 잔액 X
	           	map.put("result", "failed");
	           	map.put("message", "잔액을 확인해주세요.");
           } else {
        	   map.put("result", "success");
           }

       return new ResponseEntity<>(map, HttpStatus.OK);
    }
    
    // AJAX 계좌 삭제
    @PostMapping("/api/account/validate/account/delete")
    public ResponseEntity<Map<String, Object>> validatePassword(String accountNumber, int accountPassword, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
       
        if(accountService.checkPassword(accountNumber, accountPassword) != 1) {
        	map.put("result", "failed");
        	map.put("message", "비밀번호가 일치하지 않습니다.");
           } else {
        	   map.put("result", "success");
           }

       return new ResponseEntity<>(map, HttpStatus.OK);
    }
    
	
	@ResponseBody
    @GetMapping("/api/transaction/list/{accountId}")
    public ResponseEntity<List<Map<String, Object>>> getTransactionListByAccount(@PathVariable int accountId,
    		@RequestParam(value="page", required=false, defaultValue="1") int page, Model model) {
		List<Map<String, Object>> list = transactionService.getTransactionListWithPaging(accountId, page);
		model.addAttribute("page", page);
    	return new ResponseEntity<List<Map<String, Object>>>(transactionService.getTransactionListWithPaging(accountId, page),
    			HttpStatus.OK);
	}
}
