Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1112B331EC2;
	Thu,  6 Aug 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037239; cv=none; b=fiCAD9+3WSGiJEiBTRqhHMpjwwHno0cI+lkUUeknoNlK5AOGxaH12gI1xdeSsQWQSCd3asTH7PXCjR8nbua0WnJtZgZcLB7zfPaT2/4amjfZL+Xenk+K3g2vQiBhztwgmq42jCUnszql8CURsEcAqjt2ML04Ov5utH52mHhu5Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037239; c=relaxed/simple;
	bh=2av6GZbjjTjaBpJZvtmQ0/ApUYW3cnHsyXcuirQqgLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtD/rExTyKiKRJzKTR6xhY9R+o3WBr6QT3mWq9aLDTVBhfVGCef2R++qOi1mp/i+7LT62NyzLok52bKr0RU/jtE5iNHwbMDKJYVAY3Mm//acfL1LEu795Hh/m6lledP5qFHVyuumLU4UOpf2agtTJNe89kltu+mxzdJAHEbQMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BOTKU1MO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BOTKU1MO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676HIaGr3193721;
	Thu, 6 Aug 2026 17:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F3Cj1u
	b40TYuvUCiAC770gYejsumY0schkq8OLkcuS4=; b=BOTKU1MOrq0kFiwHKJ45Ce
	CN4bEvzI4LYp9ftzUrlYMHn7r/a2C9D+GByO25j+h2d5FdKMX3xFRZzzFO9NGCJM
	8CSJ8QKfpLxji2HZxQrhliBuExi9BGcJjsdRtq3jEnBwWPpQoHrd1eicO5h1fyqX
	gdanCdG6WPe/v9XWOdyh4Jf7FNY5dPcwTwW7HsG9nspXN4+8BpGYvZqAWYmaYQM7
	ciWLmaCDIA6BYDg1dMQhYqLreF1TG9Ba357Yk2W57fCOvPlPWYfPOyJ/u8xsNgHG
	L0scgXkv4QbukEjebpMbBkMF8fQ1YLnh///ltX7ADRrJTLRkOXbFSAr3XyPpcG+A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gh1wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:26:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HQflr013801;
	Thu, 6 Aug 2026 17:26:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwc9m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:26:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676HQqXa46989750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:26:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1E1F2004E;
	Thu,  6 Aug 2026 17:26:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6B972004D;
	Thu,  6 Aug 2026 17:26:49 +0000 (GMT)
Received: from [9.124.215.184] (unknown [9.124.215.184])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:26:49 +0000 (GMT)
Message-ID: <a4d54bca-2fea-4dbd-b5dc-e9229499da47@linux.ibm.com>
Date: Thu, 6 Aug 2026 22:56:48 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 7/8] powerpc/bpf: fix buffer overflow in JIT for large
 BPF programs
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1785906979.git.skb99@linux.ibm.com>
 <45cfcf00a9ca1ec0a06c516fabc73e284d529dc1.1785906979.git.skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <45cfcf00a9ca1ec0a06c516fabc73e284d529dc1.1785906979.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX1R9hNT3LHv39
 BkUr4pfrnSwYsXmsv1+nyGwEf1ttBAWyT0H7WMrqKxJyzBw6R18Upn0Wctt3ahbjQ0QZXexCUF3
 5hH4vIWLCMvsmEDEuq95UrMgz5QuZ6hVLxNEH7P2+9fLydV7UxQwC7skeO1MO9+IxmIQgG+Qa/l
 a2yQDU/oFIqp1sXWMzqoEp+N3ZXffshsRKHu5kN62Zh7WT9tTG0pu7JHeDgRk8uVEXUCAOow5qY
 Waf93400uo5rZ7RsnN5WZDCivXzLMdRFlNk0GbLDXCV0+M9chgJfS/+H8G+lYzZqdUWdQJ8BM4S
 sAkNQsyiMv6vkJbIBcU3mvJBz7fenb5bXx3G1TtYuCteqKt0IlAeeFdJfFzkIJPWm2g1LwRTGsU
 Bp3ne4VkxYbabqUVdNsLG9uFeXYv+GJODWiznwoIyg07+dZad5y7XnTSeEiEPOB9OHPU08i1eDk
 tcmR7h3BXtpAwWLv9kg==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a74c3e1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=et7YBkXB-uCz4WkyIggA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BJGwYY2nMybkF2WnJyrWEMxIGbIVg3sE
X-Proofpoint-ORIG-GUID: BJGwYY2nMybkF2WnJyrWEMxIGbIVg3sE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX2FSvDajHP3XZ
 5Z9dlljLQAIX+/ph7mb+NVLeViB0ryAdaZ1Vgxm6+Y03nmXYjbPnmnXFYTpau0GfA+4Mm3Xs9Fr
 0j6pDtLUF5GyvrdyymGoLzdLfgKD8zQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060135



On 05/08/26 11:37 am, Saket Kumar Bhaskar wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> During size calculation in pass-0, exit_addr is 0 since addrs[fp->len]
> is not yet populated. bpf_jit_emit_exit_insn() treats a zero exit_addr
> as in-range and skips bpf_jit_build_epilogue(), so the alternate inline
> epilogue instructions are not counted in alloclen.
> 
> In later passes, if the real exit_addr falls outside the 32MB branch
> range, the full inline epilogue is emitted into the already-allocated
> buffer, writing past its end and corrupting adjacent memory.
> 
> Fix by ensuring exit_addr is non-zero before treating it as in-range,
> so pass-0 always falls through to bpf_jit_build_epilogue() and
> conservatively accounts for all epilogue instructions in alloclen.
> Also range check alt_exit_addr directly in the else-if condition.
> 
> Since exit_addr handling now falls through to the epilogue, two
> related issues in bpf_int_jit_compile() must also be addressed:
> 
> 1. Reset cgctx.alt_exit_addr before the second size-calculation pass.
>     Without this, a stale alt_exit_addr from the first pass causes the
>     second pass to emit a single jump instead of the full epilogue,
>     undercounting alloclen and reintroducing the overflow.
> 
> 2. Recompute addrs[fp->len] at the end of each code-generation pass.
>     The larger pass-0 body can shrink in later passes as out-of-range
>     exits settle into in-range jumps; a stale addrs[fp->len] would
>     leave exit branches targeting past the real (shrunken) epilogue.
> 
> Because shrinkage in a later pass can move the epilogue offset, the
> fixed two-pass loop is no longer sufficient: an exit that was out of
> range in an earlier pass may fall in range once the epilogue offset
> shrinks, shrinking the body further and overwriting the start of the
> epilogue. Convert the code-generation loop to iterate until the
> program size converges, bounded by CODEGEN_MAX_PASSES, and fail the
> JIT if it does not converge.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ibm.com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92
> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Link: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ibm.com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit.h      |  7 +++++++
>   arch/powerpc/net/bpf_jit_comp.c | 34 +++++++++++++++++++++++++--------
>   2 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index af510da12d8e..4da8bde92e1e 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -14,6 +14,13 @@
>   #include <asm/ppc-opcode.h>
>   #include <linux/build_bug.h>
>   
> +/*
> + * We need at least 2 passes for proper code generation, and may need
> + * additional passes if code size changes between passes.
> + */
> +#define CODEGEN_MIN_PASSES    2
> +#define CODEGEN_MAX_PASSES    3
> +
>   #ifdef CONFIG_PPC64_ELF_ABI_V1
>   #define FUNCTION_DESCR_SIZE	24
>   #else
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 8be5ded13a4a..3c20bb13cfd7 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -128,11 +128,10 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
>   int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx,
>   							int tmp_reg, long exit_addr)
>   {
> -	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
> +	if (exit_addr && is_offset_in_branch_range(exit_addr - (long)(ctx->idx * 4))) {
>   		PPC_JMP(exit_addr);
> -	} else if (ctx->alt_exit_addr) {
> -		if (WARN_ON(!is_offset_in_branch_range((long)ctx->alt_exit_addr - (ctx->idx * 4))))
> -			return -1;
> +	} else if (ctx->alt_exit_addr && is_offset_in_branch_range(
> +			(long)(ctx->alt_exit_addr) - (long)(ctx->idx * 4))) {
>   		PPC_JMP(ctx->alt_exit_addr);
>   	} else {
>   		ctx->alt_exit_addr = ctx->idx * 4;
> @@ -303,6 +302,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   	 */
>   	if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
>   		cgctx.idx = 0;
> +		cgctx.alt_exit_addr = 0;
>   		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
>   			goto out_err;
>   	}
> @@ -335,10 +335,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   	code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
>   	fcode_base = (u32 *)(fimage + FUNCTION_DESCR_SIZE);
>   
> -	/* Code generation passes 1-2 */
> -	for (pass = 1; pass < 3; pass++) {
> +	/* Code generation passes 1-2+, loop until program size converges. */
> +	for (pass = 1; pass <= CODEGEN_MAX_PASSES; pass++) {
> +		u32 prev_proglen = proglen;
> +
>   		/* Now build the prologue, body code & epilogue for real. */
>   		cgctx.idx = 0;
> +		cgctx.exentry_idx = 0;
>   		cgctx.alt_exit_addr = 0;
>   		bpf_jit_build_prologue(code_base, &cgctx);
>   		if (bpf_jit_build_body(fp, code_base, fcode_base, &cgctx, addrs, pass,
> @@ -347,11 +350,26 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   			bpf_jit_binary_pack_free(fhdr, hdr);
>   			goto out_err;
>   		}
> +		addrs[fp->len] = cgctx.idx * 4;
>   		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);
>   
> +		proglen = cgctx.idx * 4;
> +
>   		if (bpf_jit_enable > 1)
>   			pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
> -				proglen - (cgctx.idx * 4), cgctx.seen);
> +				prev_proglen - proglen, cgctx.seen);
> +
> +		/* Check if program size has converged, but ensure minimum passes */
> +		if (pass >= CODEGEN_MIN_PASSES && proglen == prev_proglen)
> +			break;
> +
> +		if (pass == CODEGEN_MAX_PASSES && proglen != prev_proglen) {
> +			pr_err("BPF JIT: Program did not converge after %d passes\n",
> +								CODEGEN_MAX_PASSES);
> +			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
> +			bpf_jit_binary_pack_free(fhdr, hdr);
> +			goto out_err;
> +		}
>   	}
>   
>   	if (bpf_jit_enable > 1)
> @@ -428,7 +446,7 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass
>   	u32 *fixup;
>   

>   	/* Populate extable entries only in the last pass */
> -	if (pass != 2)
> +	if (pass >= CODEGEN_MIN_PASSES)

This is wrong. Has to be:

     if (pass < CODEGEN_MIN_PASSES)


>   		return 0;
>   
>   	if (!fp->aux->extable ||

- Hari
