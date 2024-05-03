package com.example.bank.controller;

import java.nio.charset.Charset;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.example.bank.model.Profile;
import com.example.bank.service.IProfileService;

@Controller
public class ProfileController {
	@Autowired
	IProfileService profileService;
	
	@GetMapping("/profile/file/{profileId}")
	public ResponseEntity<byte[]> getProfileImage(@PathVariable int profileId) {
		Profile profile = profileService.getProfile(profileId);
		final HttpHeaders headers = new HttpHeaders();
		if(profile != null) {
			String[] mtypes = profile.getFileContentType().split("/");
			headers.setContentType(new MediaType(mtypes[0], mtypes[1]));
			headers.setContentLength(profile.getFileSize());
			headers.setContentDispositionFormData("attachment", profile.getFileName(), Charset.forName("UTF-8"));
			return new ResponseEntity<byte[]>(profile.getFileData(), headers, HttpStatus.OK);
		} else {
			return new ResponseEntity<byte[]>(HttpStatus.NOT_FOUND);
		}
	}
}
