package com.example.bank.service;

import java.io.ByteArrayOutputStream;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.aspose.pdf.BorderInfo;
import com.aspose.pdf.BorderSide;
import com.aspose.pdf.Cell;
import com.aspose.pdf.Color;
import com.aspose.pdf.Document;
import com.aspose.pdf.Font;
import com.aspose.pdf.FontRepository;
import com.aspose.pdf.MarginInfo;
import com.aspose.pdf.Page;
import com.aspose.pdf.Position;
import com.aspose.pdf.Row;
import com.aspose.pdf.Table;
import com.aspose.pdf.TextFragment;
import com.example.bank.dao.ITransactionRepository;
import com.example.bank.model.Transaction;

@Service
public class TransactionService implements ITransactionService {

	@Autowired
	ITransactionRepository transactionRepository;
	
	@Autowired
    private ServletContext servletContext;
	
	@Override
	public List<Map<String, Object>> getTransactionListByAccountId(int accountId) {
//		List<Map<String, Object>> transactionList = transactionRepository.getTransactionListByAccountId(accountId);
//		for(int i=0; i<transactionList.size(); i++) {
//			Map<String, Object> map = transactionList.get(i);
//			for(String key: map.keySet()) {
//				if(map.get(key) == null) {
//					map.put(key, "");
//				}
//			}
//		}
		return transactionRepository.getTransactionListByAccountId(accountId);
	}
	
	@Override
	public byte[] transactionsToPDF(int accountId) {
		List<Map<String, Object>> transactions = transactionRepository.getTransactionListByAccountId(accountId);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
        Document document = new Document();
        Page page = document.getPages().add();
        
        MarginInfo marginInfo = new MarginInfo();
        marginInfo.setTop(50);
        marginInfo.setBottom(50);
        marginInfo.setLeft(50);
        marginInfo.setRight(50);
        page.getPageInfo().setMargin(marginInfo);

        // Load Korean font
        String relativeFontPath = "/resources/font/YangJuByeolsan.otf"; // 폰트 파일 이름을 정확히 지정하세요.
        String absoluteFontPath = servletContext.getRealPath(relativeFontPath);
        Font font = FontRepository.openFont(absoluteFontPath);

        // Create title with Korean font
        TextFragment title = new TextFragment("거래 내역");
        title.setPosition(new Position(60, 750));
        title.getTextState().setFont(font);
        title.getTextState().setFontSize(14);
        page.getParagraphs().add(title);

        // Create a table with Korean font
        Table table = new Table();
        table.setTop((float) (120));
        table.setColumnWidths("90 40 70 100 100 100");
        table.setDefaultCellPadding(new MarginInfo(10, 5, 10, 5));
        table.setBorder(new BorderInfo(BorderSide.All, 1.2F, Color.getBlack()));
        table.setDefaultCellBorder(new BorderInfo(BorderSide.All, 0.8F, Color.getGray()));

        // Add header row
        com.aspose.pdf.Row headerRow = table.getRows().add();
        addCell(headerRow, "날짜", font);
        addCell(headerRow, "구분", font);
        addCell(headerRow, "거래자명", font);
        addCell(headerRow, "출금액", font);
        addCell(headerRow, "입금액", font);
        addCell(headerRow, "잔액", font);

        // Populate data rows
        for (Map<String, Object> transaction : transactions) {
        	String amountTransfer = getMapValue(transaction.get("amountTransfer"));
        	String name = getMapValue(transaction.get("name"));
        	amountTransfer = amountTransfer.equals("") ? "" : "-" + amountTransfer;
        	name = name.equals("") ? "본인 이체" : name;
        	
            Row row = table.getRows().add();
            addCell(row, formatter.format(transaction.get("transactionDate")), font);
            addCell(row, getKoreanType(transaction.get("type").toString()), font);
            addCell(row, name, font);
            addCell(row, addUnit(amountTransfer), font);
            addCell(row, addUnit(getMapValue(transaction.get("amountDeposit"))), font);
            addCell(row, addUnit(getMapValue(transaction.get("amountAccount"))), font);
        }

        // Add table to page
        page.getParagraphs().add(table);

        // Save PDF document
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        document.save(outputStream);
        document.close();

        return outputStream.toByteArray();
    }
	
	private String getMapValue(Object obj) {
		if(obj == null || (isNumeric(obj.toString()) && Integer.parseInt(obj.toString()) == 0))
			return "";
		else
			return obj.toString();
	}
	
	private String getKoreanType(String type) {
		if(type.equals("deposit"))
			return "입금";
		else if(type.equals("transfer"));
			return "이체";
	}
	
	private String addUnit(String amount) {
		if(amount.equals("")) {
			return "";
		} else {
			int num = Integer.parseInt(amount);
			NumberFormat formatter = NumberFormat.getNumberInstance(Locale.US);
			return formatter.format(num) + "원";
		}
	}
	
	public boolean isNumeric(String strNum) {
        if (strNum == null) {
            return false;
        }
        return strNum.matches("-?\\d+(\\.\\d+)?");  // 음수, 소수 포함 숫자 패턴
    }

    private void addCell(Row row, String text, Font font) {
        TextFragment textFragment = new TextFragment(text);
        textFragment.getTextState().setFont(font);
        Cell cell = row.getCells().add();
        cell.getParagraphs().add(textFragment);
    }

	@Override
	public int getTransactionTotalPageCount(int accountId) {
		return transactionRepository.getTransactionTotalPageCount(accountId);
	}

	@Override
	public List<Map<String, Object>> getTransactionListWithPaging(int accountId, int page) {
		return transactionRepository.getTransactionListWithPaging(accountId, page);
	}

}
