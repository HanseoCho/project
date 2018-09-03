package com.java.project.MR;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class AirReducer extends Reducer<Text, IntWritable, Text, IntWritable> {
	@Override
	protected void reduce(Text key, Iterable<IntWritable> values,Context context) throws IOException, InterruptedException {
		int sum=0;
		for(IntWritable value : values) {
			sum+=value.get();
		}
		System.out.println(key+":"+sum);
		context.write(key,new IntWritable(sum));
	}
}
