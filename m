Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B137CD33;
	Mon, 28 Sep 2026 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790572490; cv=none; b=BOpXh6owaJZO9eIedX1LubVQZGDDRp+So2X7ISJjiwSzcpI+AMl1VYscjlweldhe9vcdlWFg8S5K99qMUP0ZGetHW+zvnL+9rZDq5h92S8EGZ50q4mTt9y0H0pbAhnYLId4lFAUhJoSfvY7Cho6Lad2hSiyrbWD559LDrpwHUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790572490; c=relaxed/simple;
	bh=0pbS8yForhkw/sBsBdPoWZjOFdJQNmVAiLhFYr52eH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUuZELidd1WBvr91csLtOxLNwmQU96WqI6mbVRe0J9h5TbQZZ04xLPzTOOLtXOX65f9MgRyo29CSvizJ/Dos2/ETrlbWVs7q19fS6ZBzK3T4/DhVLkKLAd4Dy728OIlG7ppKaxODI962HsnH1NaivHi6/Kvlm3UKsDIDi6805bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pterlPNP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pterlPNP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RGkCHK029971;
	Mon, 28 Sep 2026 05:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fPu3VM7MHRIxvN+db
	oYa9a2eIL5CLfWKDnv7WVgLLyQ=; b=pterlPNPneP1Dm1zvHX0ZcgCu8k0ABoZD
	i14BD+WfI6uN0iC1jSu7ajwGKCEk3cClcB3MKPg8fwtFSpNLsgz2RJ9/YmGYKS59
	Esea1CHW/EzzILGQwquXYCYKDmMNzc/0djExo43u7h/126oPyueBNPC1OftJ+dyG
	+dIIdrRxBOVCf8Xs5xdTiVzVmar823mzC4nuChUSk7CFNKtasIXgbxtjmRXUQuES
	leidrrOndJGqvxPLWB0Wo/7/apFeJoHTxylhzi11GpkAfOf+UO5uoAkC+V3lO7Kk
	mpKaKjgaXs+6GmimEK/zz7/QpYPm+I64k8xOxFdPVtneKppzs9oWg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fjydpu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:14:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S3vZRc2157270;
	Mon, 28 Sep 2026 05:14:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhbpj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:14:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5EGSU44040486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:14:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B742920049;
	Mon, 28 Sep 2026 05:14:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BCDB20040;
	Mon, 28 Sep 2026 05:14:13 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.124.213.52])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:14:13 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v14 4/5] powerpc/bpf: fix alignment of long branch trampoline address
Date: Mon, 28 Sep 2026 10:43:53 +0530
Message-ID: <a8257022057cbb71928c960be589e10b89fc0899.1789982239.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789982239.git.skb99@linux.ibm.com>
References: <cover.1789982239.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZakP4zwlr-Kps13dPEir-i9wwoAS9o1c
X-Proofpoint-GUID: ZakP4zwlr-Kps13dPEir-i9wwoAS9o1c
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMCBTYWx0ZWRfXxZhcMHs82yDT
 s0AMKZ9HWUcarQwwkUNK1eCILm6YxH5Nu36IaXqYLPzKmYofC4E1Iol7q+m++O+ZpIe/9zeWQ8C
 X4vBMYoE35VSovB0pzq3W/KUDaTvP6Y=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6ab9f7ad cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=1ZwUXZqBZyzGt74GWIUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMCBTYWx0ZWRfX3EsZuq++xriJ
 ZnMl7KWzlICd1LLupAu4gOo5eh15owTEXadQDhvQcVGz7/xDU5jkMiLOHReR5E6q5fZCxFaAU77
 GbO4kPZVff2JBeX8CCn43B7bWd8B5ROplJcE6Cjk0zAB2zl8CzpepoSLbGRnZlaC5SUHq5BJFd3
 lS1JU5NoA8pc7QfgcCpD0+zxjcDk/aqEOv2BJ6WaE8hS0FU8fTCkCk/cXUkeIhdWM2sMyR8c05C
 yUVVYofqtKG8G1YQOadQJ8tkfBuwVY6Tz6J8KJUpbc+019Pmak/c7fKbuXrJyVr+/WpzUVUp0UB
 lXzOrZ5EuSFnFu3eqtTztWaE2qotxIg+dCBZX0tvrExacmqxGRQ4iMrNl13qtybfMVMbFqbP2g0
 fYc4nuqLQ9yNF59/6to39qC0sZcyYGMa58SJfD0olGlVj5JdEzMNn00/ogiCvVyYjIfD7s/6wsD
 L3kV0o3f8N5d9jrDyqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280020

From: Abhishek Dubey <adubey@linux.ibm.com>

Ensure the dummy trampoline address field present between the OOL stub
and the long branch stub is 4/8-byte aligned, for memory compatibility
when content loaded to a register.

Reported-by: Hari Bathini <hbathini@linux.ibm.com>
Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        |  7 +++---
 arch/powerpc/net/bpf_jit_comp.c   | 38 ++++++++++++++++++++++++++-----
 arch/powerpc/net/bpf_jit_comp32.c |  7 +++---
 arch/powerpc/net/bpf_jit_comp64.c |  7 +++---
 4 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 6d58df361648..4da8bde92e1e 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -227,10 +227,11 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
 int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
 		       u32 *addrs, int pass, bool extra_pass);
 void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
-void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
-void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx);
+void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx);
+void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx);
 void bpf_jit_realloc_regs(struct codegen_context *ctx);
-int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
+int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx, int tmp_reg,
+										long exit_addr);
 void prepare_for_fsession_fentry(u32 *image, struct codegen_context *ctx, int cookie_cnt,
 								int cookie_off, int retval_off);
 void store_func_meta(u32 *image, struct codegen_context *ctx, u64 func_meta, int func_meta_off);
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 11981d2270a9..8ca36a933c7a 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -49,11 +49,35 @@ asm (
 "	.popsection				;"
 );
 
-void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
+void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
 	int ool_stub_idx, long_branch_stub_idx;
+	int ool_stub_sz;
 
 	/*
+	 * Align the mis-aligned dummy_tramp_addr field in the fimage.
+	 * The alignment NOP must appear before OOL stub, to make
+	 * ool_stub_idx & long_branch_stub_idx constant from end.
+	 *
+	 * The fimage can be non 8-byte aligned, so final alignment depends
+	 * on start of fimage and the stub's instruction count offset. The
+	 * OOL stub size is 4 instructions (with CONFIG_PPC_FTRACE_OUT_OF_LINE)
+	 * or 3 instructions (without) before dummy_tramp_addr.
+	 *
+	 * Emit a NOP here if address is not SZL aligned.
+	 *
+	 * In pass=0 when image==NULL, conservatively account for space
+	 * required to accommodate alignment NOP. In case final pass skips
+	 * emitting alignment NOP, the image buffer have 4 spare bytes and
+	 * jited_len signifies correct program size.
+	 */
+
+	ool_stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
+	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub_sz, SZL))
+		EMIT(PPC_RAW_NOP());
+
+	/*
+	 *	nop     // optional, for alignment of dummy_tramp_addr
 	 * Out-of-line stub:
 	 *	mflr	r0
 	 *	[b|bl]	tramp
@@ -70,7 +94,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
 
 	/*
 	 * Long branch stub:
-	 *	.long	<dummy_tramp_addr>
+	 *	.long	<dummy_tramp_addr>  // 8-byte aligned
 	 *	mflr	r11
 	 *	bcl	20,31,$+4
 	 *	mflr	r12
@@ -81,6 +105,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
 	 */
 	if (image)
 		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
+
 	ctx->idx += SZL / 4;
 	long_branch_stub_idx = ctx->idx;
 	EMIT(PPC_RAW_MFLR(_R11));
@@ -97,7 +122,8 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
 	}
 }
 
-int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr)
+int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx,
+							int tmp_reg, long exit_addr)
 {
 	if (exit_addr && is_offset_in_branch_range(exit_addr - (long)(ctx->idx * 4))) {
 		PPC_JMP(exit_addr);
@@ -106,7 +132,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
 		PPC_JMP(ctx->alt_exit_addr);
 	} else {
 		ctx->alt_exit_addr = ctx->idx * 4;
-		bpf_jit_build_epilogue(image, ctx);
+		bpf_jit_build_epilogue(image, fimage, ctx);
 	}
 
 	return 0;
@@ -286,7 +312,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	 */
 	bpf_jit_build_prologue(NULL, &cgctx);
 	addrs[fp->len] = cgctx.idx * 4;
-	bpf_jit_build_epilogue(NULL, &cgctx);
+	bpf_jit_build_epilogue(NULL, NULL, &cgctx);
 
 	fixup_len = fp->aux->num_exentries * BPF_FIXUP_LEN * 4;
 	extable_len = fp->aux->num_exentries * sizeof(struct exception_table_entry);
@@ -322,7 +348,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			goto out_err;
 		}
 		addrs[fp->len] = cgctx.idx * 4;
-		bpf_jit_build_epilogue(code_base, &cgctx);
+		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);
 
 		proglen = cgctx.idx * 4;
 
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index bfdc50740da8..f5b9441cf46a 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -229,7 +229,7 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
 
 }
 
-void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
+void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
 	EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0)));
 
@@ -237,7 +237,7 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 
 	EMIT(PPC_RAW_BLR());
 
-	bpf_jit_build_fentry_stubs(image, ctx);
+	bpf_jit_build_fentry_stubs(image, fimage, ctx);
 }
 
 /* Relative offset needs to be calculated based on final image location */
@@ -1149,7 +1149,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			 * we'll just fall through to the epilogue.
 			 */
 			if (i != flen - 1) {
-				ret = bpf_jit_emit_exit_insn(image, ctx, _R0, exit_addr);
+				ret = bpf_jit_emit_exit_insn(image, fimage,
+								ctx, _R0, exit_addr);
 				if (ret)
 					return ret;
 			}
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 59302cabc466..e80312171aa7 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -398,7 +398,7 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
 	}
 }
 
-void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
+void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
 	bpf_jit_emit_common_epilogue(image, ctx);
 
@@ -407,7 +407,7 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 
 	EMIT(PPC_RAW_BLR());
 
-	bpf_jit_build_fentry_stubs(image, ctx);
+	bpf_jit_build_fentry_stubs(image, fimage, ctx);
 }
 
 /*
@@ -1737,7 +1737,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			 * we'll just fall through to the epilogue.
 			 */
 			if (i != flen - 1) {
-				ret = bpf_jit_emit_exit_insn(image, ctx, tmp1_reg, exit_addr);
+				ret = bpf_jit_emit_exit_insn(image, fimage, ctx,
+								tmp1_reg, exit_addr);
 				if (ret)
 					return ret;
 			}
-- 
2.55.0

