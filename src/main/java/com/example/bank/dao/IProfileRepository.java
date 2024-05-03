package com.example.bank.dao;

import com.example.bank.model.Profile;

public interface IProfileRepository {

	Profile getProfile(int profileId);
	Profile getProfileByUserId(int userId);
	
	void uploadFile(Profile profile);

	void deleteFile(int profileId);
	void deleteFileByAccountId(int accountId);
	
	int getMaxProfileId();

	

}
