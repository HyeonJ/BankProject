package com.example.bank.controller;

import java.io.ByteArrayInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.bank.model.Account;
import com.example.bank.model.Transaction;
import com.example.bank.service.IAccountService;
import com.example.bank.service.ITransactionService;

@Controller
public class TransactionController {
	
	@Autowired
	ITransactionService transactionService;
	
	@Autowired
	IAccountService accountService;
	
	// 거래내역 조회 페이지를 반환하는 메서드
	@GetMapping("/transaction/{accountId}")
	   public String getTransactionList(@PathVariable int accountId, Model model, HttpSession session) {
	       int userId = Integer.parseInt(session.getAttribute("userId").toString());
	       // 사용자의 계좌 목록
	       List<Account> accountList = accountService.getAccountListByUserId(userId);
	       // accountId가 사용자의 계좌 목록에 속하는지 확인
	       boolean isAccountValid = accountList.stream().anyMatch(account -> account.getAccountId() == accountId);

	       if (!isAccountValid) {
	           // accountId가 유효하지 않은 경우 error/404 페이지로 리다이렉트
	           return "redirect:/error/404";
	       }
	       model.addAttribute("transactionList", transactionService.getTransactionListByAccountId(accountId));
	       model.addAttribute("totalPages", transactionService.getTransactionTotalPageCount(accountId));
	       model.addAttribute("accountList", accountList);
	       return "transaction/list";
	   }
	
	// 거래내역 pdf 파일을 다운로드하는 메서드
//	@GetMapping("/transaction/download/{accountId}")
//    public ResponseEntity<byte[]> downloadTransactionsAsPDF(@PathVariable int accountId) {
//        byte[] pdfData = transactionService.transactionsToPDF(accountId);
//        Account account = accountService.getAccountByAccountId(accountId);
//        String userName = accountService.getUserNameByAccountNumber(account.getAccountNumber());
//
//        HttpHeaders headers = new HttpHeaders();
//        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=거래내역서.pdf"); // 거래내역서_정현인_날짜.pdf 이게 좋으려나
//
//        return ResponseEntity.ok()
//                             .headers(headers)
//                             .body(pdfData);
//    }
    
    @GetMapping("/transaction/download/{accountId}")
    public ResponseEntity<byte[]> downloadTransactionsAsPDF(@PathVariable int accountId) {
        byte[] pdfData = transactionService.transactionsToPDF(accountId);
        Account account = accountService.getAccountByAccountId(accountId);
        String userName = accountService.getUserNameByAccountNumber(account.getAccountNumber());
        
        LocalDate now = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        String formattedDate = now.format(formatter);
        
        String fileName = "거래내역서_" + userName +"_" + formattedDate +".pdf";
        
        String encodedFileName = "거래내역서";
		try {
			encodedFileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8.toString()).replace("+", "%20");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename*=UTF-8''" + encodedFileName);

        return ResponseEntity.ok()
                             .headers(headers)
                             .body(pdfData);
    }
}
