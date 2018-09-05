package com.java.project.MR;

import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class AirMapper extends Mapper<LongWritable, Text, Text, IntWritable> {
	@Override
	protected void map(LongWritable key, Text value,Context context) throws IOException, InterruptedException {
		Airbean bean = new Airbean(value);
		if(MrController.year.equals("0") && MrController.month.equals("0")) {
			if(MrService.count==0) {
				//0 중분류, 1. 소분류, 2. 가격대별, 3. 색상
				context.write(new Text(bean.getDivision()),new IntWritable(1));
			}
			else if(MrService.count==1) {
				context.write(new Text(bean.getSection()),new IntWritable(1));
			}			
			else if(MrService.count==2) {
				String txt = "";
				if(bean.getPrice() <= 30000) {
					txt = "3만원이하";
				}
				else if(bean.getPrice() > 30000 && bean.getPrice() <= 50000) {
					txt = "3만원이상 5만원이하";
				}
				else if(bean.getPrice() > 50000 && bean.getPrice() <= 100000) {
					txt = "5만원이상 10만원이하";
				}
				else {
					txt = "10만원이상";
				}
				context.write(new Text(txt),new IntWritable(1));				
			}
			else if(MrService.count==3) {
				String[] color = bean.getColors().split("/");
				for(int i=0;i<color.length;i++) {
					context.write(new Text(color[i]),new IntWritable(1));
				}
			}
			else{
				System.out.println("예외");
			}			
		}
		else {
			if(bean.getDate_Y().equals(MrController.year) && bean.getDate_M().equals(MrController.month)) {
				if(MrService.count==0) {
					//0 중분류, 1. 소분류, 2. 가격대별, 3. 색상
					context.write(new Text(bean.getDivision()),new IntWritable(1));
				}
				else if(MrService.count==1) {
					context.write(new Text(bean.getSection()),new IntWritable(1));
				}			
				else if(MrService.count==2) {
					String txt = "";
					if(bean.getPrice() <= 30000) {
						txt = "3만원이하";
					}
					else if(bean.getPrice() > 30000 && bean.getPrice() <= 50000) {
						txt = "3만원이상 5만원이하";
					}
					else if(bean.getPrice() > 50000 && bean.getPrice() <= 100000) {
						txt = "5만원이상 10만원이하";
					}
					else {
						txt = "10만원이상";
					}
					context.write(new Text(txt),new IntWritable(1));				
				}
				else if(MrService.count==3) {
					String[] color = bean.getColors().split("/");
					for(int i=0;i<color.length;i++) {
						context.write(new Text(color[i]),new IntWritable(1));
					}
				}
				else{
					System.out.println("예외");
				}
			}
		}
		//context.write(new Text(bean.subject),new IntWritable(1));
	}
}
