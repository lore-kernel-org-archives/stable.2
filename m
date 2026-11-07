Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046071;
	b=tuBtYg82rVtKUYaT0GUWXz83DoS//8XZR552XZI56MXoFY7+4bbS9z0Wo+Fvj7+9nzrF
	 D82vRP40bCrL43pmEgep0CnF3HmDCCCC0Au8y5ZSEU3tH4u12aEzIsTN7WKcB41XlwMMj
	 kcOrKdO4VyCqCKozBoyVJM6giDIO5eR5VeobuiwDdnlFbZtmQOVjVEOYREWeX642ZAPfT
	 NrMAFKM5O11IXEgRjpe3W/z4Ft/a+Ziib37G4Orni3Ko03pQ1l8toRUagCu60UTh9FLUe
	 J8zus+iglhx/wrYKogKENJVKUn+anxX2n0DC4anm0pVlAz/GVqxzDFtJaFJYBspTcuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046071;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QtCA0KcKdJXlN3IyLduxuYzFvf+Hgbb7GwQmJWc7SFs=;
	b=tCQ6L+8tIgPxnuagkSpeggKHzkFAHuFvF+Ub1wQPu/UOANIhovtkSKQNEUKblQCSSu1F
	 MZHUrf0jQAu7/8xJVLAoacaVjgNk3FrXrEecx82iSaAHPzsEedsWWOc4qwUv5hgWQcVd6
	 AKasYCzzLjIl25Zt0it6mkcsfUJ0FXfTZeZ06M99vgw2zuRWx6BnbOZ+PedhBUOj5bPPm
	 rMvq4TTpOzgKLyPNOiR4Rp6+RzthPpZEy/xoqYwl4BQ2LiDWE2Hr5ij+xTZ4/1dlFMktH
	 6Yh/R5qRng+CoY8avxw+/Us0XFOl2uKbPWaFNKTFgZoABW9R7+GpligyYEOPYYreJNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AF0Iks18;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB02C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AF0Iks18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43821F0089F;
	Sat,  7 Nov 2026 10:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046070;
	bh=QtCA0KcKdJXlN3IyLduxuYzFvf+Hgbb7GwQmJWc7SFs=;
	h=From:To:Cc:Subject:Date;
	b=AF0Iks18dl021dIzPZ7wfiNxitaBVXfB9+TXqLfWO1CPH9oTB2TwTAcB9CI8qp1L+
	 U4fPWIIBxFeL1jhRAHXDH50uFjzWntLl8nnh/AS4Ouk5We1mAxEra948APdNk04kmP
	 Rb95zG0oXk/oW12YTAzzABe2BBeuycljlWHKSv4m/+iGAQ35VhJl3CAqAtJngvhm00
	 Hr8EZUs2T4MkJyIY+DUpVEi79BzOGzt4VaGeaQkXwmnuK49ByPETS6LEOGtMkosSe4
	 tLAeWxoeJi0DhvmYTwe4z4fetCtfBH2djq2aLeDaqElJEPDwnIqVpqKs44XRtZC2e+
	 ILbF1ueMAFm8w==
From: Sasha Levin <sashal@kernel.org>
To: adubey@linux.ibm.com,
	hbathini@linux.ibm.com,
	skb99@linux.ibm.com,
	yeswanth@linux.ibm.com,
	rnsastry@linux.ibm.com,
	maddy@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] powerpc/bpf: fix alignment of long branch trampoline address" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:48 -0500
Message-ID: <20261107050748-failed-6.18-04001e8ddb97@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 04001e8ddb979f463f1c3ca8ac4d6ac59fb48921
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050748-failed-6.18-04001e8ddb97@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 04001e8ddb979f463f1c3ca8ac4d6ac59fb48921 Mon Sep 17 00:00:00 2001
From: Abhishek Dubey <adubey@linux.ibm.com>
Date: Mon, 28 Sep 2026 10:43:53 +0530
Subject: [PATCH] powerpc/bpf: fix alignment of long branch trampoline address

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
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/a8257022057cbb71928c960be589e10b89fc0899.1789982239.git.skb99@linux.ibm.com
---
 arch/powerpc/net/bpf_jit.h        |  7 +++---
 arch/powerpc/net/bpf_jit_comp.c   | 38 ++++++++++++++++++++++++++-----
 arch/powerpc/net/bpf_jit_comp32.c |  7 +++---
 arch/powerpc/net/bpf_jit_comp64.c |  7 +++---
 4 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 6d58df3616489..4da8bde92e1ef 100644
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
index 11981d2270a9d..8ca36a933c7ae 100644
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
index bfdc50740da8e..f5b9441cf46aa 100644
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
index 53f67b3d2906d..c1e86fe0bd79f 100644
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
2.53.0




