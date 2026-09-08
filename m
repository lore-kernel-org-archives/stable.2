Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07858038F;
	Tue,  8 Sep 2026 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885196; cv=none; b=q9dRF7u7ynHTYaXia3hLEVSZlayfc9siJPr5MqTIHWpFjVD3eQ5gWD2a5siVUXFgPx1wfN4xvjXk/HgRsKvjo2hBeoXhGLPi8H9kr87RfPhQvoNMZwNmACfTCqEPmYJTcLs57wWrnQPVIc4YCV/7vzHoLD08C0qzBCd0ekQMCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885196; c=relaxed/simple;
	bh=U8NeDdYFbMXVpwF7QA3S3JZnVaIiowqkrkdAv0qAuik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdKSayBRZoa9WvT39r13K0IZxzyldI7n0NV0FXQgADHXNap4fn7b1a0UpB4iA9QICZftku9nxNxdxFIgVVChVTHWN8qa4FM9cBQNHpKFJbt3lj9Tfbt5l9L6oNRzlxp7kUbjUqCMvP/iNRVyE0cY/ri1XB9SP68FYwhVbWYYlNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HjLRcHLC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HjLRcHLC"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688F1bX01268476;
	Tue, 8 Sep 2026 16:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2lXH0K
	2YmfKzbfFAB3s8Rs8cIKLoaFyRYwWiOJJxrs0=; b=HjLRcHLCNsrxBCPzK3Y7Eq
	K3toetYCFMGvG+Pm7ltQ78mbFL6mdDvu7LjsYiRTDPBd9zsi857txJyD4NVHlgEu
	PRyYR/3HFAgyogC+NXaKR2IP59L7tutvIA+1zWD+P8EwiGrzgJzhQkbzJOl1zyfH
	8QO39j+yym73oaV+U5dlePdqV1kcHkETDJRARk+79+kljl/yy1GzWxq47I01FoAX
	nHrDX7F7Rh2DRFLGJzGH1M8r7pOuPavNDGby8aC0SAhp1A8VJRtaPaFinsw4K7SR
	kPde6SLq6MIZcvSKSz1xqm/rw2wWDYRjU45JlQ5ClLIv8OcAL+nKPbK5uz/VYlzg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf05c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:32:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GQE3S031277;
	Tue, 8 Sep 2026 16:32:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw568g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:32:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688GWlY852101510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 16:32:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D636C20043;
	Tue,  8 Sep 2026 16:32:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DA3B20040;
	Tue,  8 Sep 2026 16:32:42 +0000 (GMT)
Received: from [9.61.253.97] (unknown [9.61.253.97])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 16:32:42 +0000 (GMT)
Message-ID: <97bcab1d-69a6-49f3-af47-2dcc0863cbd0@linux.ibm.com>
Date: Tue, 8 Sep 2026 22:02:39 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 5/8] powerpc/bpf: Move out dummy_tramp_addr after Long
 branch stub
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1788154635.git.skb99@linux.ibm.com>
 <647e37d4e0049cc9c9a6977ac112a445f6ced6c8.1788154635.git.skb99@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <647e37d4e0049cc9c9a6977ac112a445f6ced6c8.1788154635.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RpyOGDJa3MkR8YIFAO6nlt-e2xvi51HH
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa038b4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=JCM8ehL5gn53L53ZUGAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX7HBRrj/r16Hy
 dg+yJA3/tSoKqGg7645iFoR9xEEzjQIVo8RhNeTx+iOlIggv1nAEubrOtg1FS4Q7T5rg+EWZgT0
 1KGD6xbjFIZvkfhNT2WoPHVIEDc80Bs=
X-Proofpoint-ORIG-GUID: RpyOGDJa3MkR8YIFAO6nlt-e2xvi51HH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfXy086drKIP1jy
 VNAVpObQFInBADqS39c68oLjgMZW2raIKCLU2WUgP3cK99wgL2B2ttBbLoNv6gPSnSNH3tYVABq
 S3Np8/mB67DiFmsCKNi3BkQCHWEoyBbq985WAHYNRIqMwr8R+lijUd3R67Gw3klG9UF5T8KCVV3
 ZDY/rV/koB9W5ZDm1Se9yLlpdoV6awp45UT8U9oDOiXQbTfBby2fgdV0SqlLp3dfuBdWhybPLvE
 YFD6HEEhWvigUWRbfUKU08/gOeKRRhZgkS5cHEN0av+vR2lazxQ8mLCfCDitfs8Fed4c8Tji15O
 c73zqsNOXVXmIAG2y6Stsk+6ufwVR8nsv+D2N6KjU3vyCIGoJeRlEll+RDWouRxlpb/EhzanwWx
 Ms0aCoaC+Uz3c3rOf4j6nAFVc05pcOZwu/yCihiIpSrM+vqlUysrwNaU8rdTeorjkNU94aj5lfP
 RQ4dMY+PJlD5u0ZJt0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080178


On 31.08.2026 12:46 PM, Saket Kumar Bhaskar wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
>
> Move the long branch address field to the bottom of the long
> branch stub. This allows uninterrupted disassembly until the
> last 4/8 bytes. The last bytes exclusion is logically necessary to
> prevent disassembly failure, otherwise the actual program layout
> is never altered. Hence no effect on overall program size.
> Also, align dummy_tramp_addr field with 8-byte boundary.
>
> Following is disassembler output for test program with moved down
> dummy_tramp_addr field:
> .....
> .....
> pc:68    left:44     a6 03 08 7c  :  mtlr 0
> pc:72    left:40     bc ff ff 4b  :  b .-68
> pc:76    left:36     a6 02 68 7d  :  mflr 11
> pc:80    left:32     05 00 9f 42  :  bcl 20, 31, .+4
> pc:84    left:28     a6 02 88 7d  :  mflr 12
> pc:88    left:24     14 00 8c e9  :  ld 12, 20(12)
> pc:92    left:20     a6 03 89 7d  :  mtctr 12
> pc:96    left:16     a6 03 68 7d  :  mtlr 11
> pc:100   left:12     20 04 80 4e  :  bctr
> pc:104   left:8      c0 34 1d 00  :
>
> Failure log:
> Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0
> Disassembly logic can truncate at 104, ignoring last 8 bytes.
>
> Update the dummy_tramp_addr field offset calculation from the end
> of the program to reflect its new location, for bpf_arch_text_poke()
> to update the actual trampoline's address in this field.
>
> All BPF trampoline selftests continue to pass with this patch applied.
>
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   arch/powerpc/net/bpf_jit_comp.c | 44 ++++++++++++++++++---------------
>   1 file changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 8ca36a933c7a..c2717f0d9cdd 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -52,19 +52,19 @@ asm (
>   void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
>   {
>   	int ool_stub_idx, long_branch_stub_idx;
> -	int ool_stub_sz;
> +	int stub_sz;
>   
>   	/*
> +	 * The dummy_tramp_addr field is placed at bottom of Long branch stub.
>   	 * Align the mis-aligned dummy_tramp_addr field in the fimage.
>   	 * The alignment NOP must appear before OOL stub, to make
>   	 * ool_stub_idx & long_branch_stub_idx constant from end.
>   	 *
>   	 * The fimage can be non 8-byte aligned, so final alignment depends
> -	 * on start of fimage and the stub's instruction count offset. The
> -	 * OOL stub size is 4 instructions (with CONFIG_PPC_FTRACE_OUT_OF_LINE)
> -	 * or 3 instructions (without) before dummy_tramp_addr.
> -	 *
> -	 * Emit a NOP here if address is not SZL aligned.
> +	 * on start of fimage and the stub's instruction count. The
> +	 * stubs block has 11 instructions (with CONFIG_PPC_FTRACE_OUT_OF_LINE)
> +	 * or 10 instructions (without) before dummy_tramp_addr field. Emit a
> +	 * NOP if the address of dummy_tramp_addr is non aligned.
>   	 *
>   	 * In pass=0 when image==NULL, conservatively account for space
>   	 * required to accommodate alignment NOP. In case final pass skips
> @@ -72,8 +72,8 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
>   	 * jited_len signifies correct program size.
>   	 */
>   
> -	ool_stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
> -	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub_sz, SZL))
> +	stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 44 : 40;
> +	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + stub_sz, SZL))
>   		EMIT(PPC_RAW_NOP());
>   
>   	/*
> @@ -94,28 +94,29 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
>   
>   	/*
>   	 * Long branch stub:
> -	 *	.long	<dummy_tramp_addr>  // 8-byte aligned
>   	 *	mflr	r11
>   	 *	bcl	20,31,$+4
> -	 *	mflr	r12
> -	 *	ld	r12, -8-SZL(r12)
> +	 *	mflr	r12	// lr/r12 stores pc of current(this) inst.
> +	 *	ld	r12, 20(r12) // offset(dummy_tramp_addr) from prev inst. is 20
>   	 *	mtctr	r12
> -	 *	mtlr	r11 // needed to retain ftrace ABI
> +	 *	mtlr	r11	// needed to retain ftrace ABI
>   	 *	bctr
> +	 *	.long	<dummy_tramp_addr>  // SZL bytes aligned
>   	 */
> -	if (image)
> -		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
> -
> -	ctx->idx += SZL / 4;
>   	long_branch_stub_idx = ctx->idx;
>   	EMIT(PPC_RAW_MFLR(_R11));
>   	EMIT(PPC_RAW_BCL4());
>   	EMIT(PPC_RAW_MFLR(_R12));
> -	EMIT(PPC_RAW_LL(_R12, _R12, -8-SZL));
> +	EMIT(PPC_RAW_LL(_R12, _R12, 20));
>   	EMIT(PPC_RAW_MTCTR(_R12));
>   	EMIT(PPC_RAW_MTLR(_R11));
>   	EMIT(PPC_RAW_BCTR());
>   
> +	if (image)
> +		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
> +
> +	ctx->idx += SZL / 4;
> +
>   	if (!bpf_jit_ool_stub) {
>   		bpf_jit_ool_stub = (ctx->idx - ool_stub_idx) * 4;
>   		bpf_jit_long_branch_stub = (ctx->idx - long_branch_stub_idx) * 4;
> @@ -1309,6 +1310,7 @@ static void do_isync(void *info __maybe_unused)
>    * bpf_func:
>    *	[nop|b]	ool_stub
>    * 2. Out-of-line stub:
> + *	nop	// optional nop for alignment
>    * ool_stub:
>    *	mflr	r0
>    *	[b|bl]	<bpf_prog>/<long_branch_stub>
> @@ -1316,14 +1318,14 @@ static void do_isync(void *info __maybe_unused)
>    *	b	bpf_func + 4
>    * 3. Long branch stub:
>    * long_branch_stub:
> - *	.long	<branch_addr>/<dummy_tramp>
>    *	mflr	r11
>    *	bcl	20,31,$+4
>    *	mflr	r12
> - *	ld	r12, -16(r12)
> + *	ld	r12, 20(r12)
>    *	mtctr	r12
>    *	mtlr	r11 // needed to retain ftrace ABI
>    *	bctr
> + *	.long	<branch_addr>/<dummy_tramp>
>    *
>    * dummy_tramp is used to reduce synchronization requirements.
>    *
> @@ -1425,10 +1427,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
>   	 * 1. Update the address in the long branch stub:
>   	 * If new_addr is out of range, we will have to use the long branch stub, so patch new_addr
>   	 * here. Otherwise, revert to dummy_tramp, but only if we had patched old_addr here.
> +	 *
> +	 * dummy_tramp_addr moved to bottom of long branch stub.
>   	 */
>   	if ((new_addr && !is_offset_in_branch_range(new_addr - ip)) ||
>   	    (old_addr && !is_offset_in_branch_range(old_addr - ip)))
> -		ret = patch_ulong((void *)(bpf_func_end - bpf_jit_long_branch_stub - SZL),
> +		ret = patch_ulong((void *)(bpf_func_end - SZL), /* SZL: dummy_tramp_addr offset */
>   				  (new_addr && !is_offset_in_branch_range(new_addr - ip)) ?
>   				  (unsigned long)new_addr : (unsigned long)dummy_tramp);
>   	if (ret)

-- 
Thanks and Regards
R.Nageswara Sastry

