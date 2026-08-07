Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1206A47127E;
	Fri,  7 Aug 2026 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103011; cv=none; b=KNAHNv6IRS7xU7KzvlhxGFYXaA5cKiwBUZiWXobu/O2oElajSln4vtTye3T0dAcwd+bqRG0kgTLsO2swMymfmfRecVRbKfOmWV7lcUM6nxOltED58h1y40n3tCuoWa7tC2i1uYvSpgdSRyMq+9ljMWKdMVSPNBH1hUpkW9uj5HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103011; c=relaxed/simple;
	bh=ZuY7yrKh/FvEvwnT3ZXShF2gryyW9PxNeLTmIOnKCps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buv63TiJcX5lQ7EcGxUZo0V9yJOBmmkds2zMw9oPnnxlk52jNxnujXPqNSxf5RI8qLY4qDmx01INyjK8YzO8qeBkf8HDi9APlkcMweeghM1y7inHbGT/giMkj7UdRwmdyNY1wnc3LXhf0/ha8Jg7wTN4tfP1NPeLsDeytVUjknU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bvS5xtqb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bvS5xtqb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Hqpx4161784;
	Fri, 7 Aug 2026 11:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=p1TicfB5S0+K/h3RM
	ik8nu2lOBPxV0c+748/XkvTC54=; b=bvS5xtqbRlAtziQ7X9ay3xPRIzgynhzlG
	nPkus266M7I91gNUYU04cfChrazWi+6oMgMdBrmjCTwC5o9gzfNFDRq3GtEbicz4
	nhVkx6PRKdgWVdCMIC3VlKAbcCHQiz+dGllWxSo1f2xSayYT1balk8Zxtlfekau1
	Fgitho0WGMc7aFm0Yh1brZjahYp1CktGI9+EMgYA2L1fHEqfiS6lNvyH1I/tCY1I
	j+ayzi8zCQns/stzf5scaIPTJouLyoWh9coF+4nfysqGF41suFx+2rNLsg9c3gIY
	4rMpcDgXkQ1oGbLBGg8CM9pyRY11q9JSjMED9YD4uAifT9FXuBNzg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyunjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:42:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BfHVO005748;
	Fri, 7 Aug 2026 11:42:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgqa74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:42:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677BgrqN41091548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:42:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D7D02004F;
	Fri,  7 Aug 2026 11:42:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14E5720043;
	Fri,  7 Aug 2026 11:42:49 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.23.224])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 11:42:48 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v11 1/8] powerpc/bpf: fix alignment of long branch trampoline address
Date: Fri,  7 Aug 2026 17:12:36 +0530
Message-ID: <27ec08c30f6c37b3f25ba735f9cd7f81ff9e98d5.1786099877.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786099877.git.skb99@linux.ibm.com>
References: <cover.1786099877.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a75c4c1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=yPSppd1sqRoqKrzqNxkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX/HKO6lICbFig
 4itFK+/w0spsV2RzISlo7k4tCeyRrxsVPhrbOH+m0ah/3gxV1/DcDvNTiCaP1J6tPKp52yEI5I+
 188NXYNB7D2YFDbyISBOu3FMZiGmtNY=
X-Proofpoint-ORIG-GUID: b5eQ5oZXQCCkk3-dOuzTTGh7pWihMiJq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX1ptPrPrwad1S
 bbUhycPQF5fzbOpyq7vzut4ABlPjbq8Q7fvU2n7mFHBjJ1RMGNF/dnJL+NFwPVgZHDpsQjMWwnx
 dnmZqy1/s+DOKy48axCYgrIzBmBPrJ82HZB42xYC9pYqz9Bd7onYH8He3xxBPvTioCaqPGe68Fd
 W+LMj6B8GVwYcxw7enEZT62BJXhuqQvPUEFcBw82ZI64BjPeEqrooMAUutMpxeKYfrwm6S2I/GV
 FpNESMhuIBjyiFv1ekc0cL8MhoPrzTYeBMxEfnFp545nJ6p+eUnxP7AMofA6OoWQLThoXExFPeR
 TRoXPQ0wcZipuuXanvl91y7K8eEC9l83FiUWW02eFuNUdXhG7kKe57TSP4wiKH8fKEYbTh/VCxV
 oVdzUOSHkeuiVqdiApRm3PZorrRbAyeymGDIloZTFjSbXsmxOcW6vaETgRoOTw5edW2uxXFioyG
 YuZK+PIClWEv+ANNJqg==
X-Proofpoint-GUID: b5eQ5oZXQCCkk3-dOuzTTGh7pWihMiJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070087

From: Abhishek Dubey <adubey@linux.ibm.com>

Ensure the dummy trampoline address field present between the OOL stub
and the long branch stub is 8-byte aligned, for memory compatibility
when content loaded to a register.

Reported-by: Hari Bathini <hbathini@linux.ibm.com>
Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        |  7 +++---
 arch/powerpc/net/bpf_jit_comp.c   | 42 ++++++++++++++++++++++++++-----
 arch/powerpc/net/bpf_jit_comp32.c |  6 +++--
 arch/powerpc/net/bpf_jit_comp64.c |  7 +++---
 4 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index f32de8704d4d..6632de9871dd 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -214,10 +214,11 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
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
index 7b07b43575f1..f2e0f9755e65 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -49,11 +49,39 @@ asm (
 "	.popsection				;"
 );
 
-void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
+void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
 	int ool_stub_idx, long_branch_stub_idx;
+	int ool_stub_sz;
 
 	/*
+	 * In the final pass, align the mis-aligned dummy_tramp_addr field
+	 * in the fimage. The alignment NOP must appear before OOL stub,
+	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
+	 *
+	 * dummy_tramp_addr must be 8-byte aligned for load-register
+	 * compatibility. The fimage can be non 8-byte aligned, so final
+	 * alignment depends on start of fimage and the stub's instruction
+	 * count offset. The OOL stub size is 4 instructions (with
+	 * CONFIG_PPC_FTRACE_OUT_OF_LINE) or 3 instructions (without)
+	 * before dummy_tramp_addr.
+	 *
+	 * Emit a NOP here if (ctx->idx + ool_stub_sz) is odd, so that
+	 * dummy_tramp_addr lands at an even instruction offset (== 8-byte
+	 * aligned from an 8-byte aligned base).
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
+	 *      nop     // optional, for alignment of dummy_tramp_addr
 	 * Out-of-line stub:
 	 *	mflr	r0
 	 *	[b|bl]	tramp
@@ -70,7 +98,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
 
 	/*
 	 * Long branch stub:
-	 *	.long	<dummy_tramp_addr>
+	 *	.long	<dummy_tramp_addr>  // 8-byte aligned
 	 *	mflr	r11
 	 *	bcl	20,31,$+4
 	 *	mflr	r12
@@ -81,6 +109,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
 	 */
 	if (image)
 		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
+
 	ctx->idx += SZL / 4;
 	long_branch_stub_idx = ctx->idx;
 	EMIT(PPC_RAW_MFLR(_R11));
@@ -97,7 +126,8 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
 	}
 }
 
-int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr)
+int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx,
+							int tmp_reg, long exit_addr)
 {
 	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
 		PPC_JMP(exit_addr);
@@ -107,7 +137,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
 		PPC_JMP(ctx->alt_exit_addr);
 	} else {
 		ctx->alt_exit_addr = ctx->idx * 4;
-		bpf_jit_build_epilogue(image, ctx);
+		bpf_jit_build_epilogue(image, fimage, ctx);
 	}
 
 	return 0;
@@ -286,7 +316,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	 */
 	bpf_jit_build_prologue(NULL, &cgctx);
 	addrs[fp->len] = cgctx.idx * 4;
-	bpf_jit_build_epilogue(NULL, &cgctx);
+	bpf_jit_build_epilogue(NULL, NULL, &cgctx);
 
 	fixup_len = fp->aux->num_exentries * BPF_FIXUP_LEN * 4;
 	extable_len = fp->aux->num_exentries * sizeof(struct exception_table_entry);
@@ -318,7 +348,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			bpf_jit_binary_pack_free(fhdr, hdr);
 			goto out_err;
 		}
-		bpf_jit_build_epilogue(code_base, &cgctx);
+		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);
 
 		if (bpf_jit_enable > 1)
 			pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index bfdc50740da8..1cf12edf0343 100644
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
@@ -1150,6 +1150,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			 */
 			if (i != flen - 1) {
 				ret = bpf_jit_emit_exit_insn(image, ctx, _R0, exit_addr);
+				ret = bpf_jit_emit_exit_insn(image, fimage,
+								ctx, _R0, exit_addr);
 				if (ret)
 					return ret;
 			}
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index dab106cae22b..951eb10ca1f6 100644
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
2.54.0

