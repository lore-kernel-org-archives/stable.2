Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF83412269;
	Tue,  8 Sep 2026 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855851; cv=none; b=kf1Ovxy0LawlGQJGgIrFWJUM0roXMhuc1szbHUins2npEOakObkSboGJxm6ytXsFig+UsZypKbuDlt4uKVFCk6lR9cTpC7e6GOIS5O7+zdgVh2MJT72peXzWKxdtvRS3AUhHwI2PemOhyeqoSpdAtWWxv0JhllIy3Lrg2a6ohuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855851; c=relaxed/simple;
	bh=uE4GHSHnjStSy+0AObwyrbKsDb/kzmIKZsgMdCu+bS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJq4zF2mQp04Tj2b9mLx1fnVRwVScM7AJXvDe+nVcjbKmV+mYBHb5F3RVj1+OLa0wTrFv9BN3GJdvZdka/oRhMY6jlA4xA5RvVU5zRw9QwQTuPjum3T+kwz3x7EE4jHPbIDlaGYgy/zu4W4x12Qk2xisBYm83cO3WtvcwTdb4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H0SHP5Ix; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H0SHP5Ix"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886WBtV066887;
	Tue, 8 Sep 2026 08:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=42oH6g
	JMbsL5NqcnQM3pgYq5B3K1P7Iql81JmEH9jA8=; b=H0SHP5IxZwI9EGw5Bg8nvb
	VoC43gMvLlUcQLatwYobuLJqf3BWce5zz+L10192GMt75zmG1KSvAUm+DXVOx5BE
	F0AnH9b6gb/fnVpZyhd64BzOqb6Hhno9IX/xpwWtAEc8UF328MC7wKCuaBhlAu6N
	tM0fwklDfXUXF2FjCBYYrZU0OL9866aYG4xvwyKHIj8zILBKXE/RRTsSZjUYcKs6
	fnMMFlqZhJvrKzxbINxma63ww43shp/BhdPJzFZprLFgVTl1r3cU+oBrxlNqHLa2
	Nz1pWkKsDg4eP6tsjjYLEbtUIAWdr5XvC9Uz8TKuhDSkBe96113zZu4208jD8zAw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf3wk90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 08:23:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6888BKMt027142;
	Tue, 8 Sep 2026 08:23:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgaekf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 08:23:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6888NfMd37028198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 08:23:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7BD120043;
	Tue,  8 Sep 2026 08:23:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F126120040;
	Tue,  8 Sep 2026 08:23:37 +0000 (GMT)
Received: from [9.123.3.64] (unknown [9.123.3.64])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Sep 2026 08:23:37 +0000 (GMT)
Message-ID: <f8439dfb-7584-45c4-90fa-5659fa5507e2@linux.ibm.com>
Date: Tue, 8 Sep 2026 13:53:36 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 4/8] powerpc/bpf: fix alignment of long branch
 trampoline address
To: bot+bpf-ci@kernel.org, skb99@linux.ibm.com, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, martin.lau@kernel.org,
        eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
        ihor.solodrai@linux.dev
References: <0700c866205c8fa2f861e4b8d64fdf7469cba021.1788154635.git.skb99@linux.ibm.com>
 <71916017b03ad6e22c093094acae6a356a57f8fd0c3afda3833a20a2db10ec77@mail.kernel.org>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <71916017b03ad6e22c093094acae6a356a57f8fd0c3afda3833a20a2db10ec77@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: sqkZ9llR8M7ltf6nsMXpRlKZNBU3we3G
X-Proofpoint-GUID: aizvzTKrY6e0ZXN_uaTz5vGGRHH4pw1d
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6a9fc612 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=kVk8kcng22Gj4D9CYR0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA4MyBTYWx0ZWRfX6F7cC5p/SKxg
 9sV1XQiO1A31a6H8GazoXkZqUOPTzPE4VdGHLjnTgJQDDkM0bfTa9ahbNekLfzqyIyDWVT31wy8
 AnFXgMAQFoe9uZ7SHlErG++54BJTYkB6zEvbjYC4tKxlxqsE2wTL4nRR+PjSPgaA1H/B0lxULUK
 YC52pEnlJxH1Mkhiy8aqmUr9YuBAngI3Fsd1A8lmVdfr4L/T8bI9ZA+uxnsv6MOC8s7tMBDJJIg
 WUvE/sUXm1xik/t87QRrOkCgS/ezygszHPxxK6g2oUdd/P7t7W2JtnAAgDyshpC8nZXE6vsBK2P
 2jyQT476kLPywiOUZ8N/TcfYOoE36SDxRTxyTTB26yvX4vAd7jP0KK1+rz6Yb2if+4E1Su87AQx
 t1SAw8bDvWchpL68tynCQsP77/iyb6OTjYtnmUebaw7/QSTA7HI0ySWJ2gH+EAunU0qSEsbNFum
 2vVN3ZGvhNz/v391AvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA4MyBTYWx0ZWRfXz64NRiH6rO41
 Z06s+tKRVmad//+Q8CdKoG1AEa7Gu/HSc0npnN1jB09dGma8zdp9qBJy3ASpeLPTCMDLotzWDIj
 6a1x9LJF6WuOes7mfMgx8Jki+Uaa2jg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080083



On 31/08/26 1:42 pm, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
>> index 11981d2270a9d..8ca36a933c7ae 100644
>> --- a/arch/powerpc/net/bpf_jit_comp.c
>> +++ b/arch/powerpc/net/bpf_jit_comp.c
> 
> [ ... ]
> 
>> @@ -49,11 +49,35 @@ asm (
>>   "	.popsection				;"
>>   );
>>
>> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
>> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
>>   {
>>   	int ool_stub_idx, long_branch_stub_idx;
>> +	int ool_stub_sz;
>>
>>   	/*
>> +	 * Align the mis-aligned dummy_tramp_addr field in the fimage.
>> +	 * The alignment NOP must appear before OOL stub, to make
>> +	 * ool_stub_idx & long_branch_stub_idx constant from end.
>> +	 *
>> +	 * The fimage can be non 8-byte aligned, so final alignment depends
>> +	 * on start of fimage and the stub's instruction count offset. The
>> +	 * OOL stub size is 4 instructions (with CONFIG_PPC_FTRACE_OUT_OF_LINE)
>> +	 * or 3 instructions (without) before dummy_tramp_addr.
>> +	 *
>> +	 * Emit a NOP here if address is not SZL aligned.
>> +	 *
>> +	 * In pass=0 when image==NULL, conservatively account for space
>> +	 * required to accommodate alignment NOP. In case final pass skips
>> +	 * emitting alignment NOP, the image buffer have 4 spare bytes and
>> +	 * jited_len signifies correct program size.
>> +	 */
>> +
>> +	ool_stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
>> +	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub_sz, SZL))
>> +		EMIT(PPC_RAW_NOP());
> 
> Can the conditional alignment NOP here mask program length convergence?
> 
> The preceding commit (5175364d6174 "powerpc/bpf: fix buffer overflow in
> JIT for large BPF programs") added a convergence check:
> 
>      if (pass >= CODEGEN_MIN_PASSES && proglen == prev_proglen)
>          break;
> 
> to bpf_int_jit_compile(). But the alignment decision above forces the
> stub block to end at a fixed residue mod 8: the field address (fimage +
> ctx->idx*4 + ool_stub_sz) is aligned to SZL, and exactly SZL/4 + 7
> instructions follow it. So fimage + proglen is congruent to a constant
> mod 8 every pass, meaning proglen can only change in multiples of 8.
> 
> When the body shrinks by an odd multiple of 4 bytes between passes, the
> NOP can absorb it and keep proglen unchanged. The body can shrink when
> an exit goes from out-of-range (emitting a full epilogue) to in-range
> (emitting a single branch):
> 
> arch/powerpc/net/bpf_jit_comp.c:bpf_jit_emit_exit_insn() {
>      if (exit_addr && is_offset_in_branch_range(...)) {
>          PPC_JMP(exit_addr);                    // 1 instruction
>      } else {
>          ...
>          bpf_jit_build_epilogue(image, fimage, ctx);  // N instructions
>      }
> }
> 
> The shrink is (N-1)*4 bytes. When N-1 is odd, this is 4 mod 8. The NOP
> appearance or disappearance compensates, making proglen identical across
> passes even though addrs[] shifted.
> 
> Because forward branches use addrs[] from the previous pass (addrs[j]
> for target j > current i is computed in the prior pass), those branches
> would land (N-1)*4 bytes past the intended target.
> 
> The comment at arch/powerpc/net/bpf_jit.h:132-138 documents that the
> PowerPC JIT avoids pass-to-pass size changes by padding the short branch
> case with a NOP, specifically to prevent this scenario. Does reintroducing
> an address-dependent, pass-varying size risk incorrect branches?
> 
> (Note: commit 0cd8bd7da278 later in this series reworks the stub layout
> and is described as a layout improvement rather than a fix for this commit,
> which may provide additional context.)
> 
The review correctly identifies a potential mechanism by which a 4-byte
alignment NOP could mask a size change. However, that mechanism only
causes a convergence failure if the total code-size reduction between
passes is exactly compensated by the NOP (i.e. effectively only 4
bytes). In this JIT, changing an exit from the inline epilogue to a
branch removes the entire epilogue, so the size reduction is much
larger than 4 bytes. The NOP can only compensate for 4 bytes; it
cannot hide the remaining reduction. Therefore the proposed
convergence failure does not apply to this code.

- Hari
