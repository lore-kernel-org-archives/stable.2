Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0173560AB8;
	Tue,  8 Sep 2026 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885173; cv=none; b=HwCkdgSlmKl02YPjr4YCY3TvCSh38TaSsCGQdvX5le3ls33DezGitPIS+c623j9D1BtBiQmKXMIoBy9ikAGa5fxb0QDfLAE9YwtVR5eaoZvXXlJpFxZNn8z+Z6mnUlS9U/Ni+GsBjhxx2ZXy8SotOHmMExzgW0A4Jp84cbJyqFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885173; c=relaxed/simple;
	bh=hxyK84WZMWTeJnIPqsaVrKcxdOmrbOjGwNHqq1oHNFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYyZMZfseN4y7CpeYg34Qb7NfPRV1nLhdPlcJAPfVdCLbZdnBTyqAyHVyfQlQRNSuFw9EKtpU+zssI4aQYhuRPDaBGUBCuvsptE/G1qe4QAIgir0saD4xr376o5RnprEdog3zVPWw4c82HMCzrp2V9irBG2f8rSy7xKode3G9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HOY//au3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HOY//au3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688F1nDa3545512;
	Tue, 8 Sep 2026 16:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/Pr9rg
	nWpZpQfukwiPLe0KDhy7H/TU+k1gEHwvB30Po=; b=HOY//au31cecP9lQ0JA/UF
	K6d0QqeJSu35BrJ8AO++Eilu9Z/EmyQI0fhKym+DnfcmRX99BTVGkhy7zFiz3XBf
	dDZTV37OGpkARLCf2d+sjPO89n7nj6FwZUwYDi7glKoKMctBAIXveEOakDBNxeVS
	DjJuTi4jrVOuZBnOtkhKiLkIQ6nypFI6cKPMyHrqrwzCYNba8VTolu7CYzLfgKI7
	2YpV4Rpg/ehn8y0pl8Y/A1UNXMiEwdCH5IS8NZ18eSqaAuv8ugoBCBYkTiMAM1u+
	G3gLoY1wI+1IfbNseTVbZnTX70PREADXDRVKBv6K7xZ4O2rhS27HvJ4HIPS3D/lg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqk0cgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:32:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GQH1x012039;
	Tue, 8 Sep 2026 16:32:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgcw18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:32:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688GWRkw43057564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 16:32:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C37120040;
	Tue,  8 Sep 2026 16:32:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B45A2004E;
	Tue,  8 Sep 2026 16:32:21 +0000 (GMT)
Received: from [9.61.253.97] (unknown [9.61.253.97])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 16:32:21 +0000 (GMT)
Message-ID: <418fbfa0-9e0a-4bf9-927d-cfd5b08aa087@linux.ibm.com>
Date: Tue, 8 Sep 2026 22:02:18 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 4/8] powerpc/bpf: fix alignment of long branch
 trampoline address
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1788154635.git.skb99@linux.ibm.com>
 <0700c866205c8fa2f861e4b8d64fdf7469cba021.1788154635.git.skb99@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <0700c866205c8fa2f861e4b8d64fdf7469cba021.1788154635.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZhBeWIODrlAC0a4JgSzLiPqJoZlpMRKL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX+yci4Pm7iZZq
 U9kSQLtaCAid0vwx+EK58V0F+FXUjK0vZImmcpVAMVZfcLnwKpJ3+FZ4ZiiGlEh4iRyKX9uUMBv
 +99xgka/Lgi66SjSz2eeaxHtihB6LyE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX/AEe1LB2B3kW
 NLxWRytYovdTTJmR7HFQn8r1pn7OPcpCFUAJne1GJpGGBBM1v/DxsiQazyQWNHP5u5QCQehW2EI
 ZawU0+hH53C9YaOlfP7jr8oZFPblL5+LM0PJbgXa/PUijPZy/1MvfqlFIzZvmR/LjiqNZdAu9Vu
 X0IzdPZV4gGtgB4+OY9DPhoV6cnWPvzfO0j3Zs4HqjSHGvJr6NsS825oJ5JHnFIzpVjEG+9eWoA
 l9gSWAXY2Acq40Ls399zdeht7XWeIXOG+7X4vkTWmNCGrkHGiPbz+DMBH3SCV/ETtDz9BycqrTj
 SAjhFPTljtqH0+PPPd/mz92LnOrMF9y55fITbYc3a4RNeOS/vEESCieEh6u6EJp0KL9dEoLExgA
 +JsLs3CaZ5IksRLx8O82XWgMgWmJQs8J2yD3gdEAIq/jNJcvxlzprWma78Udy/s0hqwKtgFt/oy
 caQ8yjPqf9HhDa+l6hw==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6aa0389f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=VNu502hshFYAAzP5LJgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZhBeWIODrlAC0a4JgSzLiPqJoZlpMRKL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080178


On 31.08.2026 12:46 PM, Saket Kumar Bhaskar wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
>
> Ensure the dummy trampoline address field present between the OOL stub
> and the long branch stub is 4/8-byte aligned, for memory compatibility
> when content loaded to a register.
>
> Reported-by: Hari Bathini <hbathini@linux.ibm.com>
> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   arch/powerpc/net/bpf_jit.h        |  7 +++---
>   arch/powerpc/net/bpf_jit_comp.c   | 38 ++++++++++++++++++++++++++-----
>   arch/powerpc/net/bpf_jit_comp32.c |  7 +++---
>   arch/powerpc/net/bpf_jit_comp64.c |  7 +++---
>   4 files changed, 44 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 6d58df361648..4da8bde92e1e 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -227,10 +227,11 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>   int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
>   		       u32 *addrs, int pass, bool extra_pass);
>   void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
> -void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx);
> +void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx);
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx);
>   void bpf_jit_realloc_regs(struct codegen_context *ctx);
> -int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
> +int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx, int tmp_reg,
> +										long exit_addr);
>   void prepare_for_fsession_fentry(u32 *image, struct codegen_context *ctx, int cookie_cnt,
>   								int cookie_off, int retval_off);
>   void store_func_meta(u32 *image, struct codegen_context *ctx, u64 func_meta, int func_meta_off);
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 11981d2270a9..8ca36a933c7a 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -49,11 +49,35 @@ asm (
>   "	.popsection				;"
>   );
>   
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
>   {
>   	int ool_stub_idx, long_branch_stub_idx;
> +	int ool_stub_sz;
>   
>   	/*
> +	 * Align the mis-aligned dummy_tramp_addr field in the fimage.
> +	 * The alignment NOP must appear before OOL stub, to make
> +	 * ool_stub_idx & long_branch_stub_idx constant from end.
> +	 *
> +	 * The fimage can be non 8-byte aligned, so final alignment depends
> +	 * on start of fimage and the stub's instruction count offset. The
> +	 * OOL stub size is 4 instructions (with CONFIG_PPC_FTRACE_OUT_OF_LINE)
> +	 * or 3 instructions (without) before dummy_tramp_addr.
> +	 *
> +	 * Emit a NOP here if address is not SZL aligned.
> +	 *
> +	 * In pass=0 when image==NULL, conservatively account for space
> +	 * required to accommodate alignment NOP. In case final pass skips
> +	 * emitting alignment NOP, the image buffer have 4 spare bytes and
> +	 * jited_len signifies correct program size.
> +	 */
> +
> +	ool_stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
> +	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub_sz, SZL))
> +		EMIT(PPC_RAW_NOP());
> +
> +	/*
> +	 *	nop     // optional, for alignment of dummy_tramp_addr
>   	 * Out-of-line stub:
>   	 *	mflr	r0
>   	 *	[b|bl]	tramp
> @@ -70,7 +94,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
>   
>   	/*
>   	 * Long branch stub:
> -	 *	.long	<dummy_tramp_addr>
> +	 *	.long	<dummy_tramp_addr>  // 8-byte aligned
>   	 *	mflr	r11
>   	 *	bcl	20,31,$+4
>   	 *	mflr	r12
> @@ -81,6 +105,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
>   	 */
>   	if (image)
>   		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
> +
>   	ctx->idx += SZL / 4;
>   	long_branch_stub_idx = ctx->idx;
>   	EMIT(PPC_RAW_MFLR(_R11));
> @@ -97,7 +122,8 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
>   	}
>   }
>   
> -int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr)
> +int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx,
> +							int tmp_reg, long exit_addr)
>   {
>   	if (exit_addr && is_offset_in_branch_range(exit_addr - (long)(ctx->idx * 4))) {
>   		PPC_JMP(exit_addr);
> @@ -106,7 +132,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
>   		PPC_JMP(ctx->alt_exit_addr);
>   	} else {
>   		ctx->alt_exit_addr = ctx->idx * 4;
> -		bpf_jit_build_epilogue(image, ctx);
> +		bpf_jit_build_epilogue(image, fimage, ctx);
>   	}
>   
>   	return 0;
> @@ -286,7 +312,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   	 */
>   	bpf_jit_build_prologue(NULL, &cgctx);
>   	addrs[fp->len] = cgctx.idx * 4;
> -	bpf_jit_build_epilogue(NULL, &cgctx);
> +	bpf_jit_build_epilogue(NULL, NULL, &cgctx);
>   
>   	fixup_len = fp->aux->num_exentries * BPF_FIXUP_LEN * 4;
>   	extable_len = fp->aux->num_exentries * sizeof(struct exception_table_entry);
> @@ -322,7 +348,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   			goto out_err;
>   		}
>   		addrs[fp->len] = cgctx.idx * 4;
> -		bpf_jit_build_epilogue(code_base, &cgctx);
> +		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);
>   
>   		proglen = cgctx.idx * 4;
>   
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index bfdc50740da8..f5b9441cf46a 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -229,7 +229,7 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
>   
>   }
>   
> -void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx)
>   {
>   	EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0)));
>   
> @@ -237,7 +237,7 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
>   
>   	EMIT(PPC_RAW_BLR());
>   
> -	bpf_jit_build_fentry_stubs(image, ctx);
> +	bpf_jit_build_fentry_stubs(image, fimage, ctx);
>   }
>   
>   /* Relative offset needs to be calculated based on final image location */
> @@ -1149,7 +1149,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   			 * we'll just fall through to the epilogue.
>   			 */
>   			if (i != flen - 1) {
> -				ret = bpf_jit_emit_exit_insn(image, ctx, _R0, exit_addr);
> +				ret = bpf_jit_emit_exit_insn(image, fimage,
> +								ctx, _R0, exit_addr);
>   				if (ret)
>   					return ret;
>   			}
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 59302cabc466..e80312171aa7 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -398,7 +398,7 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
>   	}
>   }
>   
> -void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx)
>   {
>   	bpf_jit_emit_common_epilogue(image, ctx);
>   
> @@ -407,7 +407,7 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
>   
>   	EMIT(PPC_RAW_BLR());
>   
> -	bpf_jit_build_fentry_stubs(image, ctx);
> +	bpf_jit_build_fentry_stubs(image, fimage, ctx);
>   }
>   
>   /*
> @@ -1737,7 +1737,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   			 * we'll just fall through to the epilogue.
>   			 */
>   			if (i != flen - 1) {
> -				ret = bpf_jit_emit_exit_insn(image, ctx, tmp1_reg, exit_addr);
> +				ret = bpf_jit_emit_exit_insn(image, fimage, ctx,
> +								tmp1_reg, exit_addr);
>   				if (ret)
>   					return ret;
>   			}

-- 
Thanks and Regards
R.Nageswara Sastry

