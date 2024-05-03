package com.example.bank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.bank.dao.IUserRepository;
import com.example.bank.model.User;

@Service
public class UserService implements IUserService {
	
	@Autowired
	IUserRepository userRepository;
	
	@Override
	public int getUserCount() {
		return userRepository.getUserCount();
	}
	
	@Override
	public User getUserInfo(int userId) {
		return userRepository.getUserInfo(userId);
	}

	@Override
	public User getUserInfoByEmail(String email) {
		return userRepository.getUserInfoByEmail(email);
	}

	@Override
	public User getUserInfoByPhoneNumber(String phoneNumber) {
		return userRepository.getUserInfoByPhoneNumber(phoneNumber);
	}

	@Override
	public void insertUser(User user) {
		user.setUserId(userRepository.getMaxUserId() + 1);
		userRepository.insertUser(user);
	}

	@Override
	public void updateUser(User user) {
		userRepository.updateUser(user);
		
	}
}
