package com.example.bank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.bank.dao.IProfileRepository;
import com.example.bank.model.Profile;

@Service
public class ProfileService implements IProfileService {

	@Autowired
	IProfileRepository profileRepository;
	
	@Override
	public void uploadFile(Profile profile) {
		profile.setProfileId(profileRepository.getMaxProfileId() + 1);
		profileRepository.uploadFile(profile);
		
	}

	@Override
	public void deleteFile(int profileId) {
		profileRepository.deleteFile(profileId);
		
	}

	@Override
	public Profile getProfile(int profileId) {
		return profileRepository.getProfile(profileId);
	}

	@Override
	public Profile getProfileByUserId(int userId) {
		return profileRepository.getProfileByUserId(userId);
	}

	@Override
	public void deleteFileByAccountId(int accountId) {
		profileRepository.deleteFileByAccountId(accountId);
	}

}
