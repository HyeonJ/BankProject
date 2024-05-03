package com.example.bank.handler;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.slf4j.Slf4j;

@ControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException e, Model model){
		model.addAttribute("message", "요청하신 페이지를 찾을 수 없습니다.");
		return "error/404";
	}
	
	@ExceptionHandler({Exception.class})
	public String handleAll(final Exception e, Model model) {
		log.info(e.getClass().getName());
		log.error("error", e);
		model.addAttribute("message", "오류가 발생했습니다. 문제를 해결하기 위해 최선을 다하고 있습니다. 잠시 후 다시 시도해 주세요.");
		return "error/500";
	}
}
