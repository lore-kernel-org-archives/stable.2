Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC1835DA5B;
	Thu, 25 Jun 2026 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376366; cv=none; b=pVXP8BMnR/KFsN91+ZXEGbSCy9qmP2/h3s97pQidrgSg3CWUsc1uH0JmkiTAP1vSlggS88/yjHw1/WoN/KomQutPHJKbAS1zWPGMeX55U+gr6L/MSgeIu6YtIpnakIr7+iEEM3BrAApZzyXBSxMuJaGclObUp5JHG0GIaJkl5jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376366; c=relaxed/simple;
	bh=wxg03im1f3YOJxcnQ0xXatdZvR3HwBAxP3yyQlUmdzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qTxHAJ3kLBJ8WCqmBczzdbnZG2FZ9AF6RcgCr5+jTmEnKQ+XFcZcUss1jGZ3egoSJp+vXW2390dYhZHaB89RXi9/w7kH2NUrTpmBX/EXhDl5b+w8h8VKQEKjLV+I7XJXSA5Knq2AaX3grHgq1igajq/InKIJt8cyJNhbQeOp+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fREn7Gog; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fREn7Gog"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782376363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdyWriMjR0iiOwFrvG83IYqEIicSTh+06bqz9e9I5vc=;
	b=fREn7GogwWL7B+cks1Y5M33kzKuDc9NGT21iUUrSVqNU89LJaNzaLBRQcuRltPPxdtHr/c
	YyR9EcWD8btzTadZ8js5jKswMfqbm1TVGrq+nfVaD1Kxuhn+yjrL8X5okLmMWaAlMNH1g7
	p9ArhScvl+oaRuU/BxTjb3F6zmcrF+k=
From: George Guo <dongtai.guo@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	George Guo <guodongtai@kylinos.cn>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH bpf 1/2] LoongArch: BPF: Fix tail call count pointer offset for arena programs
Date: Thu, 25 Jun 2026 16:32:11 +0800
Message-Id: <20260625083212.277417-2-dongtai.guo@linux.dev>
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
instead of tail_call_cnt_ptr. The JIT then loads that small integer and
dereferences it as the TCC pointer, corrupting memory or panicking the
kernel whenever an arena program performs a tail call or a bpf2bpf call.

Replace the macro with a helper that accounts for the REG_ARENA slot,
mirroring the reservation logic in build_prologue().

Fixes: ef54c517a937 ("LoongArch: BPF: Implement PROBE_MEM32 pseudo instructions")
Cc: stable@vger.kernel.org
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 24913dc7f4e8..f705de099f23 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -18,7 +18,23 @@
 
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
@@ -278,7 +294,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
 static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 {
 	int off, tc_ninsn = 0;
-	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
+	int tcc_ptr_off = tail_call_cnt_ptr_stack_off(ctx);
 	u8 a1 = LOONGARCH_GPR_A1;
 	u8 a2 = LOONGARCH_GPR_A2;
 	u8 t1 = LOONGARCH_GPR_T1;
@@ -1153,7 +1169,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			return ret;
 
 		if (insn->src_reg == BPF_PSEUDO_CALL) {
-			tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
+			tcc_ptr_off = tail_call_cnt_ptr_stack_off(ctx);
 			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
 		}
 
-- 
2.25.1

