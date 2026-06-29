Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9F83F9278
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723340; cv=none; b=c2Uv0KRlX7ElznSjQKnEUN6Oxhrxf8RRRGy2nrP2B9s1q88aOKBx26Kbqon1YOySvJVZR8pKcxoU59CsGWl5gpGNSuuPmp5qKtQXLkNA59bn15I/3gAn+iF+LNc8nVUXQW01nf4X8ytPg7veMOJmxm3IsJVCOIe1MmAuxk0+6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723340; c=relaxed/simple;
	bh=koXZVkv+H5aUy7dUnGtXaW5EVAc1bVhhL44/jbs3IwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZH5NU/W/YLc1vkraCdWvJALYNNUOIyh7xAJ5hzWbhWbZInfmjrg66Ru2JEnJZeDJjnHnw3E7ZgbD+Nlvz3eopyvtgMQNyBebo9QZdvAbWq0uVMayf9yPjaMtAMK3p5mVgcqHmSBkiamv2kP8JaikhhLM365ikwAaoWX35dTxBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TXVkzdY4; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TXVkzdY4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782723324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeKM9BOzEu5hGJchdfeYskOLG9RiF3XxK5/9qzeUnhM=;
	b=TXVkzdY4CG/j8CYOc1oXlbULUVWgDOzy0uYtUJAktYZFGAH+JKQZfwKbk1E85RSxTbkFvA
	cLlNJJT4srV/aO9ozLPGaBUs0rk9b7q8m3XkCY0r4n6hhr6osi/7TRSy42MaKlf0R+AXkc
	RlVIlX5WdTR3jPzghh9PbQsHbhH4DOQ=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	George Guo <guodongtai@kylinos.cn>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH bpf v2] LoongArch: BPF: Fix tail call count pointer offset for arena programs
Date: Mon, 29 Jun 2026 16:55:11 +0800
Message-Id: <20260629085511.359546-1-dongtai.guo@linux.dev>
In-Reply-To: <20260625083212.277417-1-dongtai.guo@linux.dev>
References: <20260625083212.277417-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

The tail call count (TCC) and its pointer occupy the two deepest slots of
the callee-saved area set up by build_prologue(). An arena program reserves
one extra word for REG_ARENA (arena_vm_start) right above them:

    ra fp s0 s1 s2 s3 s4 s5      <- 8 words
    [ REG_ARENA ]                <- only if ctx->arena_vm_start
    tail_call_cnt
    tail_call_cnt_ptr            <- loaded on tail call / bpf2bpf call

BPF_TAIL_CALL_CNT_PTR_STACK_OFF() hardcodes the pointer at
round_up(stack, 16) - 80, which is only correct when REG_ARENA is absent.
For an arena program the extra word shifts every slot below it down by 8
bytes, so the macro resolves to the tail_call_cnt slot (the counter value)
instead of tail_call_cnt_ptr. The JIT then loads the counter value and
dereferences it as the TCC pointer, corrupting memory or panicking the
kernel whenever an arena program performs a tail call or a bpf2bpf call.

Replace the macro with a helper that accounts for the REG_ARENA slot,
mirroring the reservation logic in build_prologue().

Fixes: ef54c517a937 ("LoongArch: BPF: Implement PROBE_MEM32 pseudo instructions")
Cc: stable@vger.kernel.org
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
v2:
 - Dropped the second patch ("Don't charge an empty prog_array slot to
   the tail call count"); that off-by-one was fixed independently by
   commit 0379d10f09bc ("LoongArch: BPF: Fix off-by-one error in tail
   call"), now in 7.2-rc1. The arena tail call count pointer offset bug
   addressed here is independent and still unfixed.
 - No code change; reworded the commit message and rebased on 7.2-rc1.
 - v1: https://lore.kernel.org/all/20260625083212.277417-1-dongtai.guo@linux.dev

 arch/loongarch/net/bpf_jit.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index ad7e28375aa9..5e34e9e3f508 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -25,7 +25,23 @@
 
 #define REG_TCC		LOONGARCH_GPR_A6
 #define REG_ARENA	LOONGARCH_GPR_S6 /* For storing arena_vm_start */
-#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80)
+
+static int tail_call_cnt_ptr_stack_off(struct jit_ctx *ctx)
+{
+	/* Ten words are pushed below the BPF stack: ra, fp, s0-s5, and the
+	 * tail call count plus its pointer, which occupy the two deepest
+	 * slots of the callee-saved area.
+	 */
+	int offset = sizeof(long) * 10;
+
+	/* An arena program reserves one extra word above them (REG_ARENA),
+	 * which pushes the tail call count pointer down by one slot.
+	 */
+	if (ctx->arena_vm_start)
+		offset += sizeof(long);
+
+	return round_up(ctx->stack_size, 16) - offset;
+}
 
 static const int regmap[] = {
 	/* return value from in-kernel function, and exit value for eBPF program */
@@ -291,7 +307,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
 static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 {
 	int off, tc_ninsn = 0;
-	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
+	int tcc_ptr_off = tail_call_cnt_ptr_stack_off(ctx);
 	u8 a1 = LOONGARCH_GPR_A1;
 	u8 a2 = LOONGARCH_GPR_A2;
 	u8 t1 = LOONGARCH_GPR_T1;
@@ -1181,7 +1197,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			return ret;
 
 		if (insn->src_reg == BPF_PSEUDO_CALL) {
-			tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
+			tcc_ptr_off = tail_call_cnt_ptr_stack_off(ctx);
 			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
 		}
 
-- 
2.25.1

