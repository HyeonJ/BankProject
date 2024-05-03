package com.example.bank.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// Context root 수정으로 인해 '/bank' 제거
		String[] excludePaths = {"/", "/main", "/login", "/signup"};

        String requestURI = request.getRequestURI();
        
        // 제외할 경로인지 확인
        for (String path : excludePaths) {
            if (requestURI.equals(path)) {
                return true;
            }
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
    		// Context root 수정으로 인해 '/bank' 제거
            response.sendRedirect("/login"); // 로그인 페이지로 리다이렉트
            return false;
        }

        return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
