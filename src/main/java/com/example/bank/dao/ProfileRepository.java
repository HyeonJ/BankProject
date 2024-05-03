package com.example.bank.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.example.bank.model.Profile;
import com.example.bank.model.User;

@Repository
public class ProfileRepository implements IProfileRepository {
	@Autowired
	JdbcTemplate jdbcTemplate;

	private class ProfileMapper implements RowMapper<Profile> {

		@Override
		public Profile mapRow(ResultSet rs, int rowNum) throws SQLException {
			Profile profile = new Profile();
			profile.setProfileId(rs.getInt("profile_id"));
			profile.setUserId(rs.getInt("user_id"));
			profile.setFileName(rs.getString("file_name"));
			profile.setFileSize(rs.getLong("file_size"));
			profile.setFileContentType(rs.getString("file_content_type"));
			profile.setFileData(rs.getBytes("file_data"));
			return profile;
		}
	}
	
	@Override
	public void uploadFile(Profile profile) {
		String sql = "INSERT INTO profiles "
				+ "(profile_id, user_id, file_name, file_size, "
				+ "file_content_type, file_data) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		jdbcTemplate.update(sql, profile.getProfileId(), profile.getUserId(),
				profile.getFileName(), profile.getFileSize(), profile.getFileContentType(), profile.getFileData());
	}
	
	@Override
	public int getMaxProfileId() {
		String sql = "SELECT NVL(MAX(profile_id), 0) FROM profiles";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	@Override
	public void deleteFile(int profileId) {
		String sql = "DELETE FROM profiles WHERE profile_id=?";
		jdbcTemplate.update(sql, profileId);
		
	}

	@Override
	public void deleteFileByAccountId(int accountId) {
		String sql = "DELETE FROM profiles WHERE account_id=?";
		jdbcTemplate.update(sql, accountId);
	}

	@Override
	public Profile getProfile(int profileId) {
		String sql = "SELECT profile_id, user_id, file_name, file_size, "
				+ "file_content_type, file_data FROM profiles WHERE profile_id=?";
		try {
			return jdbcTemplate.queryForObject(sql, new ProfileMapper(), profileId);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public Profile getProfileByUserId(int userId) {
		String sql = "SELECT profile_id, user_id, file_name, file_size, "
				+ "file_content_type, file_data FROM profiles WHERE user_id=?";
		try {
			return jdbcTemplate.queryForObject(sql, new ProfileMapper(), userId);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}
}
