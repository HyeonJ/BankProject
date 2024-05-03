package com.example.bank.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class AccountTypeRepository implements IAccountTypeRepository {
	@Autowired
	JdbcTemplate jdbcTemplate;
}
