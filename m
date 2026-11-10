Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315079;
	b=taV8vArlCLVz/55XLwFbT4NgymvasOXZtfGSP6fo+n2dqaqZ3dFs9Kx+ukqQ+CFfMi6F
	 YJbqAoKCgKbwMRYiVO9MKDk0WZlK+LmI2lFC0yXnqcQ6AFuShwYWTTbGNEUYACiLKq+Z5
	 ALpaUZptruogX9+BAQ7omQEzIbLWzxBhFZGNs8MApTnlLfPv1H5qNyFgwO9zZOZ5Is+rS
	 CrIyrcfyoD/S6QKAj3V6Sf/WRb8px0WYEZjL4G92WXQzTQSQ64asnNkA/UJpxVQ4COQd1
	 lgFDAvxEK9ecUvGRIqw5ws9bK60p4P69pARY6KJpRlPAe5MhjMCnm0AVYZt+W2jLNhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315079;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RiO9UcBJrtbJ0WeFnuboGuUsIdFoUeGDC8bwBZMAowM=;
	b=fPyd6SGQD+R/diwzDFTnCNSCAHsVL9NI56DVGagqPL9OTWKEoN+fQhlPhrjeJwuK1JXQ
	 J+4yJCPwZ1+HUtogP4bR/jn4y/TddBBFkqirl9AtSZwBpP5MXDrql9WYdt5iBKachn2GC
	 //Kq1HeEMr4gTSA6avHZgyoGGWai+8CclXyRf+YQZoaP4NSQw/rNIejoqK/3U1cUEcMhk
	 XjzOJ6xux+1olQgKXFgywC/ULUs3U0VRD/IUGGLioOwg+AihxGo577zaNqbxhrp02ArN/
	 tVCWLhIKogK1722UbZaOjEV3hpvGYgDdcWvyjk34ZZPkZ8ZCUFB+SkcTyBrkQweUDTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+o6koBs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF060A2613
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+o6koBs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CE01F008A1;
	Tue, 10 Nov 2026 12:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315078;
	bh=RiO9UcBJrtbJ0WeFnuboGuUsIdFoUeGDC8bwBZMAowM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a+o6koBsc9Iq4vZwtm1OQQahf/mwOmbxS1UdOTURbrM1ZOJfsH2ECGhQOvwsVZGvd
	 o4w1fK9KSQTYCSQTISbnbhzwM36fPnT61V9bgHXAqDVHP5gL5oUJGJcMD1U8pUfKZR
	 0eim3cMtKwZYna5oe6WE5E7PU/lLh9yFNuzCJExgDrfVK7W7WuuSiOjmMAN6gYW/Yi
	 vgDpZ7F/1w3OenkXPnKTSPbYZ6HbmQYooTDxPyH6cYN1lsDEzq8JkhdPBCC0c1OCnm
	 C8oUDLjj6aaedf3HClXLGaJ8apQl3iH8BYGEL6d3OJpdMKj7OlrtlECV4yc7L7CndA
	 MXLdkbaSIzKIA==
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
Subject: [PATCH 6.6.y] powerpc/bpf: fix buffer overflow in JIT for large BPF programs
Date: Tue, 10 Nov 2026 07:51:15 -0500
Message-ID: <20261110125049.1482034-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053044-failed-6.6-78ce55b7913a@kernel.org>
References: <20261107053044-failed-6.6-78ce55b7913a@kernel.org>
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
[ sashal: adapted convergence-failure cleanup to use bpf_jit_binary_free() and the existing out_addrs error path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/net/bpf_jit.h      |  7 +++++++
 arch/powerpc/net/bpf_jit_comp.c | 34 +++++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 72b7bb34fadea..6459ae8c12ab2 100644
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
index 877e7ff387856..03c270c6a5940 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -25,11 +25,10 @@ static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
 
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
@@ -134,6 +133,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	 */
 	if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
 		cgctx.idx = 0;
+		cgctx.alt_exit_addr = 0;
 		if (bpf_jit_build_body(fp, 0, &cgctx, addrs, 0, false)) {
 			fp = org_fp;
 			goto out_addrs;
@@ -168,10 +168,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 skip_init_ctx:
 	code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
 
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
 		if (bpf_jit_build_body(fp, code_base, &cgctx, addrs, pass, extra_pass)) {
@@ -179,11 +182,26 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
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
 
 	if (bpf_jit_enable > 1)
@@ -245,7 +263,7 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, int pass, struct code
 	u32 *fixup;
 
 	/* Populate extable entries only in the last pass */
-	if (pass != 2)
+	if (pass < CODEGEN_MIN_PASSES)
 		return 0;
 
 	if (!fp->aux->extable ||
-- 
2.53.0

