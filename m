Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B6C38B7BA;
	Tue, 23 Jun 2026 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242116; cv=none; b=D8mfmu+f3ISm7ZUEGCteeo2ZvgB9ThFiyddRu9wOcQnFcl/aG29SdKnpT7UkCFCj1WkqsBKz8C6HgY5JDTGMdgn7/eh1f88Oa6TII76NTpU7S6dmw8oRQY49t9kGOOBjgseCQ9JaSQ3mPSl5t7+qREcE+pPePcK4270fOc9aiPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242116; c=relaxed/simple;
	bh=Cx1cpFsSxGKqH3S8+uOuy+M4sXC+w6hHoDCahciqo5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yz6xTGQXMioIYUK5OgCzmVn+gubEBIYx+6XseF/e8JOF7s1TcZttCBi6JrMhn/oPOdt7A1Y+konNiOppFCuZ1unL+fLjvRl9Od/3r3EDWhcOcWeOE/xJgCFpo9k1dy2RHwFE2lY9W5ypaOt+k26SaK53loPB9T3DKvNWEoKTz8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pzDOmrSi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pzDOmrSi"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmjwr1915054;
	Tue, 23 Jun 2026 19:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XzASNmUZXRdE1fFTo
	yHPMzvk4NTtP3tKfuXhnXDNQ2A=; b=pzDOmrSiWXrQni5a+zxevKGE/quGo0LI6
	63fcfdqxA0jnBfHJ+G3swYuKVhTJK+mWoGOU0vZhFoyFYGSZLeofJz5xPhr8wJ+U
	PlVRArWrTX8qIfANp2SGzgVxInFBJTSPli7Z9YEaP+eNUu/QpBtklQA4nWFDQSP7
	T79DsAuuwy7KYaKnvGIguxNfKYD5N/IKyEK576gPfs+EbkYpHR8LoxkXEHPO0NSS
	wtGLAMVQjzyMUMCYrsd30v4cXVcwH5Ua8UpYsKaia/FMZt0fBd8GbdXG6OrRsi6R
	Y8WP22JWg/yRQienE0Q+vySYaKYElgZ8Y7I+BnT/dcsxCOPVU7PkQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4geht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 19:15:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NJ4eCq009254;
	Tue, 23 Jun 2026 19:14:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vymnjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 19:14:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NJEtv238011356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 19:14:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5997020063;
	Tue, 23 Jun 2026 19:14:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D03A20040;
	Tue, 23 Jun 2026 19:14:53 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 19:14:52 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>,
        sashiko-bot@kernel.org
Subject: [PATCH bpf v9 7/8] powerpc/bpf: fix buffer overflow in JIT for large BPF programs
Date: Tue, 23 Jun 2026 19:14:10 -0400
Message-ID: <20260623231411.6216-8-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260623231411.6216-1-adubey@linux.ibm.com>
References: <20260623231411.6216-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfX/gKV5ojRNyt7
 LQYzbUf6d5y5tqVKSrpQJQGFlvB+bv8l9y0KcnMVMzddwU/jtPxZesc6mNL0E0b9/m7L8VPZklv
 lk2pT95SbjuwqNl59dDHpK+kHsE6AAM=
X-Proofpoint-ORIG-GUID: b3wqoQtG6C5-NyQpRnEdlX34SeM4K5nb
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3adb34 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=JxGU0Ji_01lpLoTIbXQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfX5+SlCdxoCDIG
 VTck1WJNgGU9bUWHIcGdNyT9ta5GWpk4f90ZCPnwJ8xeCwXcqXV0snogfbeBT0m8mBfJGy8wq9Y
 acekabSguUhdSgBbi7gfT8rbRvLV9KTxMjWU+mWBHW/xZOtm8BSziJLUmMR54cnsd0KUM/5oh7y
 tMPlnvG00dm6QgFmYpfPLrOG6QUIHD+QlR/uxSPGoT181XR9PsoKFX3fdndAu9pMV/pvAwmwyLN
 3LXMGca9IpCrVw9miTCkGkV6q6yIkb298i7MI6sQO59Ki0DSSTCk8qbaahqNql4Du73ot3JO261
 cySXU9elNXaZ186EKHBdbmOt05RA5WBxwlPQvUgAHCiEOhjmYCE8vKN+zo2DQGav1Zs767Lxxur
 m21Kf3Lni/6VwZ7T8RzsUimdQAQ5/z534/imasievlpjdFAzTIYB2k/ae9avzxqug6ChQbhcRMv
 pRpLK4Gk5ok4ccm44Ew==
X-Proofpoint-GUID: b3wqoQtG6C5-NyQpRnEdlX34SeM4K5nb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230155

From: Abhishek Dubey <adubey@linux.ibm.com>

During size calculation in pass-0, exit_addr is 0 since addrs[fp->len]
is not yet populated. bpf_jit_emit_exit_insn() treats a zero exit_addr
as in-range and skips bpf_jit_build_epilogue(), so the alternate inline
epilogue instructions are not counted in alloclen.

In later passes, if the real exit_addr falls outside the 32MB branch
range, the full inline epilogue is emitted into the already-allocated
buffer, writing past its end and corrupting adjacent memory.

Fix by ensuring exit_addr is non-zero before treating it as in-range,
so pass-0 always falls through to bpf_jit_build_epilogue() and
conservatively accounts for all epilogue instructions in alloclen.
Also range check alt_exit_addr directly in the else-if condition.

Since exit_addr handling now falls through to the epilogue, two
related issues in bpf_int_jit_compile() must also be addressed:

1. Reset cgctx.alt_exit_addr before the second size-calculation pass.
   Without this, a stale alt_exit_addr from the first pass causes the
   second pass to emit a single jump instead of the full epilogue,
   undercounting alloclen and reintroducing the overflow.

2. Recompute addrs[fp->len] at the end of each code-generation pass.
   The larger pass-0 body can shrink in later passes as out-of-range
   exits settle into in-range jumps; a stale addrs[fp->len] would
   leave exit branches targeting past the real (shrunken) epilogue.

Because shrinkage in a later pass can move the epilogue offset, the
fixed two-pass loop is no longer sufficient: an exit that was out of
range in an earlier pass may fall in range once the epilogue offset
shrinks, shrinking the body further and overwriting the start of the
epilogue. Convert the code-generation loop to iterate until the
program size converges, bounded by CODEGEN_MAX_PASSES, and fail the
JIT if it does not converge.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ibm.com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92
Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
Cc: stable@vger.kernel.org
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h      |  7 +++++++
 arch/powerpc/net/bpf_jit_comp.c | 31 ++++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index af510da12d8e..4da8bde92e1e 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -14,6 +14,13 @@
 #include <asm/ppc-opcode.h>
 #include <linux/build_bug.h>
 
+/*
+ * We need at least 2 passes for proper code generation, and may need
+ * additional passes if code size changes between passes.
+ */
+#define CODEGEN_MIN_PASSES    2
+#define CODEGEN_MAX_PASSES    3
+
 #ifdef CONFIG_PPC64_ELF_ABI_V1
 #define FUNCTION_DESCR_SIZE	24
 #else
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 1c274df2b4f7..171cb6017259 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -128,11 +128,10 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx,
 							int tmp_reg, long exit_addr)
 {
-	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
+	if (exit_addr && is_offset_in_branch_range(exit_addr - (long)(ctx->idx * 4))) {
 		PPC_JMP(exit_addr);
-	} else if (ctx->alt_exit_addr) {
-		if (WARN_ON(!is_offset_in_branch_range((long)ctx->alt_exit_addr - (ctx->idx * 4))))
-			return -1;
+	} else if (ctx->alt_exit_addr && is_offset_in_branch_range(
+			(long)(ctx->alt_exit_addr) - (long)(ctx->idx * 4))) {
 		PPC_JMP(ctx->alt_exit_addr);
 	} else {
 		ctx->alt_exit_addr = ctx->idx * 4;
@@ -303,6 +302,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	 */
 	if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
 		cgctx.idx = 0;
+		cgctx.alt_exit_addr = 0;
 		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
 			goto out_err;
 	}
@@ -335,8 +335,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
 	fcode_base = (u32 *)(fimage + FUNCTION_DESCR_SIZE);
 
-	/* Code generation passes 1-2 */
-	for (pass = 1; pass < 3; pass++) {
+	/* Code generation passes 1-2+, loop until program size converges. */
+	for (pass = 1; pass <= CODEGEN_MAX_PASSES; pass++) {
+		u32 prev_proglen = proglen;
+
 		/* Now build the prologue, body code & epilogue for real. */
 		cgctx.idx = 0;
 		cgctx.alt_exit_addr = 0;
@@ -347,11 +349,26 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			bpf_jit_binary_pack_free(fhdr, hdr);
 			goto out_err;
 		}
+		addrs[fp->len] = cgctx.idx * 4;
 		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);
 
+		proglen = cgctx.idx * 4;
+
 		if (bpf_jit_enable > 1)
 			pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
-				proglen - (cgctx.idx * 4), cgctx.seen);
+				prev_proglen - proglen, cgctx.seen);
+
+		/* Check if program size has converged, but ensure minimum passes */
+		if (pass >= CODEGEN_MIN_PASSES && proglen == prev_proglen)
+			break;
+
+		if (pass == CODEGEN_MAX_PASSES && proglen != prev_proglen) {
+			pr_err("BPF JIT: Program did not converge after %d passes\n",
+								CODEGEN_MAX_PASSES);
+			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
+			bpf_jit_binary_pack_free(fhdr, hdr);
+			goto out_err;
+		}
 	}
 
 	if (bpf_jit_enable > 1)
-- 
2.52.0

