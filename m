Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7373FC5AE;
	Tue,  8 Sep 2026 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857330; cv=none; b=a9Ozc8QmZsCKir8/7bpdwKgxX+evVDd8aoVxKaL3Zke998yhxkduobdTb1NlEXDOV+jGZqyK2BKUudkvN+w1+0BBdozClTDxGyYWMzcltcTXfxa0JisHt4LRA2TpKEqPGAkMgO0ToY9Tb3mj/2mZ7JfeKogRIN8XovEF2RlZUd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857330; c=relaxed/simple;
	bh=MHaRWLvyO7rmj7G/UGWgwaeGtSRsZ2YdzenLG/NsuqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyIHRsSQUsIHj9YJ/8lOdkTjIIFXM8extthIz1sS+WNCKeQp0/AsO3ZpZkG3Mh05NaxcETckwl7w+vArQ+opSI5kiRGys7YfJj4veiv8x7RxlGZhritPx2l8ce8/aDpoy7jVR+31pArG0D+ZwX4ynYmNuhMFCwkdLI8yvVtI134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iXK48SN/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iXK48SN/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886VZM6065726;
	Tue, 8 Sep 2026 08:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7E/U+5
	20FTb3oWHxFnA+5aRswaRPtZDdLqblUrfvZD8=; b=iXK48SN/EHC9r9p83PnEWR
	5578ywmS9dUIKkIhxjTbcBPrYRG0L46V/9378b1zdrmIxi+U4TGUk6i26IYDJv5n
	jAbDrm+yMpjxaWiWojrOV6p4G/wXMglq1KPXfjnbZiDbVgIKxu0UG+7VYL1bobHx
	UcAWrj7WmByXCVMntHI6EPCJClmGYLGONP5rQJX83c8ESw4/hMGDNPVhf02MXHH2
	gc2mZTql1PwPRtEKZ+jll4tJkIK985P8J5WvArvQP0LtNphP5N7DmmneqR/ukv+A
	2cRClCU1laQ3W6FVSHDE2AlqGxQrOZiP980O3RoRTq4NV8H67hu0gyDTydk1vmiw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf3wq12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 08:48:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6888fD4m001864;
	Tue, 8 Sep 2026 08:48:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgahtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 08:48:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6888mVvC50725166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 08:48:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5CC620043;
	Tue,  8 Sep 2026 08:48:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFC8420040;
	Tue,  8 Sep 2026 08:48:27 +0000 (GMT)
Received: from [9.123.3.64] (unknown [9.123.3.64])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Sep 2026 08:48:27 +0000 (GMT)
Message-ID: <95915e1b-8c4a-443b-a182-d3b6d1aee2b4@linux.ibm.com>
Date: Tue, 8 Sep 2026 14:18:27 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/8] powerpc/bpf: fix buffer overflow in JIT for large
 BPF programs
To: bot+bpf-ci@kernel.org, skb99@linux.ibm.com, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, martin.lau@kernel.org,
        eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
        ihor.solodrai@linux.dev
References: <e5fc39c4f3340791bec5e7a92e1d146d3ed6296e.1788154635.git.skb99@linux.ibm.com>
 <f073ec2085f90747a8909276f42726a0a0e12f99f8f81b0297dad05c4eec3667@mail.kernel.org>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <f073ec2085f90747a8909276f42726a0a0e12f99f8f81b0297dad05c4eec3667@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rhqZ7V2K86tN8QD6rchidYx0-u6YPPOS
X-Proofpoint-GUID: rhqZ7V2K86tN8QD6rchidYx0-u6YPPOS
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6a9fcbe3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=ncrf8N5XN8wjm0ew9NgA:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA4OSBTYWx0ZWRfX7B941Awaraky
 LFOm8/bGC6iNHfhM1R2QHaXcIT15giNNcVoWcksuE9FmAo4XLENtjn6zcjqbyiqK+AITsnwOt39
 4dQYZ+CnmIbYMMoQIG6dhyl7GbksULORAhFdDQ8aie0yiJSk5VuHviafGrGEezUw4vA3T2MjT+n
 EmSRDjwBYnuU0aSc+riqjh7lmtpw6H68V7jEW21zu5YZo5jJvJIgIsundaszqjN7le8+K3Z8VXG
 RL2HvPSltnj69nRfJaZvwu4TPVPpNhg6A34bqE5l4RifU8Yr4rhLRwsxPMqa46ceKOokjlCP13Y
 D06DNMQuceQ1TIO+4HOIoUcrBf/3eqllSBz7OA8o8Kyr9oD1YRwBlUHvksCP5CFQwu/JHW65szB
 Tttr68BD+CZm352u7TvFg++2JnfMbrGShAXRkPXqmz84LBuLbg5yixFAKXi4/7GhBohfhbBlCLm
 uKFijQOxo+8Ti0h7jGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA4OSBTYWx0ZWRfXxX1dSvhf54km
 7+ramZ9qQ03c+FjntJDIowz5+AlooHLg49qptPB/XwtfzZ5yuThAIJQT0FQTj5UzKlv0MK1Y+5C
 bgDVIp+j/CE+PDskqGsqMnTkT5zopUM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080089



On 31/08/26 1:54 pm, bot+bpf-ci@kernel.org wrote:
>>      Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
> 
> Does the Fixes: tag name the correct commit?
> 
> With Cc: stable@vger.kernel.org this fix will only reach v6.13+ and will
> leave every stable tree from v5.18 to v6.12 carrying the same JIT buffer
> overflow.
> 
> The faulty logic predates d243b62b7bd3. Looking at the parent of that commit:
> 
> git show d243b62b7bd3^:arch/powerpc/net/bpf_jit_comp.c
> 
> already contains the exact code being fixed:
> 
>      if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
>              PPC_JMP(exit_addr);
>      } else if (ctx->alt_exit_addr) {
>              if (WARN_ON(!is_offset_in_branch_range((long)ctx->alt_exit_addr - (ctx->idx * 4))))
>                      return -1;
>              PPC_JMP(ctx->alt_exit_addr);
>      } else {
>              ctx->alt_exit_addr = ctx->idx * 4;
>              bpf_jit_build_epilogue(image, ctx);
>      }
> 
> The real introducing commit is 0ffdbce6f4a89bb7c0002904d6438ec83cf05ce7
> ("powerpc/bpf: Handle large branch ranges with BPF_EXIT"), merged in v5.18-rc1
> (git describe --contains: v5.18-rc1~124^2~42). It created
> bpf_jit_emit_exit_insn() with the '!exit_addr' early-out and replaced the
> previous unconditional one-instruction emission:
> 
>      -               if (i != flen - 1)
>      -                       PPC_JMP(exit_addr);
>      +               if (i != flen - 1) {
>      +                       ret = bpf_jit_emit_exit_insn(image, ctx, b2p[TMP_REG_1], exit_addr);
> 
> Before 0ffdbce6f4a8 a non-final BPF_EXIT always cost exactly one instruction in
> every pass, so the sizing pass could not under-count and no overflow was
> possible. After it, the sizing pass emits PPC_JMP(0) (1 instruction) while
> later passes may emit a full inline epilogue, which is precisely the
> under-count described in this commit message.
> 
> The commit d243b62b7bd3 only enlarged the epilogue (it added
> bpf_jit_build_fentry_stubs()), making an already-existing overflow bigger.
> 
> Citing the ppc64-trampoline commit also wrongly implies PPC32 is unaffected.
> The commit 0ffdbce6f4a8 made the identical change to
> arch/powerpc/net/bpf_jit_comp32.c, so 32-bit powerpc has the same bug over the
> same range.
> 
> A tag survey confirms the range: 'alt_exit_addr' has 0 occurrences in
> arch/powerpc/net/ at v5.16 and v5.17, and 5 occurrences at v5.18, v5.19, v6.0,
> v6.1 and v6.6.
> 

> Should the tag be:
> 
>    Fixes: 0ffdbce6f4a8 ("powerpc/bpf: Handle large branch ranges with BPF_EXIT")
> 

True. The current fixes tag is not correct.

>> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
>> index 8f7501954d9f0..11981d2270a9d 100644
>> --- a/arch/powerpc/net/bpf_jit_comp.c
>> +++ b/arch/powerpc/net/bpf_jit_comp.c
>> @@ -99,11 +99,10 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
>>
>>   int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr)
>>   {
>> -	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
>> +	if (exit_addr && is_offset_in_branch_range(exit_addr - (long)(ctx->idx * 4))) {
>>   		PPC_JMP(exit_addr);
>> -	} else if (ctx->alt_exit_addr) {
>> -		if (WARN_ON(!is_offset_in_branch_range((long)ctx->alt_exit_addr - (ctx->idx * 4))))
>> -			return -1;
>> +	} else if (ctx->alt_exit_addr && is_offset_in_branch_range(
>> +			(long)(ctx->alt_exit_addr) - (long)(ctx->idx * 4))) {
>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   		PPC_JMP(ctx->alt_exit_addr);
> 
> With alt_exit_addr defined as unsigned int, does the expression
> (long)(ctx->alt_exit_addr) - (long)(ctx->idx * 4) produce a different result
> than (long)ctx->alt_exit_addr - (ctx->idx * 4) due to how integer promotion
> works?
> 
> In v7 review, Hari Bathini pointed out that the cast placement may affect
> integer promotion semantics and requested restoring the earlier syntax with the
> cast only on alt_exit_addr:
> 
> https://lore.kernel.org/bpf/038a115b-e2a5-4ecf-82b1-3689535e986b@linux.ibm.com
> 
> While the current code has passed testing, the concern about integer promotion
> semantics was never explicitly addressed.
> 
> [ ... ]
> 
>> @@ -399,7 +417,7 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass
>>   	u32 *fixup;
>>
>>   	/* Populate extable entries only in the last pass */
>> -	if (pass != 2)
>> +	if (pass < CODEGEN_MIN_PASSES)
>>   		return 0;
> 
> Does the comment still match the code?
> 
> With the old 'if (pass != 2)' and a fixed two-pass loop, pass 2 was the last
> pass, so the comment was accurate. With the new loop and 'pass <
> CODEGEN_MIN_PASSES', both pass 2 and pass 3 can write extable entries, so
> entries are populated in every pass from 2 onwards, not only in the last one.
> 
> Also, CODEGEN_MIN_PASSES is being reused here with a different meaning. In
> arch/powerpc/net/bpf_jit.h it documents the minimum number of code-generation
> passes, but here it is used as 'the first pass in which extable entries are
> valid'. The two are logically independent - bumping CODEGEN_MIN_PASSES to 3 to
> force more settling iterations would silently stop extable entries being
> written in pass 2.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33368376983

