package com.example.bank.dao;

import com.example.bank.model.User;

public interface IUserRepository {

	int getUserCount();

	User getUserInfo(int userId);
	User getUserInfoByEmail(String email);
	User getUserInfoByPhoneNumber(String phoneNumber);

	void insertUser(User user);
	
	void updateUser(User user);

	// Get max user ID
	int getMaxUserId();

}
