Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315981;
	b=2JHaYolDvld9L9dB4iZwTaOidGAbxZVznggslKvtHSiuQECPZl8NcWyjnEasJkZ/pxi9
	 LI3MtH8uIkDFs66Hs1wvnhCPBYIDKaWQxY7PsCzuJ9lycoVTJk3lIjkEGQTN8nLUAvh7D
	 i/ZHagrO52I1BeKyMpv/OU6uJkJRjgikhO0L2IsG2/+lNKofrJk1SIDHPwD4aJXZqKuik
	 AZWfAA5aiDVaKQW/dXWwkit8NDJeacfOET0omAmGc2xwElPiYKeYxT6UyPMKRzpF4BHLa
	 adDD5OaM8Vr3Fqmhbsc5uxV3NHXvWpcC3LsZzdye/crgEGrDpCqwO97dwjSsvNWpGew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315981;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RpDaW4XAi0T1fovdb3FW/J2KNgm0NP9j2ALnLaOOdHE=;
	b=lrAhfLAz8bZfjcuYtV2CuiI81f2aNTLCTeUhPms5BW/a8Czd3mIlsK9JFzFu1/bGHPWU
	 c8SzJl5LUF8FjzTFvm1Krc3erhzqpnWjYoSBYYptTP6mvKcn1JPJ+ym9nd1i/fP4iVANL
	 G+oq1bA4igtj3KzVqc9wnzSSRaMNFFDGaSIOdeuDqByPBtdiF65GZag8Ie2iyPm/TOvv1
	 wl+g7IuPVEQHqhikNyUdn9bKhXhXUxtNvbGTokJtjdQoEACoGEDgIP73JfwhOvUu9U/36
	 lKfy4TFkzul/yZWghbV5G4ehR6cvxZ4lK1/9mwMauChFkzjo06L49M45Q75un1jMz5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbwYLHDC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B2606A7D6
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbwYLHDC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B2C1F008A4;
	Tue, 10 Nov 2026 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315981;
	bh=RpDaW4XAi0T1fovdb3FW/J2KNgm0NP9j2ALnLaOOdHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FbwYLHDCsOosYlpDoYftL0rYz6Ou2C5V6WmlLQGlKG2WWr2GPGVOxlbA2bzSJUtc/
	 kiiBZd14VpHJqVGrhu+jdnYwCp7sDwl7/lpZKMao3G/m496I5MoJoNUQAHYrdGUFvg
	 tcBWv364IMX1XoiydvB3S20mUiQUa0S6hfjsby0372sLQH9MRp0IrdX6cPtJM/nG/D
	 f/f94IDKfPMO1Ei8oa8YctUtvS4piXuOKQPfWuQh7ArxZC1zdrkAQMUP6s+eJnoSQW
	 ZQK5rJVK8WWlFAOar6PZX34TmHm19EtOlL0osiBdTy27aPs/5hOQC/bHyGwn/4zTJF
	 04bmOAWhurNoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abhishek Dubey <adubey@linux.ibm.com>,
	sashiko-bot@kernel.org,
	Hari Bathini <hbathini@linux.ibm.com>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>,
	R Nageswara Sastry <rnsastry@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] powerpc/bpf: fix buffer overflow in JIT for large BPF programs
Date: Tue, 10 Nov 2026 08:06:17 -0500
Message-ID: <20261110130527.1549558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054325-failed-6.1-78ce55b7913a@kernel.org>
References: <20261107054325-failed-6.1-78ce55b7913a@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhishek Dubey <adubey@linux.ibm.com>

[ Upstream commit 78ce55b7913a78e1687306668e078b86bc6508ee ]

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
Fixes: 0ffdbce6f4a8 ("powerpc/bpf: Handle large branch ranges with BPF_EXIT")
Cc: stable@vger.kernel.org
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Link: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ibm.com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/eebffa997e07781b384c4480e2b03c5b87c1aeb1.1789982239.git.skb99@linux.ibm.com
[ sashal: adapted nonconvergence error handling to use bpf_jit_binary_free() and the existing out_addrs cleanup path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/net/bpf_jit.h      |  7 +++++++
 arch/powerpc/net/bpf_jit_comp.c | 34 +++++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index a4f7880f959dd..5ea07464e4dfe 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -13,6 +13,13 @@
 #include <asm/types.h>
 #include <asm/ppc-opcode.h>
 
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
index 43e6341265148..e1f2cf1a6a169 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -93,11 +93,10 @@ static int bpf_jit_fixup_addresses(struct bpf_prog *fp, u32 *image,
 
 int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr)
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
@@ -200,6 +199,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	 */
 	if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
 		cgctx.idx = 0;
+		cgctx.alt_exit_addr = 0;
 		if (bpf_jit_build_body(fp, 0, &cgctx, addrs, 0)) {
 			fp = org_fp;
 			goto out_addrs;
@@ -250,10 +250,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		goto skip_codegen_passes;
 	}
 
-	/* Code generation passes 1-2 */
-	for (pass = 1; pass < 3; pass++) {
+	/* Code generation passes 1-2+, loop until program size converges. */
+	for (pass = 1; pass <= CODEGEN_MAX_PASSES; pass++) {
+		u32 prev_proglen = proglen;
+
 		/* Now build the prologue, body code & epilogue for real. */
 		cgctx.idx = 0;
+		cgctx.exentry_idx = 0;
 		cgctx.alt_exit_addr = 0;
 		bpf_jit_build_prologue(code_base, &cgctx);
 		if (bpf_jit_build_body(fp, code_base, &cgctx, addrs, pass)) {
@@ -261,11 +264,26 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 			fp = org_fp;
 			goto out_addrs;
 		}
+		addrs[fp->len] = cgctx.idx * 4;
 		bpf_jit_build_epilogue(code_base, &cgctx);
 
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
+			bpf_jit_binary_free(bpf_hdr);
+			fp = org_fp;
+			goto out_addrs;
+		}
 	}
 
 skip_codegen_passes:
@@ -322,7 +340,7 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, int pass, struct code
 	u32 *fixup;
 
 	/* Populate extable entries only in the last pass */
-	if (pass != 2)
+	if (pass < CODEGEN_MIN_PASSES)
 		return 0;
 
 	if (!fp->aux->extable ||
-- 
2.53.0

