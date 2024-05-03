package com.example.bank.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter
@ToString
public class Profile {
	private int profileId;
	private int userId;
	private String fileName;
	private long fileSize;
	private String fileContentType;
	private byte[] fileData;
}
