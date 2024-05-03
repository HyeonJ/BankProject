package com.example.bank.service;

import com.example.bank.model.User;

public interface IUserService {

	int getUserCount();

	User getUserInfo(int userId);
	User getUserInfoByEmail(String email);
	User getUserInfoByPhoneNumber(String phoneNumber);
	
	void insertUser(User user);
	
	void updateUser(User user);

}
