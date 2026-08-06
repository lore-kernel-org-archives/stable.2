Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FFD44E677;
	Thu,  6 Aug 2026 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036544; cv=none; b=rQbZB9sgAkYEIhEdavO6ZmjMV7dL1s5ObPN7gW0+X2kA8ymh92omC/rtLZ7v2ywnZfkcc5F+RFVys6EkhdmKc7JEOVKBjvEbMdvN47uzUe4GGtdgRMgEFS5oA8Z4Kdfjy5vZl7aET1eUVRKIaZfgjWsBXvU5C//C8OGttENnLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036544; c=relaxed/simple;
	bh=ha5QBk1yWOiy4lWNRVG9FJv6MtwNkRHwOydFUNFwKXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/4sfLYEi25d07p5NIqc/sNFmbB4NtaLNan5TwdDz+Ogot73REmEMf3IRToPzwbqtfMg5hS0N5zPa9cCHMFe7BRJEDEmvVguuTnokoyMnUgo3Ow/0CoihzE//sGMG4th7O9EsbEI/G0gNnnQOXgUlfHICuvIhcpbyZLlcEnTHQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EQrGpcce; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EQrGpcce"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676End5Y2866541;
	Thu, 6 Aug 2026 17:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1alqfZ
	1jTe2JAaWwmSa1hG3KVu9zh4ggV1HcL7tjo8o=; b=EQrGpccenRbHLJyuD2SZcB
	AH0poMT2CghXuHj0HzzG7mCAu7p5SEEHlGTXt3qOihqsB0jBXYNKQ3pdUcIlEu+y
	k2p0kz8A/2gcbzSZ+qIGsSRRzGgIxLMysoQjf9DdBPjx+hcjOnOkCC4WqX8bi+68
	px0D27gQPDxfVhk9RwU0D7R9kUrkE8/hdL91cdSAHaVvtoYoTVjlFJ/3z33A/HcE
	U4tn9ch4fvnrh/GKfgX3TrQRNPZmHsX8xX6yTuNjHrxvMzra5BNZovfQZSHNTVY0
	ixdy6dYCQk3HSh7TspNT0qjollgT2uaCh5b065/wpIiKo3wBDtu3hMq7g2aS4/uA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gh06b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:15:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HBFjQ027429;
	Thu, 6 Aug 2026 17:15:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwc869-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:15:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676HFGCt22413980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:15:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 366FE2004D;
	Thu,  6 Aug 2026 17:15:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5031420040;
	Thu,  6 Aug 2026 17:15:13 +0000 (GMT)
Received: from [9.124.215.184] (unknown [9.124.215.184])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:15:13 +0000 (GMT)
Message-ID: <47182652-a719-4be8-a7a7-6e864fde2bbc@linux.ibm.com>
Date: Thu, 6 Aug 2026 22:45:11 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/8] powerpc/bpf: fix alignment of long branch
 trampoline address
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1785906979.git.skb99@linux.ibm.com>
 <26e8e6fa5d0279ec92281d5324678f00294e2cb7.1785906979.git.skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <26e8e6fa5d0279ec92281d5324678f00294e2cb7.1785906979.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzMSBTYWx0ZWRfX0XEBMogXoNPA
 oWj0hI9Iq7BoDNYqQuMmge1+Y69yUdAKf1KHidLQosuNG4VQ0JoD8CwbUJmTe0zl2P3V+MiCJW8
 QiTEIrMaX+mVG52Tc0iohlwxfDpVNsE+8PoOdMXwQv4NP0xk5sX15LJYyIJuX1PO6h5XXpoUhsF
 4RJi4lmrLdHJGid2JugKWy01Xdgp/bJx3B3iaEyTuIiq+cf7PlIJzI1cwjGhRu3U964jdWaMuJ2
 AZaAkkU98NDuaT9HLDgNuFaydNZfcst7VugOlWKa+l+7YBIkmD6zZrDbvGshiM8OjYfDyzbinwW
 5GjBpN/qPr5RiDZchrA7QjPRFotoyzq/CQbtTS/KX0rOp1euQ6TLyANiqSX5xRryvbiKrhaQuPw
 7Q46XZ2eqBQS1dTynXUiOMpU2c9bN+PJ1CfIn78BljdNAjMEWPqdZdl7Mfur/5aUUVEhb+ECI61
 e/EbGwt/nkBv+M62jog==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a74c129 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=kQundSBVMOOzkBbW8r0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8xqp97YAn34uLoj_m-KsiFF1TVYMAhPk
X-Proofpoint-ORIG-GUID: 8xqp97YAn34uLoj_m-KsiFF1TVYMAhPk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzMSBTYWx0ZWRfXzRJoBamWP5RR
 kazw5V+o3CNCI9suQCqHnbNpAz5A/VFVgq0/7MUZ4yug5JIiFRTolZiV98WwupUR4p8LCQigI6I
 3uE9Ikp+KYKvrML7RUkFm5RTfvv4cr8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060131



On 05/08/26 11:36 am, Saket Kumar Bhaskar wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Ensure the dummy trampoline address field present between the OOL stub
> and the long branch stub is 8-byte aligned, for memory compatibility
> when content loaded to a register.

This fix is not complete. With 2/8 it looks complete. Some part
of it needs to be in this patch instead..

> 
> Reported-by: Hari Bathini <hbathini@linux.ibm.com>
> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
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
> index 7b07b43575f1..42046f73c279 100644
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
> +	int ool_stub_sz;
>   
>   	/*
> +	 * In the final pass, align the mis-aligned dummy_tramp_addr field
> +	 * in the fimage. The alignment NOP must appear before OOL stub,
> +	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
> +	 *
> +	 * dummy_tramp_addr must be 8-byte aligned for load-register
> +	 * compatibility. The fimage can be non 8-byte aligned, so final
> +	 * alignment depends on start of fimage and the stub's instruction
> +	 * count offset. The OOL stub size is 4 instructions (with
> +	 * CONFIG_PPC_FTRACE_OUT_OF_LINE) or 3 instructions (without)
> +	 * before dummy_tramp_addr.
> +	 *
> +	 * Emit a NOP here if (ctx->idx + ool_stub_sz) is odd, so that
> +	 * dummy_tramp_addr lands at an even instruction offset (== 8-byte
> +	 * aligned from an 8-byte aligned base).
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
> index dab106cae22b..ed78992f4dac 100644
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
