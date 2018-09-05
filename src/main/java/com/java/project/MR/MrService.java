package com.java.project.MR;

import java.io.IOException;
import java.net.URI;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.record.CsvRecordOutput;
import org.apache.hadoop.yarn.webapp.hamlet.HamletSpec.MAP;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.java.project.DAO.DaoInterface;
import com.java.project.Util.MapUtil;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

@Service
public class MrService implements MrServiceInterface {
	@Resource(name="hdConf")
	Configuration conf;
	@Inject
	DaoInterface di;
	/*
	public ResponseEntity<HashMap<String, Object>> saveData(String inDate,String inTime) throws Throwable{
		Map<String,Object> param = MapUtil.makeParam("selectList", "productviews.allList");
		Job job = Job.getInstance(conf,"test");
		FileSystem file = FileSystem.get(conf);
		FSDataOutputStream fsos = file.create(new Path("/insert/"+inDate+"/"+inTime+"/data.csv")); // 출력 객체 생성
		List<HashMap<String, Object>> list = (List<HashMap<String, Object>>) di.call(param);
		String result = "";
		List<String> textList = new ArrayList<String>();
		//System.out.println( String.format("키 : %s, 값 : %s", key, map.get(key)) ); 참고 : http://stove99.tistory.com/96 
		for(int i=0;i<list.size();i++) {
			for(String key :list.get(i).keySet()) {
				if(key.equals("date")) {
					SimpleDateFormat d = new SimpleDateFormat("yyyy/MM");
					result += d.format(list.get(i).get(key));
				}
				else {
					result += String.format("%s", list.get(i).get(key)).replace(",", "/");
				}
				result += ",";
			}
			result = result.substring(0, result.length()-1);
			System.out.println(result.length());
			result+="\n";
			
			if(result.length()>20000) {
				textList.add(result);
				result = "";
			}
		}
		for(int j=0;j<textList.size();j++) {
			System.out.println(textList.get(j).length());
			fsos.writeUTF(textList.get(j));						 // 내용작성
		}
		System.out.println(textList.size());
		fsos.writeUTF(result);						 // 내용작성
		
		fsos.close();								 // 출력 객체 종료
		file.close();
		System.out.println("끝");
		return null;
	}
	*/

	public ResponseEntity<HashMap<String, Object>> saveData(String inDate,String inTime) throws Throwable{
		Map<String,Object> param = MapUtil.makeParam("selectList", "productviews.allList");
		List<HashMap<String, Object>> list = (List<HashMap<String, Object>>) di.call(param);
		for(int i=0;i<list.size()/600;i++) {
			List<HashMap<String, Object>> list2 = new ArrayList<HashMap<String, Object>>();
			for(int j=(i*600);j<((6*(i+1))*100);j++) {
				list2.add(list.get(j));
			}
			Job job = Job.getInstance(conf,"test");
			FileSystem file = FileSystem.get(conf);
			FSDataOutputStream fsos = file.create(new Path("/insert/"+inDate+"/"+inTime+"/data"+i+".csv")); // 출력 객체 생성
			String result = "";
			List<String> textList = new ArrayList<String>();
			//System.out.println( String.format("키 : %s, 값 : %s", key, map.get(key)) ); 참고 : http://stove99.tistory.com/96 
			for(int k=0;k<list2.size();k++) {
				for(String key :list2.get(k).keySet()) {
					if(key.equals("date")) {
						SimpleDateFormat d = new SimpleDateFormat("yyyy/MM");
						result += d.format(list2.get(k).get(key));
					}
					else {
						result += String.format("%s", list2.get(k).get(key)).replace(",", "/");
					}
					result += ",";
				}
				result = result.substring(0, result.length()-1);
				System.out.println(result.length());
				result+="\n";
			}
			System.out.println(textList.size());
			fsos.writeUTF(result);						 // 내용작성
			
			fsos.close();								 // 출력 객체 종료
			file.close();
		}
		System.out.println("끝");
		return null;
	}
		
	static int count = 0;
	@Override
	public ResponseEntity<HashMap<String, Object>> reader(String inDate, String inTime) throws Throwable {
		//0 중분류, 1. 소분류, 2. 가격대별, 3. 색상
		for(count=0;count<4;count++) {
			System.out.println(count);
			Job job = Job.getInstance(conf, "user");
	
			Charset.forName("UTF-8");
			
			job.setJarByClass(this.getClass());
			job.setMapperClass(AirMapper.class);
			job.setReducerClass(AirReducer.class);
			//리듀스의 output타입 맞추기
			job.setInputFormatClass(TextInputFormat.class);
			job.setOutputFormatClass(TextOutputFormat.class);
			job.setOutputKeyClass(Text.class);
			job.setOutputValueClass(IntWritable.class);
			URI inputUri = URI.create("/insert/"+inDate+"/"+inTime);
			//URI inputUri = URI.create("/insert/data2.csv");
			URI outputUri = URI.create("/result/"+inDate+"/"+inTime+"_"+count);
			FileInputFormat.addInputPath(job, new Path(inputUri)); //hadoop stroage file 읽어오는 경로&파일
			FileOutputFormat.setOutputPath(job, new Path(outputUri)); //hadoop stroage 저장할 경로
			//위까지 기본세팅
			job.waitForCompletion(true);
		}
		return new ResponseEntity<HashMap<String,Object>> (readFile(inDate,inTime),HttpStatus.OK);
	}
	
	public HashMap<String, Object> readFile(String inDate, String inTime) throws Throwable{
		FileSystem file = FileSystem.get(conf);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		for(int i=0;i<4;i++) {
			FSDataInputStream fsis = file.open(new Path("/result/"+inDate+"/"+inTime+"_"+i+"/"+"/part-r-00000"));
			byte[] buffer = new byte[10000];
			int byteRead = 0;
			String result="";
			while((byteRead = fsis.read(buffer)) > 0) {
				result = new String(buffer, 0, byteRead);
				System.out.println(new String(buffer, 0, byteRead));
			}
			String[] rows = result.split("\n");
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			for(int j = 0; j < rows.length; j++) {
				String row = rows[j];
				String[] cols = row.split("\t|\\,");
				HashMap<String, Object> map = new HashMap<String, Object>();
				for(int c = 0; c < cols.length; c++) {
					map.put(c + "", cols[c]);
				}
				list.add(map);
			}
			resultMap.put("result"+i, list);
		}		
		return resultMap;
	}
	
}