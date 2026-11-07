Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046698;
	b=ERtyq5Gu7/PXTHrLrVPq5k6VuKQQ8Q9zrFCNh2DRCctc9wyJYQXD27eFoUDoNwlCT6u8
	 WFJiarWdieppoWWoi9rx+miu6rDUOcva1hAak1wuqH6HzL75as60p0f5mKwE2pWMIuEnl
	 fQaUxf7AG/6uZlWDhODyZTrFgvbNAYnIdXyZaJKrQjAVHIZ2PPJa6dNYFqjZmj0O5EOHg
	 dDSeaBfoz5RMZGz+YeKrnZy3rLTope/z0J57hLD/s80szC9OcKOEqjMi+C273IJS4Q76/
	 6tNkMu5OdbQz1dc+Ob66XBCYdY/ogquwMABo8n1M0Eh1bx93wO3dIwoLzUz9oO7xKXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046698;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Gwtpx/XQDh0ZrdQGjjSuAANEDe8E+Ppq8QEKMb1Ur4A=;
	b=nzt9RfJmR/wMoqxfs1FP8E+6E5xWAhZf9g14uIS1tlA6iM0ATYlaWi8IHm0GS1NnnseV
	 vqKTI9wRLFLxSVIm1MwiUOrCfCA7tVtYeLRucy2weMlZ9vvs+/BfoPVGznlz4+KEAgS5+
	 mvGEYdgFpgc38jW/NoRQF7nPfWybndPQXRGQcDZMhBwuZNSD7POHQjpK8CkweZzL03iNz
	 ubHN/SSe9+hyY4pTwe3ihrQgL4XcBJpMOv3omgnKA1AMNBbimvOVzwoRuwWlmGic9KwtR
	 hTA1c1eB58Ma7cvMeXw2LvH77mk08ykBXd4/GtYzframMhQGejMN2OAvGby5uiIxMKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akFipJ8a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B1606D80D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akFipJ8a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DCD1F0089F;
	Sat,  7 Nov 2026 10:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046697;
	bh=Gwtpx/XQDh0ZrdQGjjSuAANEDe8E+Ppq8QEKMb1Ur4A=;
	h=From:To:Cc:Subject:Date;
	b=akFipJ8aEa9Ue6Z5ebztm7YWBgct9vb2bTSwf69FxHoAnsoM3V58DgrXUaaZXN0Jq
	 gG5teQdAIIEquZWXecHBBdDbTTpqHjJu6dnk3PBxN66fCiDdF5fU/tj4WL385yaAr6
	 /vIZ54W7EpyCmGSK7PiUFiU58/GeAcDZG/dltDhz1WrdJfyJVgQdX56jFLj+syl1lI
	 FZ4LDlO50aXoi9zSz8ghgh41HAbuYzgc5j1K/zWe0c1hi4GuQTGrzib45xYL/D0m99
	 C7sDYoTJPL0dwesDFtUTsoDZRELMAguwbR7AcuE77EMCoJ3cj2V6DoxMoqCY7SEr5I
	 cfaMOC9halcCA==
From: Sasha Levin <sashal@kernel.org>
To: adubey@linux.ibm.com,
	sashiko-bot@kernel.org,
	hbathini@linux.ibm.com,
	skb99@linux.ibm.com,
	yeswanth@linux.ibm.com,
	rnsastry@linux.ibm.com,
	maddy@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] powerpc/bpf: fix buffer overflow in JIT for large BPF programs" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:15 -0500
Message-ID: <20261107051815-failed-6.12-78ce55b7913a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 78ce55b7913a78e1687306668e078b86bc6508ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051815-failed-6.12-78ce55b7913a@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 78ce55b7913a78e1687306668e078b86bc6508ee Mon Sep 17 00:00:00 2001
From: Abhishek Dubey <adubey@linux.ibm.com>
Date: Mon, 28 Sep 2026 10:43:52 +0530
Subject: [PATCH] powerpc/bpf: fix buffer overflow in JIT for large BPF
 programs

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
---
 arch/powerpc/net/bpf_jit.h      |  7 +++++++
 arch/powerpc/net/bpf_jit_comp.c | 34 +++++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 35015d7ecb768..6d58df3616489 100644
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
index 8f7501954d9f0..11981d2270a9d 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -99,11 +99,10 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
 
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
@@ -274,6 +273,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	 */
 	if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
 		cgctx.idx = 0;
+		cgctx.alt_exit_addr = 0;
 		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
 			goto out_err;
 	}
@@ -306,10 +306,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
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
+		cgctx.exentry_idx = 0;
 		cgctx.alt_exit_addr = 0;
 		bpf_jit_build_prologue(code_base, &cgctx);
 		if (bpf_jit_build_body(fp, code_base, fcode_base, &cgctx, addrs, pass,
@@ -318,11 +321,26 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			bpf_jit_binary_pack_free(fhdr, hdr);
 			goto out_err;
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
+			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
+			bpf_jit_binary_pack_free(fhdr, hdr);
+			goto out_err;
+		}
 	}
 
 	if (bpf_jit_enable > 1)
@@ -399,7 +417,7 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass
 	u32 *fixup;
 
 	/* Populate extable entries only in the last pass */
-	if (pass != 2)
+	if (pass < CODEGEN_MIN_PASSES)
 		return 0;
 
 	if (!fp->aux->extable ||
-- 
2.53.0




