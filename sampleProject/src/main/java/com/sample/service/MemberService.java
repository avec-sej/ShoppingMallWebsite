package com.sample.service;

import com.sample.model.MemberVO;

public interface MemberService {
	
	//JoinUs
	public void memberJoin(MemberVO member) throws Exception;
	
	//Id DoubleCheck
	public int idCheck(String memberId) throws Exception;
}
