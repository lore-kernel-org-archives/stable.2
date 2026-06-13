Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5EB31F982;
	Sat, 13 Jun 2026 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781354305; cv=none; b=NcA1w1XZ1kRX/jJV7NCNrkx1T9i/ByktW0cvp7s5EduzSfF/2wBuuUi05PydsshpOQTJUczjTbVlj19U8O76ELG2/qYbsA6MiTrjh9BK/4Hy9SqnA2kVoCX16E1uygX0ThOnK+xDWBrlB98Az9lM5DR8VKNpw+r9gajPLMjoBVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781354305; c=relaxed/simple;
	bh=iqxr/N2AGCNrMCb9rYq7KPjG1t3w1Bx+7gYjHIQhRo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7qgLJLjEkeCPs6hzlU7PMuRie4IEPqjShAUcz8p4b7NVbXsGg6mPHxAf9m5bwgZRMXpoYpldbJ7jD+3woEc4utaW3lHMxkHUMm2Lb/1BE7Y+SrKrlRKjg/tuuwEUCqwMhGLn9MukHLZ90RXkPhW4GcFfoGfS0IoIXVg2Ywv8R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ijgiKR2C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ijgiKR2C"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DBIbLp610631;
	Sat, 13 Jun 2026 12:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3doFGC
	Oa0intRDSMA8E0nMvzl/dtNZZti1LBKB4B5+8=; b=ijgiKR2Co0zApG2FvOiLjy
	OiODx33v+7mDbYbcPuGeUHTKWwSmtaONPJyQAuuxX/jTyZ9hZKcx0xTai4lvQ7uv
	bcdZDB8qO0muJ6Mvgrb8FoNadpEAtvymDgcgdbcqB0fNGVdNvUAPgttgN4gKF7zX
	zI2opQCePT4kNoqhbqYVeIuuSn3whI4juY1pLEZEWiG1JAIYl2qiA60Lh1uiWnAi
	K2/jELwKwSi6g6J6qoyc5mKmwRcIJrVtQkTGybusL+hxpb/f12D7QsRKE1Z7D8na
	4j6nebs7YUCWg+X5Su0H1MCvpZoekI4OXhAHwiTaO88sujXq+J/OnKbyTmJ4a7Hg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v20nmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 12:38:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65DCYeVU014787;
	Sat, 13 Jun 2026 12:38:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09uyek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 12:38:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65DCc31850921728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jun 2026 12:38:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CB4320043;
	Sat, 13 Jun 2026 12:38:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D62B720040;
	Sat, 13 Jun 2026 12:38:00 +0000 (GMT)
Received: from [9.124.210.219] (unknown [9.124.210.219])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jun 2026 12:38:00 +0000 (GMT)
Message-ID: <c1a8cf30-a229-48b7-93a5-02d7fc288fc8@linux.ibm.com>
Date: Sat, 13 Jun 2026 18:07:59 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] powerpc/bpf: Move out dummy_tramp_addr after Long
 branch stub
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20260611153826.31187-1-adubey@linux.ibm.com>
 <20260611153826.31187-3-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260611153826.31187-3-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDEyNSBTYWx0ZWRfX71ocm4wiBoKC
 mqfeUZqAT5kfsRhHr7clgIeKbXIrZgD6o36n5hvtuWk7N//PUqiGzedXNj7bT/klovIkk527gGE
 IEdydgUVCXf5YnjryCc02dQ3oCEkY6I=
X-Proofpoint-GUID: miWurphWuMiAiudo_qhrSb0zZUre6InO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDEyNSBTYWx0ZWRfX87AZwXDTr6fw
 lCeoISzUvDhXF8zp1743g20Xds9ZksMlzwUjawbt46o18rtp7vULAZNDJAjbgVaIwfvcGEAwI3B
 G9DWmHGiWaZ2cnOFlbUaakhqRrwaF1QZIkx3SnL10Q9Ry9qnfKLb8yJKfo3XSfjnhM6OLi4iPIP
 OWEsR0taUUuFK7DNJljSHuY4IZ2xzna1JDST6z+VlptuTcBnPc6ZCDGElsBHtBB75Dq2/z7ucvJ
 2z9vHwuE6ZGWwy+XryrxDmy1WwsQyDqA01r/y6GK3AIQCxPfJvgtvM6Vu3qF4ICQtMsvH1ZvWtx
 O463Y+TA3CIQeY9J/pAhdAffd61fLsjgB2a9qoObP+mXQaoul8gk9cm5/R66wfwSsuVZzLKNXRT
 Fv2K+/tSIN3LIy6sQ9fqtmY7HXh7DXH0WdlvQBx5tmWbIipEj1HNxhxzq47WlkPzdtWsE2hFJUC
 tLkAPPdMS4abvR+aA0w==
X-Proofpoint-ORIG-GUID: miWurphWuMiAiudo_qhrSb0zZUre6InO
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a2d4f2f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ScBgnuMk5q3HmX50v5EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606130125



On 11/06/26 9:08 pm, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Move the long branch address field to the bottom of the long
> branch stub. This allows uninterrupted disassembly until the
> last 8 bytes. The last bytes exclusion is logically necessary to
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
> ---
>   arch/powerpc/net/bpf_jit.h        |  3 +-
>   arch/powerpc/net/bpf_jit_comp.c   | 51 ++++++++++++++++---------------
>   arch/powerpc/net/bpf_jit_comp64.c |  3 +-
>   3 files changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 71e6e7d01057..6632de9871dd 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -217,7 +217,8 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
>   void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx);
>   void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx);
>   void bpf_jit_realloc_regs(struct codegen_context *ctx);
> -int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);

> +int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx, int tmp_reg,
> +										long exit_addr);

Yes, this does not compile on ppc32 without the corresponding
change there..

>   void prepare_for_fsession_fentry(u32 *image, struct codegen_context *ctx, int cookie_cnt,
>   								int cookie_off, int retval_off);
>   void store_func_meta(u32 *image, struct codegen_context *ctx, u64 func_meta, int func_meta_off);
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 79288ff789b5..ebee23d33396 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -52,9 +52,10 @@ asm (
>   void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
>   {
>   	int ool_stub_idx, long_branch_stub_idx;
> -	int ool_instrs;
> +	int stubs_instrs;
>   
>   	/*
> +	 * The dummy_tramp_addr field is placed at bottom of Long branch stub.
>   	 * In the final pass, align the mis-aligned dummy_tramp_addr field
>   	 * in the fimage. The alignment NOP must appear before OOL stub,
>   	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
> @@ -62,13 +63,10 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
>   	 * dummy_tramp_addr must be 8-byte aligned for load-register
>   	 * compatibility. The fimage can be non 8-byte aligned, so final
>   	 * alignment depends on start of fimage and the stub's instruction
> -	 * count offset. The OOL stub has 4 instructions (with
> -	 * CONFIG_PPC_FTRACE_OUT_OF_LINE) or 3 instructions (without)
> -	 * before dummy_tramp_addr.
> -	 *
> -	 * Emit a NOP here if (ctx->idx + ool_instrs) is odd, so that
> -	 * dummy_tramp_addr lands at an even instruction offset (== 8-byte
> -	 * aligned from an 8-byte aligned base).
> +	 * count. The stubs block has 11 instructions (with
> +	 * CONFIG_PPC_FTRACE_OUT_OF_LINE) or 10 instructions (without)
> +	 * before dummy_tramp_addr field. Emit a NOP if the address of
> +	 * dummy_tramp_addr is non aligned.
>   	 *
>   	 * In pass=0 when image==NULL, conservatively account for space
>   	 * required to accommodate alignment NOP. In case final pass skips
> @@ -76,8 +74,8 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
>   	 * jited_len signifies correct program size.
>   	 */
>   
> -	ool_instrs = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4*4 : 3*4;
> -	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_instrs, SZL))
> +	stubs_instrs = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 11*4 : 10*4;

This should be stubs_sz instead of stubs_instrs. So:

     stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 44 : 40;


> +	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + stubs_instrs, SZL))
>   		EMIT(PPC_RAW_NOP());
>   
>   	/*
> @@ -98,35 +96,37 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
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
> +	 *	.long	<dummy_tramp_addr>  // 8-byte aligned
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
>   	}
>   }
>   
> -int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr)
> +int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx,
> +							int tmp_reg, long exit_addr)
>   {
>   	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
>   		PPC_JMP(exit_addr);
> @@ -136,7 +136,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
>   		PPC_JMP(ctx->alt_exit_addr);
>   	} else {
>   		ctx->alt_exit_addr = ctx->idx * 4;
> -		bpf_jit_build_epilogue(image, NULL, ctx);
> +		bpf_jit_build_epilogue(image, fimage, ctx);
>   	}
>   
>   	return 0;
> @@ -1289,6 +1289,7 @@ static void do_isync(void *info __maybe_unused)
>    * bpf_func:
>    *	[nop|b]	ool_stub
>    * 2. Out-of-line stub:
> + *	nop	// optional nop for alignment
>    * ool_stub:
>    *	mflr	r0
>    *	[b|bl]	<bpf_prog>/<long_branch_stub>
> @@ -1296,14 +1297,14 @@ static void do_isync(void *info __maybe_unused)
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
> @@ -1405,10 +1406,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
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
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 885dc8cf55a2..eaf816a07f14 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -1726,7 +1726,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   			 * we'll just fall through to the epilogue.
>   			 */
>   			if (i != flen - 1) {
> -				ret = bpf_jit_emit_exit_insn(image, ctx, tmp1_reg, exit_addr);
> +				ret = bpf_jit_emit_exit_insn(image, fimage, ctx,
> +								tmp1_reg, exit_addr);
>   				if (ret)
>   					return ret;
>   			}

- Hari
