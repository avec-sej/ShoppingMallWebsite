package com.sample.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.sample.model.MemberVO;

@Mapper
public interface MemberMapper {
	
	//JoinUs
	public void memberJoin(MemberVO member);
	
	//Id DoubleCheck
	public int idCheck(String memberId);
}
