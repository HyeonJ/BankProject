package com.example.bank.service;

import com.example.bank.model.Profile;

public interface IProfileService {

	Profile getProfile(int profileId);
	Profile getProfileByUserId(int userId);
	
	void uploadFile(Profile profile);

	void deleteFile(int profileId);
	void deleteFileByAccountId(int accountId);
}
