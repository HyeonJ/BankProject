package com.example.bank.controller;

import java.nio.charset.Charset;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.bank.model.Profile;
import com.example.bank.model.User;
import com.example.bank.service.IProfileService;
import com.example.bank.service.IUserService;

@Controller
public class UserController {
	
	@Autowired
	IUserService userService;
	
	@Autowired
	IProfileService profileService;
	
	
	// 메인 홈페이지를 반환하는 메서드
	@GetMapping({"", "/main"})
	public String main(Model model) {
		return "main";
	}
	
	// 로그인 페이지를 반환하는 메서드
	@GetMapping("/login")
	public String login(Model model) {
		return "loginform";
	}
	
	// 로그인 요청을 처리하는 메서드
    @PostMapping("/login")
    public String login(@RequestParam("email") String email, @RequestParam("password") String password,
                        Model model, HttpSession session) {
        User user = userService.getUserInfoByEmail(email);
        if(user != null && user.getPassword().equals(password)) { //null체크 추가
            session.setAttribute("email", email);
            session.setAttribute("userId", user.getUserId());
            return "redirect:/";
        } else {
            session.setAttribute("loginFailed", true); //로그인실패 ...
            return "redirect:/login"; //redirect:/loginform->login으로 변경
        }
    }
	
    // 로그아웃 요청을 처리하는 메서드
	@GetMapping("/logout")
	public String logout(Model model, HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// 회원가입 페이지를 반환하는 메서드
	@GetMapping("/signup")
	public String signUp(Model model) {
			return "signupform";
	}
	
	// 회원가입 요청을 처리하는 메서드
	@PostMapping("/signup")
	public String signUp(User user, MultipartFile file, RedirectAttributes model,
			HttpSession session) {
		try {
			userService.insertUser(user);
			User newUser = userService.getUserInfoByEmail(user.getEmail());
			if(file != null && !file.isEmpty()) {
				Profile profile = new Profile();
				profile.setUserId(newUser.getUserId());
				profile.setFileName(file.getOriginalFilename());
				profile.setFileSize(file.getSize());
				profile.setFileContentType(file.getContentType());
				profile.setFileData(file.getBytes());
				profileService.uploadFile(profile);
			}
			model.addFlashAttribute("message", "회원가입에 성공하였습니다.");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			model.addFlashAttribute("message", e.getMessage());
		}
		return "redirect:/login";
	}
	
	// 마이페이지 페이지를 반환하는 메서드
	@GetMapping("/user/mypage")
	public String myPage(Model model, HttpSession session) {
		// user의 정보를 model에 넘겨주고, 사진 업로드, 삭제 위해 profileId를 넘겨줘야 함
		int userId = Integer.parseInt(session.getAttribute("userId").toString());
		User user = userService.getUserInfo(userId);
		
		// profile id 받아오기
		Profile profile = profileService.getProfileByUserId(userId);
		int profileId = profile == null ? -1 : profile.getProfileId();
		
		model.addAttribute("user", user);
		model.addAttribute("profileId", profileId);
		return "user/mypage_new";
	}
	
	// 마이페이지, 회원정보 수정 요청을 처리하는 메서드
	@PostMapping("/user/mypage")
	public String modifyUser(
			User user, MultipartFile file, String isProfileDeleted,
			RedirectAttributes model, HttpSession session) {
		int userId = Integer.parseInt(session.getAttribute("userId").toString());
		
		User modifiedUser = userService.getUserInfo(userId);
		//modifiedUser.setName(user.getName());
		modifiedUser.setPhoneNumber(user.getPhoneNumber());
		modifiedUser.setAddress(user.getAddress());
		userService.updateUser(modifiedUser);
		
		try {
			if((file != null && !file.isEmpty()) || isProfileDeleted.equals("true")) {
				Profile profile = profileService.getProfileByUserId(userId);
				if(profile != null) {
					profileService.deleteFile(profile.getProfileId());
				}
				
				if(isProfileDeleted.equals("false")) {
					profile = new Profile();
					profile.setUserId(userId);
					profile.setFileName(file.getOriginalFilename());
					profile.setFileSize(file.getSize());
					profile.setFileContentType(file.getContentType());
					profile.setFileData(file.getBytes());
					profileService.uploadFile(profile);
				}
			}
			model.addFlashAttribute("message", "프로필 사진 수정에 성공하였습니다.");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			model.addFlashAttribute("message", e.getMessage());
		}
		
		return "redirect:/user/mypage";
	}

	// AJAX Email 중복 확인
	@PostMapping("/user/validate/email")
	public ResponseEntity<Map<String, Object>> validateEmail(@RequestParam String email, Model model) {
		User user = userService.getUserInfoByEmail(email);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(user == null)
			map.put("result", "success");
		else
			map.put("result", "failed");
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	// AJAX Phone 중복 확인
	@PostMapping("/user/validate/phone")
	public ResponseEntity<Map<String, Object>> validatePhoneNumber(@RequestParam String phoneNumber, Model model) {
		User user = userService.getUserInfoByPhoneNumber(phoneNumber);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(user == null)
			map.put("result", "success");	
		else
			map.put("result", "failed");
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
}
