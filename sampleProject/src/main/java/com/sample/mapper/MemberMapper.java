package com.sample.mapper;

import com.sample.model.MemberVO;

public interface MemberMapper {
	
	//JoinUs
	public void memberJoin(MemberVO member);
	
	//Id DoubleCheck
	public int idCheck(String memberId);
}
