Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58453D0DA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950763; cv=none; b=T+UQoglkWmF+FPQYYDBBDH5osuvo4HDE9ZRdVi/IU3Ag0+KuZZq+jNH4KS6kiN/tyeQD1TsmAjDdq27aPEDpBUFX6//a0bDqzosp2XMqJuCn6knRxTDaQAxM1vv11A35COb+LWmiHPiuBvifPZISq92Kt1gvkIWsXP5MVkv/wwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950763; c=relaxed/simple;
	bh=UyJQisMfj4TWH0FE7kcTw/zJc3MBhGTXHlFFQjJTVmk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q+VGn9r5zD1HzQ8sWMtF495DBv39/EiVtBx7mpJ4Dxx7Ym2LBbZIvV84PmZasLpaAvUbRPU2tJQQDkPpvnN9GqVssKzMcF32CP0RTWieUuIbUD1+CXN3JgyoBCy1T/DA1d/ovHBrlKDWIxwc2bkhYFApS790va2VgDUCXREEgrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UpO0CZS+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UpO0CZS+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19421F00A3E;
	Wed,  9 Sep 2026 10:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950761;
	bh=PyNwCLdGLGCqSXAmZXhDhzWcJRUPvDngKZMqD1xMv8c=;
	h=Subject:To:Cc:From:Date;
	b=UpO0CZS+D15BrG2XIB5I98MLZYi5ToOZuCgN2R8XSPVh2mP5QUzLPcIy60+8Fz3DE
	 6wsFjp7d3bM/1huqDEfgNAB1NVcou9OG6sJD6jFiRXiQ7vWkulE9hlca3QLrAwgRcY
	 PFOIFGOxR1izrN+NxVcYBkPklFW3MTR1PY29Q9zw=
Subject: FAILED: patch "[PATCH] LoongArch: BPF: Refactor jump offset calculation in tail call" failed to apply to 6.6-stable tree
To: yangtiezhu@loongson.cn,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:39:34 +0200
Message-ID: <2026090934-greyhound-constant-1448@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 37d545d12f21c4d50612ecaebd7ae1e5bf91b2d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090934-greyhound-constant-1448@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 37d545d12f21c4d50612ecaebd7ae1e5bf91b2d8 Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Mon, 17 Aug 2026 22:07:23 +0800
Subject: [PATCH] LoongArch: BPF: Refactor jump offset calculation in tail call

The old macro-based jmp_offset calculation derives the jump distance
from a stale prior-pass code stride, which can lead to wrong branch
offsets and soft lockups under extra JIT passes.

Fix this by calculating the offset directly on the absolute target:
"ctx->offset[insn + 1] - ctx->idx".

To avoid a false 16-bit range check abort during size estimation, add
a "ctx->image == NULL" guard to inject a safe dummy offset.

Cc: stable@vger.kernel.org
Fixes: cd39d9e6b7e4 ("LoongArch: BPF: Fix jump offset calculation in tailcall")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index fd5f8c4e5360..846d652b0d22 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -290,17 +290,13 @@ bool bpf_jit_supports_far_kfunc_call(void)
 
 static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 {
-	int off, tc_ninsn = 0;
+	int off, jmp_offset;
 	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
 	u8 a1 = LOONGARCH_GPR_A1;
 	u8 a2 = LOONGARCH_GPR_A2;
 	u8 t1 = LOONGARCH_GPR_T1;
 	u8 t2 = LOONGARCH_GPR_T2;
 	u8 t3 = LOONGARCH_GPR_T3;
-	const int idx0 = ctx->idx;
-
-#define cur_offset (ctx->idx - idx0)
-#define jmp_offset (tc_ninsn - (cur_offset))
 
 	/*
 	 * a0: &ctx
@@ -310,12 +306,12 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	 * if (index >= array->map.max_entries)
 	 *	 goto out;
 	 */
-	tc_ninsn = insn ? ctx->offset[insn+1] - ctx->offset[insn] : ctx->offset[0];
 	emit_zext_32(ctx, a2, true);
 
 	off = offsetof(struct bpf_array, map.max_entries);
 	emit_insn(ctx, ldwu, t1, a1, off);
 	/* bgeu $a2, $t1, jmp_offset */
+	jmp_offset = ctx->image ? (ctx->offset[insn + 1] - ctx->idx) : 0;
 	if (emit_tailcall_jmp(ctx, BPF_JGE, a2, t1, jmp_offset) < 0)
 		goto toofar;
 
@@ -326,6 +322,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
 	emit_insn(ctx, ldd, t3, REG_TCC, 0);
 	emit_insn(ctx, addid, t2, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
+	jmp_offset = ctx->image ? (ctx->offset[insn + 1] - ctx->idx) : 0;
 	if (emit_tailcall_jmp(ctx, BPF_JSGE, t3, t2, jmp_offset) < 0)
 		goto toofar;
 
@@ -340,6 +337,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	off = offsetof(struct bpf_array, ptrs);
 	emit_insn(ctx, ldd, t2, t2, off);
 	/* beq $t2, $zero, jmp_offset */
+	jmp_offset = ctx->image ? (ctx->offset[insn + 1] - ctx->idx) : 0;
 	if (emit_tailcall_jmp(ctx, BPF_JEQ, t2, LOONGARCH_GPR_ZERO, jmp_offset) < 0)
 		goto toofar;
 
@@ -355,8 +353,6 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 toofar:
 	pr_info_once("tail_call: jump too far\n");
 	return -1;
-#undef cur_offset
-#undef jmp_offset
 }
 
 static void emit_store_stack_imm64(struct jit_ctx *ctx, int reg, int stack_off, u64 imm64)

