package com.example.bank.dao;


import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.bank.model.User;

@Repository
public class UserRepository implements IUserRepository {
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private class UserMapper implements RowMapper<User> {

		@Override
		public User mapRow(ResultSet rs, int rowNum) throws SQLException {
			User user = new User();
			user.setUserId(rs.getInt("user_id"));
			user.setEmail(rs.getString("email"));
			user.setPassword(rs.getString("password"));
			user.setName(rs.getString("name"));
			user.setPhoneNumber(rs.getString("phone_number"));
			user.setAddress(rs.getString("address"));
			return user;
		}
	}
	
	@Override
	public int getUserCount() {
		String sql = "select count(*) from users";
		//String sql = "select count(*) from employees";
		System.out.println("UserRepository - getUserCount");
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}
	
	@Override
	public User getUserInfo(int userId) {
		String sql = "select user_id, email, password, "
				+ "name, phone_number, address "
				+ "from users where user_id=?";
		try {
			return jdbcTemplate.queryForObject(sql, new UserMapper(), userId);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public User getUserInfoByEmail(String email) {
		String sql = "select user_id, email, password, "
				+ "name, phone_number, address "
				+ "from users where email=?";
		try {
			return jdbcTemplate.queryForObject(sql, new UserMapper(), email);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public User getUserInfoByPhoneNumber(String phoneNumber) {
		String sql = "select user_id, email, password, "
				+ "name, phone_number, address "
				+ "from users where phone_number=?";
		try {
			return jdbcTemplate.queryForObject(sql, new UserMapper(), phoneNumber);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public void insertUser(User user) {
		String sql = "INSERT INTO users (user_id, email, "
				+ "password, name, phone_number, address) "
				+ "VALUES (?,?,?,?,?,?)";
		jdbcTemplate.update(sql, user.getUserId(), user.getEmail(), user.getPassword(),
				user.getName(), user.getPhoneNumber(), user.getAddress());
	}
	
	@Override
	public int getMaxUserId() {
		String sql = "select NVL(MAX(user_id), 0) from users";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	@Override
	public void updateUser(User user) {
		String sql = "UPDATE users "
				+ "SET name=?, phone_number=?, address=? "
				+ "WHERE user_id=?";
		jdbcTemplate.update(sql, user.getName(), user.getPhoneNumber(),
				user.getAddress(), user.getUserId());
	}
}
