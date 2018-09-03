package com.java.project.vo;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.java.project.mail.TempKey;

public class UserVO {
	private String no;
	private String id;
	private String pw;
	private String pw2;
	private String name;
	private String address1;
	private String address2;
	private String address3;
	private String phone;
	private String email;
	private String birthDay;
	private String phone1;
	private String phone2;
	private String phone3;
	private String email1;
	private String email2;
	private String birthDay1;
	private String birthDay2;
	private String birthDay3;
	private String key;
	private String status;
	private String kickYn;
	
	public boolean checkPw() {
		System.out.println(this.pw.matches("([a-zA-Z].*[0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~,-].*[0-9])|([0-9].*[a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z].*[0-9])|([!,@,#,$,%,^,&,*,?,_,~,-].*[0-9].*[a-zA-Z])"));
		if(this.pw.length()<8) {
			return false;
		}
		if(this.pw.equals(this.pw2)) {
			if(this.pw.matches("([a-zA-Z].*[0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~,-].*[0-9])|([0-9].*[a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z].*[0-9])|([!,@,#,$,%,^,&,*,?,_,~,-].*[0-9].*[a-zA-Z])")) {
				return true;				
			}
			return false;
		}
		return false;		
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setKey() {
		key = new TempKey().getKey(50, false);
	}
	
	public void setKey(String key) {
		this.key = key;
	}	
	
	public String getKey() {
		return key;
	}

	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getPw2() {
		return pw2;
	}

	public void setPw2(String pw2) {
		this.pw2 = pw2;
	}	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getAddress3() {
		return address3;
	}
	public void setAddress3(String address3) {
		this.address3 = address3;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBirthDay() {
		return birthDay;
	}
	public void setBirthDay(String birthDay) {
		this.birthDay = birthDay;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getPhone3() {
		return phone3;
	}
	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getBirthDay1() {
		return birthDay1;
	}
	public void setBirthDay1(String birthDay1) {
		this.birthDay1 = birthDay1;
	}
	public String getBirthDay2() {
		return birthDay2;
	}
	public void setBirthDay2(String birthDay2) {
		this.birthDay2 = birthDay2;
	}
	public String getBirthDay3() {
		return birthDay3;
	}
	public void setBirthDay3(String birthDay3) {
		this.birthDay3 = birthDay3;
	}
	
	public String getKickYn() {
		return kickYn;
	}

	public void setKickYn(String kickYn) {
		this.kickYn = kickYn;
	}

	public void insertDb() {
		if(phone1 != null && phone2 != null && phone3 != null) {
			phone = phone1+"-"+phone2+"-"+phone3;
		}
		if(email1 != null && email2 != null) {
			email = email1+"@"+email2;	
		}
		if(birthDay1 != null && birthDay2 != null && birthDay3 != null) {
			birthDay = birthDay1+"/"+birthDay2+"/"+birthDay3;
		}
	}
	@Override
	public String toString() {
		return "UserVO [no=" + no + ", id=" + id + ", pw=" + pw +", pw2=" + pw2 +", key="+ key +", name=" + name + ", address1=" + address1
				+ ", address2=" + address2 + ", address3=" + address3 + ", phone=" + phone + ", email=" + email
				+ ", birthDay=" + birthDay + ", phone1=" + phone1 + ", phone2=" + phone2 + ", phone3=" + phone3
				+ ", email1=" + email1 + ", email2=" + email2 + ", birthDay1=" + birthDay1 + ", birthDay2=" + birthDay2
				+ ", birthDay3=" + birthDay3 + "]";
	}
	
	
	public HashMap<String, Object> parseMap() throws Exception{
		HashMap<String, Object> map = new HashMap<String,Object>();
	    Class clazz = this.getClass();
	    List<Field> fields = getInheritedFields(clazz); //클래스 내부 변수
	    Field field = null;
	    PropertyDescriptor pd = null;
	    Method method = null;
	    String uKey = null;
	    String uValue = null; 
	    Object[] args = null;
	    
	    for(int i=0;i<fields.size();i++) {
	    	field = fields.get(i);
            pd = new PropertyDescriptor(field.getName(), clazz);
            method = pd.getReadMethod();	
            
            uKey = field.getName();
            uValue = String.valueOf(method.invoke(this, args));
            map.put(uKey, uValue);
	    }
		return map;
	}
	
	public UserVO parseUesr(Map<String, Object> map) {
		String keyAttribute = null;
		String setMethodString = "set";
		String methodString = null; 
		Iterator itr = map.keySet().iterator();
		UserVO user = new UserVO();
		while(itr.hasNext()) {
			keyAttribute = (String) itr.next();
			methodString = setMethodString + keyAttribute.substring(0,1).toUpperCase()+keyAttribute.substring(1);
			//System.out.println(methodString);
			try { 
				Method[] methods = user.getClass().getDeclaredMethods(); 
				for(int i=0;i<=methods.length-1;i++){
					if(methodString.equals(methods[i].getName())){ 
						//System.out.println("invoke : "+keyAttribute +" | "+map.get(keyAttribute));
						if(keyAttribute.equals("key")) {
							continue;
						}
						else {
							methods[i].invoke(user, map.get(keyAttribute));
							}
						} 
					}  
				}
			catch (SecurityException e) {
				e.printStackTrace(); 
				} 
			catch (IllegalAccessException e) {
				e.printStackTrace(); 
				} 
			catch (IllegalArgumentException e) {
				e.printStackTrace();
			} 
			catch (InvocationTargetException e) { 
				e.printStackTrace(); 
				}
		}
		return user; 
	}
	
	private List<Field> getInheritedFields(Class<?> type) {
       List<Field> fields = new ArrayList<Field>();
       HashMap<String, String> map = new HashMap<String, String>();
       for (Class<?> c = type; c != null; c = c.getSuperclass()) {
             // fields.addAll(Arrays.asList(c.getDeclaredFields()));
             Field[] fldArry = c.getDeclaredFields();
             for (int i = 0; i < fldArry.length; i++) {
                    if (!map.containsKey(fldArry[i].getName())) {
                           fields.add(fldArry[i]);
                           map.put(fldArry[i].getName(),fldArry[i].getName());
                    }
             }
       }
       return fields;
	}
	
	
	// URI로 이동시 .이 _로 변환해서 받으면 다시 변환해주기 위해 사용
	public void replaceEmail() {
		this.email = this.email.replace("_", ".");
		this.email1 = this.email.replace("_", ".");
		this.email = this.email1;
	}
	
}