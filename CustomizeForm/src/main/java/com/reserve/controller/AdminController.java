package com.reserve.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.reserve.dto.ReserveQueryDto;
import com.reserve.mapper.ReserveRecordMapper;
import com.reserve.model.ReserveRecord;
import com.reserve.util.IdGenerator;
import com.reserve.util.SendEmailThread;

@Controller
public class AdminController extends BaseController{
//	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	ReserveRecordMapper reserveRecordMapper;
	
//	private final int EXPORT_BATCH_SIZE = 1000;
//	private final int PAGE_SIZE = 10;
	
	@RequestMapping(value = "/go",  method = RequestMethod.GET)
	@ResponseBody
	public String go() {
		return "go";
	}
	
	@RequestMapping(value = "/form",  method = RequestMethod.GET)
	public String form() {
		return "form";
	}
	
	/**
	 * 表单提交
	 * @param reserveRecord
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/form",  method = RequestMethod.POST)
	public String reserve(
			@RequestParam(value="name",required = true) String name,
			@RequestParam(value="mobile",required = true) String mobile,
			@RequestParam(value="idNumber",required = false) String idNumber,
			@RequestParam(value="reserveTimeDay",required = true) String reserveTimeDay,
			@RequestParam(value="reserveTimeHour",required = true) String reserveTimeHour,
			@RequestParam(value="reserveTimeMinu",required = true) String reserveTimeMinu,
			@RequestParam(value="description",required = true) String description,
			@RequestParam(value="file",required = false) MultipartFile file,
			Model model,
			HttpServletRequest request,
			HttpServletResponse response) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			String strDate = reserveTimeDay + " " + reserveTimeHour + ":" + reserveTimeMinu;
			Date reserveTime=sdf.parse(strDate);
			
			ReserveRecord record = new ReserveRecord();
			record.setId(IdGenerator.getInstance().nextId());
			record.setName(name);
			record.setMobile(mobile);
			record.setIdNumber(idNumber);
			record.setDescription(description);
			record.setReserveTime(reserveTime);
			record.setCreateTime(new Date());
			if (file != null) {
				record.setIdPhoto(file.getBytes());
			}
			reserveRecordMapper.insertSelective(record);
//			logger.error("insert success");

			SendEmailThread thread = new SendEmailThread(record);
			thread.start();
			return "success";
		} catch (Exception e) {
			ByteArrayOutputStream buf = new java.io.ByteArrayOutputStream();
			e.printStackTrace(new java.io.PrintWriter(buf, true));
			String expMessage = buf.toString();
			try {
				buf.close();
			} catch (Exception e2) {
			}
			model.addAttribute("info", expMessage);
			return "error";
		}
	}
	
	/**
	 * 获取记录
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/record/{id}",  method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> reserveById(
			@PathVariable("id") Long id,
			HttpServletRequest request,
			HttpServletResponse response) {
		try {
			ReserveRecord reserveRecord = reserveRecordMapper.selectByPrimaryKey(id);
			return success(reserveRecord);
		} catch (Exception e) {
			e.printStackTrace();
			return fail();
		}
	}
	
	/**
	 * 删除记录
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/record/delete/{id}",  method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> reserveDeleteById(
			@PathVariable("id") Long id,
			HttpServletRequest request,
			HttpServletResponse response) {
		try {
			int result = reserveRecordMapper.deleteByPrimaryKey(id);
			return success(result);
		} catch (Exception e) {
			e.printStackTrace();
			return fail();
		}
	}
	
	/**
	 * 照片
	 * @param id
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/photo/{id}",  method = RequestMethod.GET)
	public void reservePhotoById(
			@PathVariable("id") Long id,
			HttpServletRequest request,
			HttpServletResponse response) {
		try {
			ReserveRecord reserveRecord = reserveRecordMapper.selectByPrimaryKey(id);
			response.setHeader("Content-Type","image/jpeg");//设置响应的媒体类型，这样浏览器会识别出响应的是图片
			if (reserveRecord.getIdPhoto() != null){
				OutputStream out = response.getOutputStream();
				out.write(reserveRecord.getIdPhoto());
				out.flush();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 后台查询所有数据
	 * @param reserveQueryDto
	 * @param model
	 * @param request
	 * @param response
	 * @param pageable
	 * @return
	 */
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String adminList(
			ReserveQueryDto reserveQueryDto,
			Model model,
			HttpServletRequest request,
			HttpServletResponse response,
			@PageableDefault(page=0, size=10, sort="create_time", direction = Sort.Direction.DESC) Pageable pageable) {
		try { 
			
			Map<String, Object> param = createParam(reserveQueryDto,pageable);
			List<ReserveRecord> reserveRecords = reserveRecordMapper.selectSelective(param);
			int total = reserveRecordMapper.countSelectSelective(param);
			 
			Page<?> page = new PageImpl<ReserveRecord>(reserveRecords, pageable, total);
			model.addAttribute("page", page);
//			model.addAttribute("reserveRecords", reserveRecords);
			model.addAttribute("total", total);
			model.addAttribute("reserveQueryDto", reserveQueryDto);
			return "adminList";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
	
	/**
	 * 导出到excel中
	 * @param reserveQueryDto
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "/admin/export", method = RequestMethod.GET)
    public void exportOrderRecords(
    		ReserveQueryDto reserveQueryDto,
    		HttpServletResponse response) throws IOException {
        
        OutputStream out = response.getOutputStream();
    	response.setHeader("Content-Disposition", "attachment; filename=\"" + "data.xls\"");
    	exportReserveRecords(reserveQueryDto, out);
        out.flush();
    }

	/**
	 * 构造参数
	 * @param reserveQueryDto
	 * @return
	 */
	private Map<String, Object> createParam(ReserveQueryDto reserveQueryDto, Pageable pageable) {
		Map<String, Object> param = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(reserveQueryDto.getQueryName())) {
			param.put("name", reserveQueryDto.getQueryName());
		}
		if (StringUtils.isNotBlank(reserveQueryDto.getQueryMobile())) {
			param.put("mobile", reserveQueryDto.getQueryMobile());
		}
		param.put("startTime", reserveQueryDto.getQueryStartTime());
		param.put("endTime", reserveQueryDto.getQueryEndTime());
		if (pageable != null) {
			param.put("offset", pageable.getPageNumber() * pageable.getPageSize());
			param.put("pageSize", pageable.getPageSize());
		}
		return param;
	}
	
		
	/**
	 * 导出excel
	 * @return
	 */
	public void exportReserveRecords(ReserveQueryDto reserveQueryDto, OutputStream out) throws IOException{
        int cell = 0;
        Workbook wb = new HSSFWorkbook();
        Sheet sheet = wb.createSheet("new sheet");
        Row row = sheet.createRow((short)0);
        row.createCell(cell++).setCellValue("序号");
        row.createCell(cell++).setCellValue("姓名");
        row.createCell(cell++).setCellValue("手机号");
        row.createCell(cell++).setCellValue("身份证号码");
        row.createCell(cell++).setCellValue("预约时间");
        row.createCell(cell++).setCellValue("情况说明");
        row.createCell(cell++).setCellValue("提交时间");
        
        Map<String, Object> param = createParam(reserveQueryDto,null);
        List<ReserveRecord> reserveRecords = reserveRecordMapper.selectSelective(param);
		int rowIndex = 0;
		for(int j = 0; j < reserveRecords.size(); j++) {
        	cell = 0;
        	ReserveRecord reserveRecord = reserveRecords.get(j);
        	if(reserveRecord != null){
        		row = sheet.createRow(++rowIndex);
                row.createCell(cell++).setCellValue(rowIndex);
                row.createCell(cell++).setCellValue(reserveRecord.getName());
                row.createCell(cell++).setCellValue(reserveRecord.getMobile());
                row.createCell(cell++).setCellValue(reserveRecord.getIdNumber());
                row.createCell(cell++).setCellValue(reserveRecord.getReserveTimeStr());
                row.createCell(cell++).setCellValue(reserveRecord.getDescription());
                row.createCell(cell++).setCellValue(reserveRecord.getCreateTimeStr());
        	}  
        }
        wb.write(out);
        wb.close();
    }
	
	@InitBinder    
	public void initBinder(WebDataBinder binder) {    
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");    
        dateFormat.setLenient(false);    
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));    
	}	
}
