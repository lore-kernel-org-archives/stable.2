Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBB33E1718;
	Sat, 13 Jun 2026 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781354117; cv=none; b=hRE4i04iL8wNc7f1M9lVnJVfZ8AOdNDRXaHy2KhfbSUpc+DizbruJnPVE5yG+c59qqwP8d3wo639pJe7MCgTODUM11TNpZfN4dZiO7fzvdGL2eDhn5VycTbJysq4813hHANQUKVzT6fu5Q/M6nWiTYpwPYwM/ZEvu1qCKqi5paU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781354117; c=relaxed/simple;
	bh=PLn0Z3DywYxyO1h/Nzf6a2hgSxKEJ7fFPPTRh+5EmqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHCrpsvPplAKooklUidKmQdg0I3jei3QHC1g5Z8qEumTGX+3QspXGj6DSBrA2kdXxkVuLFaSYGvgCNw23iy68R/Pgnd8vJA2uIEp9XYDsZotD8DwewLqDUMpL4w+X4/7ciuI6OX8DLv/YuBM9MwmeJZ2rnl/YuyoGQGwow57VxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rWRpB4fW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rWRpB4fW"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DBJH33620416;
	Sat, 13 Jun 2026 12:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4eKiKS
	yYB4BO3mkNQrS0tplJVDJjRKWjlm96EQJJ8DU=; b=rWRpB4fWpFZT2xLb9y8zQZ
	epKuNw7mgHfYMqh12Uwp8Egh+XzZHfdkHuEt+W36SC5bY5Ku4V+e5CfDUrLXxO1S
	XVi6F4kiYO03niXyLu9DEWaaalwTcwcMe+/pb32/Y9FQoBs0Z9uWxuS5iARq7LTn
	GTN46ajoccn4L08VaXUMOHc83ToUb+zBJQz7B9IETgfOeJEbdPifJuj8OuKtC0Bb
	ASM6YLdUcMzI6Jqj+WCfhlxeGHGoICawryvWD6FPyPrnSshYAULg86cB/Ipg9cLf
	oq+x4OsEFPfZ+Sz00spLw4mAVoJer1rDdUo82s+XNQy/w7547zUHUloIB5C8Maaw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u08njc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 12:34:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65DCYdrT013758;
	Sat, 13 Jun 2026 12:34:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09uy2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 12:34:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65DCYovJ55574992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jun 2026 12:34:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D497C20043;
	Sat, 13 Jun 2026 12:34:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2815020040;
	Sat, 13 Jun 2026 12:34:48 +0000 (GMT)
Received: from [9.124.210.219] (unknown [9.124.210.219])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jun 2026 12:34:47 +0000 (GMT)
Message-ID: <ed79e55e-d04e-41ef-b969-ca09eb2a6043@linux.ibm.com>
Date: Sat, 13 Jun 2026 18:04:46 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] powerpc/bpf: fix alignment of long branch
 trampoline address
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20260611153826.31187-1-adubey@linux.ibm.com>
 <20260611153826.31187-2-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260611153826.31187-2-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3PPAdfD_fd-uoN9_J7v0D6AqxPhdgJge
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a2d4e6f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=kQundSBVMOOzkBbW8r0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDEyNSBTYWx0ZWRfX5enMjNJjBCJ+
 X3RPRk2Mk2eq/TOVFkSTOkx7h5qEo1UCRG2xV52okZlPhKlZKPUQnz6cZgoOQ8IHbu1/1JuXF7w
 65neVJGgzg30uoaK3Nx411fcT6KPRIW6uSxY0smI70SQdg90lc0fOzkz982AEqIIlzqDxHlJr/9
 QKC6h2Pb4XopjGP/D2miF/BDUTJ90dNhE6d8C2zgUNXtTc3xRLip51iqdHNJycrLCXnafOn3Y1H
 vlffNT9N/8jfi22pjgGIEFIb+RTbwzuuHhndT7kssGh1T2a0KkJwmM7npfyvy7EISgcI/+q+x39
 ahbYs10edzJgtAFxkfTKC+rp0Mo4UW49OzZGZo7S0ZsrehqxmLUs4wDAdyzHt6NipFjcaX9Z9Cs
 TyRtAh8ZiksF3B7/nQAETnVxvUoHySzdFKwbx1T6KPSPMjoU4rMAadYzhV4E6VLTVuNo3nkTd1W
 kDvWjGoLrybJh2+xFiA==
X-Proofpoint-ORIG-GUID: 3PPAdfD_fd-uoN9_J7v0D6AqxPhdgJge
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDEyNSBTYWx0ZWRfX1qdKsOTbMe43
 Z7dCPcGGuV674DzxLj2rw8jND6vyL8gvOMRii6lXBeYpetlinlHjdAJzUGepms2e4RUtlAyFLxj
 biRQu+r4Pt/9G6OS7wE8DLHYWUTu3rM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130125



On 11/06/26 9:08 pm, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Ensure the dummy trampoline address field present between the OOL stub
> and the long branch stub is 8-byte aligned, for memory compatibility
> when content loaded to a register.
> 
> Reported-by: Hari Bathini <hbathini@linux.ibm.com>
> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
> Cc: stable@vger.kernel.org

Except for a couple of minor nits below, the patch looks good to me

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit.h        |  4 ++--
>   arch/powerpc/net/bpf_jit_comp.c   | 39 +++++++++++++++++++++++++++----
>   arch/powerpc/net/bpf_jit_comp32.c |  4 ++--
>   arch/powerpc/net/bpf_jit_comp64.c |  4 ++--
>   4 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index f32de8704d4d..71e6e7d01057 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -214,8 +214,8 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>   int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
>   		       u32 *addrs, int pass, bool extra_pass);
>   void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
> -void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx);
> +void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx);
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx);
>   void bpf_jit_realloc_regs(struct codegen_context *ctx);
>   int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
>   void prepare_for_fsession_fentry(u32 *image, struct codegen_context *ctx, int cookie_cnt,
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 6351a187ca61..79288ff789b5 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -49,11 +49,39 @@ asm (
>   "	.popsection				;"
>   );
>   
> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
>   {
>   	int ool_stub_idx, long_branch_stub_idx;
> +	int ool_instrs;
>   
>   	/*
> +	 * In the final pass, align the mis-aligned dummy_tramp_addr field
> +	 * in the fimage. The alignment NOP must appear before OOL stub,
> +	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
> +	 *
> +	 * dummy_tramp_addr must be 8-byte aligned for load-register
> +	 * compatibility. The fimage can be non 8-byte aligned, so final
> +	 * alignment depends on start of fimage and the stub's instruction
> +	 * count offset. The OOL stub has 4 instructions (with

s/stub's instruction count offset/OOL stub size/

> +	 * CONFIG_PPC_FTRACE_OUT_OF_LINE) or 3 instructions (without)
> +	 * before dummy_tramp_addr.
> +	 *
> +	 * Emit a NOP here if (ctx->idx + ool_instrs) is odd, so that
> +	 * dummy_tramp_addr lands at an even instruction offset (== 8-byte
> +	 * aligned from an 8-byte aligned base).
> +	 *
> +	 * In pass=0 when image==NULL, conservatively account for space
> +	 * required to accommodate alignment NOP. In case final pass skips
> +	 * emitting alignment NOP, the image buffer have 4 spare bytes and
> +	 * jited_len signifies correct program size.
> +	 */
> +
> +	ool_instrs = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4*4 : 3*4;

ool_stub_sz sounds like a better name here instead of ool_instrs..
As the comment above already mentioned the no. of instructions in
each case, this could simply be:

     ool_stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;

> +	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_instrs, SZL))
> +		EMIT(PPC_RAW_NOP());
> +
> +	/*
> +	 *      nop     // optional, for alignment of dummy_tramp_addr
>   	 * Out-of-line stub:
>   	 *	mflr	r0
>   	 *	[b|bl]	tramp
> @@ -70,7 +98,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
>   
>   	/*
>   	 * Long branch stub:
> -	 *	.long	<dummy_tramp_addr>
> +	 *	.long	<dummy_tramp_addr>  // 8-byte aligned
>   	 *	mflr	r11
>   	 *	bcl	20,31,$+4
>   	 *	mflr	r12
> @@ -81,6 +109,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
>   	 */
>   	if (image)
>   		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
> +
>   	ctx->idx += SZL / 4;
>   	long_branch_stub_idx = ctx->idx;
>   	EMIT(PPC_RAW_MFLR(_R11));
> @@ -107,7 +136,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
>   		PPC_JMP(ctx->alt_exit_addr);
>   	} else {
>   		ctx->alt_exit_addr = ctx->idx * 4;
> -		bpf_jit_build_epilogue(image, ctx);
> +		bpf_jit_build_epilogue(image, NULL, ctx);
>   	}
>   
>   	return 0;
> @@ -286,7 +315,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   	 */
>   	bpf_jit_build_prologue(NULL, &cgctx);
>   	addrs[fp->len] = cgctx.idx * 4;
> -	bpf_jit_build_epilogue(NULL, &cgctx);
> +	bpf_jit_build_epilogue(NULL, NULL, &cgctx);
>   
>   	fixup_len = fp->aux->num_exentries * BPF_FIXUP_LEN * 4;
>   	extable_len = fp->aux->num_exentries * sizeof(struct exception_table_entry);
> @@ -318,7 +347,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   			bpf_jit_binary_pack_free(fhdr, hdr);
>   			goto out_err;
>   		}
> -		bpf_jit_build_epilogue(code_base, &cgctx);
> +		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);
>   
>   		if (bpf_jit_enable > 1)
>   			pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index bfdc50740da8..95bda0dee925 100644
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
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index db364d9083e7..885dc8cf55a2 100644
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

- Hari
