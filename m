Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0303CB919
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781456344; cv=none; b=HOBzrSMyTJkxWdwv51Hgb/o1SM+u6hOKVkYnunJI998K6s9mtvP9I+zT9hHd0S+o+GGGd/tM8T9/zzR4yZFffjzRiEIgHUFCRdzgSp5JuWF23ucS1Ta0R1w7bjqnDhPDkHKuYQbIrSbEV5yLs+XMHncdyVXej+CcSSxZczNDzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781456344; c=relaxed/simple;
	bh=Tx3Ey/Z4gHB7cr/b1u3ZqpLAXM54n9oOoyIuUNN0PWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHxObjcMqcltK2h5jib4HuNOh7LEeQw9pSMzPYAohENU6oXPxMKpla5zh+IcIKyM8v7/B6HMAKLa8ykO1VWzSSW8eh4f9eiSI6j8NnB2hgigE3mdp62QniAEpKytuLj0L+p9uQxAU1SuPFxURuszegAb3Ypv+ISKcGW+lg/5WNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4XxWbws; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4XxWbws"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c68190ade4so2434205ad.0
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 09:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781456341; x=1782061141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99ATyR1x3NdOyaziL+8TU3agV+5m47x8ONvntlrURH8=;
        b=R4XxWbws4Yc6VxgS8/OzWH749Ghz++y8X8ZY98TH1Hok2MlvCUfgYDOm2G6HvpF0Sn
         Cg9Jmhsa5VIsLYlwL/iJe7I2AZkf63KoqK7tz99PdW1RfOa+YzaDbCpoEr0OZXLkIFB3
         qFkw9Q32lC168/Wj+O3q5XMnM7D/qKKLsS6818sZkFYTfwHPGs6UEFwyXmkCXQ6UXqmy
         JNL+/3l5ZZeLh1JYL4ZHBzSypc5iRw1sb3FrBa7fHj4HURL2GnQAO8/KGeBAewzHSwwj
         o6nih8HfhUDtN9vDJDW83NoEo/qro8oRiAdn1L/PWes6Wge89PT8uMPxuIbQHSjZ/O1F
         1ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781456341; x=1782061141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=99ATyR1x3NdOyaziL+8TU3agV+5m47x8ONvntlrURH8=;
        b=d9+TRceR4JkLyL4wVTwvGVoW29HsF78peq9rlhDQBlFM35MYroI+zJSFWCKbyPszNW
         wTbrCFMiXfl+YrhAozK9z0yD1xrycPS9FmOHQOZWd7X93I9YSBX9hf3V5kXiag772c4x
         vjKp8vnxl4biZ1qGTn6QDIae1I5RnIxrDnY3tG7P3cuMw/PfCR2B2P8TeR+0tp/zNP5D
         4uctke4NGCbFCKTcvPDb+iyoPrSB5b7S34QEoaZVgw0NOvOTQLmWub0dGtLDN5d3uQ/1
         n7SHt5YtklVT8pODmkDYYc7WiKB7zRvX/xve5gc8Z6QdNssefxLnGexnxBOQUczyTdIH
         Ob8g==
X-Forwarded-Encrypted: i=1; AFNElJ8iddx4iPy5YAkYJ0/xNwqrA+wLyKTqzLag5ZjYvkUeqoAAwqbnUz5bZID2OkPVt7S2vfoGA4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3AMVvCu2U9nd7uCQ9U5LN7wqmwvJYx8EXQOc4EbEYuM4uBn3V
	RZ+XAh+1DIBBR30LghA8j89zFaccyFv2AMyuTIz7BtMFmrtzjBot29y1
X-Gm-Gg: Acq92OGvvulQvYBxkECNbYxzh8df8NPdaGlHbAFw+/YB9zIYzLsYH4zep/8sOYETBL3
	xp1PESpRZTNY8r5p5x6jLpK/Mcm31JDiE317QVgz88dVbJ9j42PyytNqIVJsJiAMOzWJoimmNEF
	d0rXZL8R/+vq2v5YRqpNAHF3LiPK2ZYXysypCz3J4ME5mXCBPsH7/MoXTmX5a3HvvL2Q8qRbkxq
	+XyWMo49HN/gEWYZAGScFz1EY1APkxIOP6s5XLmzPVTL0LzJpo0bYIyCBY4EW9/L7Ij7tC9eaxb
	S/yHY8dupmHkFn5BTb0a/C4WMfKlR1Tkfdsc8jN0W6xrTeOfoQxGM8nLbBHUVIh+h0mpZUMwz2g
	fRzW7coGFmnmRopwdOCMaYyxOXYyd1Xm5bMaaKXRUSkgXagCmTgkYF6vD2eTzTrgNf2PB5Eh4Q/
	pT4UO1fs6OS+9DXxdspTtS0fFQKxEgfJ9xJEeXsWQXWQ==
X-Received: by 2002:a17:903:2ec6:b0:2c1:41f8:7ef5 with SMTP id d9443c01a7336-2c3fd1304f7mr101311535ad.22.1781456341039;
        Sun, 14 Jun 2026 09:59:01 -0700 (PDT)
Received: from DESKTOP-MUHC17F.lan ([188.253.121.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5b79sm74457405ad.36.2026.06.14.09.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 09:59:00 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v3 2/4] bpf: Remove mark_precise_scalar_ids()
Date: Mon, 15 Jun 2026 00:58:39 +0800
Message-ID: <9c5d94f381d7d9ecd8d07c60e0e271117ce24482.1781194510.git.jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781194510.git.jt26wzz@gmail.com>
References: <cover.1781194510.git.jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit 842edb5507a1038e009d27e69d13b94b6f085763 ]

Function mark_precise_scalar_ids() is superseded by
bt_sync_linked_regs() and equal scalars tracking in jump history.
mark_precise_scalar_ids() propagates precision over registers sharing
same ID on parent/child state boundaries, while jump history records
allow bt_sync_linked_regs() to propagate same information with
instruction level granularity, which is strictly more precise.

This commit removes mark_precise_scalar_ids() and updates test cases
in progs/verifier_scalar_ids to reflect new verifier behavior.

The tests are updated in the following manner:
- mark_precise_scalar_ids() propagated precision regardless of
  presence of conditional jumps, while new jump history based logic
  only kicks in when conditional jumps are present.
  Hence test cases are augmented with conditional jumps to still
  trigger precision propagation.
- As equal scalars tracking no longer relies on parent/child state
  boundaries some test cases are no longer interesting,
  such test cases are removed, namely:
  - precision_same_state and precision_cross_state are superseded by
    linked_regs_bpf_k;
  - precision_same_state_broken_link and equal_scalars_broken_link
    are superseded by linked_regs_broken_link.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240718202357.1746514-3-eddyz87@gmail.com
[ zhenzhong: backport to 6.6.y after adapting the first linked-regs
  history commit to the older scalar-id verifier layout. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 kernel/bpf/verifier.c                         | 115 ------------
 .../selftests/bpf/progs/verifier_scalar_ids.c | 171 ++++++------------
 .../testing/selftests/bpf/verifier/precise.c  |   2 +-
 3 files changed, 56 insertions(+), 232 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3cc0fc902..55a5a5bed 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4265,96 +4265,6 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
 	}
 }
 
-static bool idset_contains(struct bpf_idset *s, u32 id)
-{
-	u32 i;
-
-	for (i = 0; i < s->count; ++i)
-		if (s->ids[i] == id)
-			return true;
-
-	return false;
-}
-
-static int idset_push(struct bpf_idset *s, u32 id)
-{
-	if (WARN_ON_ONCE(s->count >= ARRAY_SIZE(s->ids)))
-		return -EFAULT;
-	s->ids[s->count++] = id;
-	return 0;
-}
-
-static void idset_reset(struct bpf_idset *s)
-{
-	s->count = 0;
-}
-
-/* Collect a set of IDs for all registers currently marked as precise in env->bt.
- * Mark all registers with these IDs as precise.
- */
-static int mark_precise_scalar_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
-{
-	struct bpf_idset *precise_ids = &env->idset_scratch;
-	struct backtrack_state *bt = &env->bt;
-	struct bpf_func_state *func;
-	struct bpf_reg_state *reg;
-	DECLARE_BITMAP(mask, 64);
-	int i, fr;
-
-	idset_reset(precise_ids);
-
-	for (fr = bt->frame; fr >= 0; fr--) {
-		func = st->frame[fr];
-
-		bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
-		for_each_set_bit(i, mask, 32) {
-			reg = &func->regs[i];
-			if (!reg->id || reg->type != SCALAR_VALUE)
-				continue;
-			if (idset_push(precise_ids, reg->id))
-				return -EFAULT;
-		}
-
-		bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
-		for_each_set_bit(i, mask, 64) {
-			if (i >= func->allocated_stack / BPF_REG_SIZE)
-				break;
-			if (!is_spilled_scalar_reg(&func->stack[i]))
-				continue;
-			reg = &func->stack[i].spilled_ptr;
-			if (!reg->id)
-				continue;
-			if (idset_push(precise_ids, reg->id))
-				return -EFAULT;
-		}
-	}
-
-	for (fr = 0; fr <= st->curframe; ++fr) {
-		func = st->frame[fr];
-
-		for (i = BPF_REG_0; i < BPF_REG_10; ++i) {
-			reg = &func->regs[i];
-			if (!reg->id)
-				continue;
-			if (!idset_contains(precise_ids, reg->id))
-				continue;
-			bt_set_frame_reg(bt, fr, i);
-		}
-		for (i = 0; i < func->allocated_stack / BPF_REG_SIZE; ++i) {
-			if (!is_spilled_scalar_reg(&func->stack[i]))
-				continue;
-			reg = &func->stack[i].spilled_ptr;
-			if (!reg->id)
-				continue;
-			if (!idset_contains(precise_ids, reg->id))
-				continue;
-			bt_set_frame_slot(bt, fr, i);
-		}
-	}
-
-	return 0;
-}
-
 /*
  * __mark_chain_precision() backtracks BPF program instruction sequence and
  * chain of verifier states making sure that register *regno* (if regno >= 0)
@@ -4487,31 +4397,6 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				bt->frame, last_idx, first_idx, subseq_idx);
 		}
 
-		/* If some register with scalar ID is marked as precise,
-		 * make sure that all registers sharing this ID are also precise.
-		 * This is needed to estimate effect of sync_linked_regs().
-		 * Do this at the last instruction of each state,
-		 * bpf_reg_state::id fields are valid for these instructions.
-		 *
-		 * Allows to track precision in situation like below:
-		 *
-		 *     r2 = unknown value
-		 *     ...
-		 *   --- state #0 ---
-		 *     ...
-		 *     r1 = r2                 // r1 and r2 now share the same ID
-		 *     ...
-		 *   --- state #1 {r1.id = A, r2.id = A} ---
-		 *     ...
-		 *     if (r2 > 10) goto exit; // sync_linked_regs() assigns range to r1
-		 *     ...
-		 *   --- state #2 {r1.id = A, r2.id = A} ---
-		 *     r3 = r10
-		 *     r3 += r1                // need to mark both r1 and r2
-		 */
-		if (mark_precise_scalar_ids(env, st))
-			return -EFAULT;
-
 		if (last_idx < 0) {
 			/* we are at the entry into subprog, which
 			 * is expected for global funcs, but only if
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 22a6cf6e8..f70392bf6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -5,54 +5,27 @@
 #include "bpf_misc.h"
 
 /* Check that precision marks propagate through scalar IDs.
- * Registers r{0,1,2} have the same scalar ID at the moment when r0 is
- * marked to be precise, this mark is immediately propagated to r{1,2}.
+ * Registers r{0,1,2} have the same scalar ID.
+ * Range information is propagated for scalars sharing same ID.
+ * Check that precision mark for r0 causes precision marks for r{1,2}
+ * when range information is propagated for 'if <reg> <op> <const>' insn.
  */
 SEC("socket")
 __success __log_level(2)
-__msg("frame0: regs=r0,r1,r2 stack= before 4: (bf) r3 = r10")
-__msg("frame0: regs=r0,r1,r2 stack= before 3: (bf) r2 = r0")
-__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
-__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
-__flag(BPF_F_TEST_STATE_FREQ)
-__naked void precision_same_state(void)
-{
-	asm volatile (
-	/* r0 = random number up to 0xff */
-	"call %[bpf_ktime_get_ns];"
-	"r0 &= 0xff;"
-	/* tie r0.id == r1.id == r2.id */
-	"r1 = r0;"
-	"r2 = r0;"
-	/* force r0 to be precise, this immediately marks r1 and r2 as
-	 * precise as well because of shared IDs
-	 */
-	"r3 = r10;"
-	"r3 += r0;"
-	"r0 = 0;"
-	"exit;"
-	:
-	: __imm(bpf_ktime_get_ns)
-	: __clobber_all);
-}
-
-/* Same as precision_same_state, but mark propagates through state /
- * parent state boundary.
- */
-SEC("socket")
-__success __log_level(2)
-__msg("frame0: last_idx 6 first_idx 5 subseq_idx -1")
-__msg("frame0: regs=r0,r1,r2 stack= before 5: (bf) r3 = r10")
+/* first 'if' branch */
+__msg("6: (0f) r3 += r0")
+__msg("frame0: regs=r0 stack= before 4: (25) if r1 > 0x7 goto pc+0")
 __msg("frame0: parent state regs=r0,r1,r2 stack=:")
-__msg("frame0: regs=r0,r1,r2 stack= before 4: (05) goto pc+0")
 __msg("frame0: regs=r0,r1,r2 stack= before 3: (bf) r2 = r0")
-__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
-__msg("frame0: parent state regs=r0 stack=:")
-__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
+/* second 'if' branch */
+__msg("from 4 to 5: ")
+__msg("6: (0f) r3 += r0")
+__msg("frame0: regs=r0 stack= before 5: (bf) r3 = r10")
+__msg("frame0: regs=r0 stack= before 4: (25) if r1 > 0x7 goto pc+0")
+/* parent state already has r{0,1,2} as precise */
+__msg("frame0: parent state regs= stack=:")
 __flag(BPF_F_TEST_STATE_FREQ)
-__naked void precision_cross_state(void)
+__naked void linked_regs_bpf_k(void)
 {
 	asm volatile (
 	/* r0 = random number up to 0xff */
@@ -61,9 +34,8 @@ __naked void precision_cross_state(void)
 	/* tie r0.id == r1.id == r2.id */
 	"r1 = r0;"
 	"r2 = r0;"
-	/* force checkpoint */
-	"goto +0;"
-	/* force r0 to be precise, this immediately marks r1 and r2 as
+	"if r1 > 7 goto +0;"
+	/* force r0 to be precise, this eventually marks r1 and r2 as
 	 * precise as well because of shared IDs
 	 */
 	"r3 = r10;"
@@ -75,59 +47,18 @@ __naked void precision_cross_state(void)
 	: __clobber_all);
 }
 
-/* Same as precision_same_state, but break one of the
+/* Same as linked_regs_bpf_k, but break one of the
  * links, note that r1 is absent from regs=... in __msg below.
  */
 SEC("socket")
 __success __log_level(2)
-__msg("frame0: regs=r0,r2 stack= before 5: (bf) r3 = r10")
-__msg("frame0: regs=r0,r2 stack= before 4: (b7) r1 = 0")
-__msg("frame0: regs=r0,r2 stack= before 3: (bf) r2 = r0")
-__msg("frame0: regs=r0 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
-__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
-__flag(BPF_F_TEST_STATE_FREQ)
-__naked void precision_same_state_broken_link(void)
-{
-	asm volatile (
-	/* r0 = random number up to 0xff */
-	"call %[bpf_ktime_get_ns];"
-	"r0 &= 0xff;"
-	/* tie r0.id == r1.id == r2.id */
-	"r1 = r0;"
-	"r2 = r0;"
-	/* break link for r1, this is the only line that differs
-	 * compared to the previous test
-	 */
-	"r1 = 0;"
-	/* force r0 to be precise, this immediately marks r1 and r2 as
-	 * precise as well because of shared IDs
-	 */
-	"r3 = r10;"
-	"r3 += r0;"
-	"r0 = 0;"
-	"exit;"
-	:
-	: __imm(bpf_ktime_get_ns)
-	: __clobber_all);
-}
-
-/* Same as precision_same_state_broken_link, but with state /
- * parent state boundary.
- */
-SEC("socket")
-__success __log_level(2)
-__msg("frame0: regs=r0,r2 stack= before 6: (bf) r3 = r10")
-__msg("frame0: regs=r0,r2 stack= before 5: (b7) r1 = 0")
-__msg("frame0: parent state regs=r0,r2 stack=:")
-__msg("frame0: regs=r0,r1,r2 stack= before 4: (05) goto pc+0")
-__msg("frame0: regs=r0,r1,r2 stack= before 3: (bf) r2 = r0")
-__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
+__msg("7: (0f) r3 += r0")
+__msg("frame0: regs=r0 stack= before 6: (bf) r3 = r10")
 __msg("frame0: parent state regs=r0 stack=:")
-__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
+__msg("frame0: regs=r0 stack= before 5: (25) if r0 > 0x7 goto pc+0")
+__msg("frame0: parent state regs=r0,r2 stack=:")
 __flag(BPF_F_TEST_STATE_FREQ)
-__naked void precision_cross_state_broken_link(void)
+__naked void linked_regs_broken_link(void)
 {
 	asm volatile (
 	/* r0 = random number up to 0xff */
@@ -136,18 +67,13 @@ __naked void precision_cross_state_broken_link(void)
 	/* tie r0.id == r1.id == r2.id */
 	"r1 = r0;"
 	"r2 = r0;"
-	/* force checkpoint, although link between r1 and r{0,2} is
-	 * broken by the next statement current precision tracking
-	 * algorithm can't react to it and propagates mark for r1 to
-	 * the parent state.
-	 */
-	"goto +0;"
 	/* break link for r1, this is the only line that differs
-	 * compared to precision_cross_state()
+	 * compared to the previous test
 	 */
 	"r1 = 0;"
-	/* force r0 to be precise, this immediately marks r1 and r2 as
-	 * precise as well because of shared IDs
+	"if r0 > 7 goto +0;"
+	/* force r0 to be precise,
+	 * this eventually marks r2 as precise because of shared IDs
 	 */
 	"r3 = r10;"
 	"r3 += r0;"
@@ -164,10 +90,16 @@ __naked void precision_cross_state_broken_link(void)
  */
 SEC("socket")
 __success __log_level(2)
-__msg("11: (0f) r2 += r1")
+__msg("12: (0f) r2 += r1")
 /* Current state */
-__msg("frame2: last_idx 11 first_idx 10 subseq_idx -1")
-__msg("frame2: regs=r1 stack= before 10: (bf) r2 = r10")
+__msg("frame2: last_idx 12 first_idx 11 subseq_idx -1 ")
+__msg("frame2: regs=r1 stack= before 11: (bf) r2 = r10")
+__msg("frame2: parent state regs=r1 stack=")
+__msg("frame1: parent state regs= stack=")
+__msg("frame0: parent state regs= stack=")
+/* Parent state */
+__msg("frame2: last_idx 10 first_idx 10 subseq_idx 11 ")
+__msg("frame2: regs=r1 stack= before 10: (25) if r1 > 0x7 goto pc+0")
 __msg("frame2: parent state regs=r1 stack=")
 /* frame1.r{6,7} are marked because mark_precise_scalar_ids()
  * looks for all registers with frame2.r1.id in the current state
@@ -192,7 +124,7 @@ __msg("frame1: regs=r1 stack= before 4: (85) call pc+1")
 __msg("frame0: parent state regs=r1,r6 stack=")
 /* Parent state */
 __msg("frame0: last_idx 3 first_idx 1 subseq_idx 4")
-__msg("frame0: regs=r0,r1,r6 stack= before 3: (bf) r6 = r0")
+__msg("frame0: regs=r1,r6 stack= before 3: (bf) r6 = r0")
 __msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
 __msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
 __flag(BPF_F_TEST_STATE_FREQ)
@@ -230,7 +162,8 @@ static __naked __noinline __used
 void precision_many_frames__bar(void)
 {
 	asm volatile (
-	/* force r1 to be precise, this immediately marks:
+	"if r1 > 7 goto +0;"
+	/* force r1 to be precise, this eventually marks:
 	 * - bar frame r1
 	 * - foo frame r{1,6,7}
 	 * - main frame r{1,6}
@@ -247,14 +180,16 @@ void precision_many_frames__bar(void)
  */
 SEC("socket")
 __success __log_level(2)
+__msg("11: (0f) r2 += r1")
 /* foo frame */
-__msg("frame1: regs=r1 stack=-8,-16 before 9: (bf) r2 = r10")
+__msg("frame1: regs=r1 stack= before 10: (bf) r2 = r10")
+__msg("frame1: regs=r1 stack= before 9: (25) if r1 > 0x7 goto pc+0")
 __msg("frame1: regs=r1 stack=-8,-16 before 8: (7b) *(u64 *)(r10 -16) = r1")
 __msg("frame1: regs=r1 stack=-8 before 7: (7b) *(u64 *)(r10 -8) = r1")
 __msg("frame1: regs=r1 stack= before 4: (85) call pc+2")
 /* main frame */
-__msg("frame0: regs=r0,r1 stack=-8 before 3: (7b) *(u64 *)(r10 -8) = r1")
-__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
+__msg("frame0: regs=r1 stack=-8 before 3: (7b) *(u64 *)(r10 -8) = r1")
+__msg("frame0: regs=r1 stack= before 2: (bf) r1 = r0")
 __msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void precision_stack(void)
@@ -283,7 +218,8 @@ void precision_stack__foo(void)
 	 */
 	"*(u64*)(r10 - 8) = r1;"
 	"*(u64*)(r10 - 16) = r1;"
-	/* force r1 to be precise, this immediately marks:
+	"if r1 > 7 goto +0;"
+	/* force r1 to be precise, this eventually marks:
 	 * - foo frame r1,fp{-8,-16}
 	 * - main frame r1,fp{-8}
 	 */
@@ -299,15 +235,17 @@ void precision_stack__foo(void)
 SEC("socket")
 __success __log_level(2)
 /* r{6,7} */
-__msg("11: (0f) r3 += r7")
-__msg("frame0: regs=r6,r7 stack= before 10: (bf) r3 = r10")
+__msg("12: (0f) r3 += r7")
+__msg("frame0: regs=r7 stack= before 11: (bf) r3 = r10")
+__msg("frame0: regs=r7 stack= before 9: (25) if r7 > 0x7 goto pc+0")
 /* ... skip some insns ... */
 __msg("frame0: regs=r6,r7 stack= before 3: (bf) r7 = r0")
 __msg("frame0: regs=r0,r6 stack= before 2: (bf) r6 = r0")
 /* r{8,9} */
-__msg("12: (0f) r3 += r9")
-__msg("frame0: regs=r8,r9 stack= before 11: (0f) r3 += r7")
+__msg("13: (0f) r3 += r9")
+__msg("frame0: regs=r9 stack= before 12: (0f) r3 += r7")
 /* ... skip some insns ... */
+__msg("frame0: regs=r9 stack= before 10: (25) if r9 > 0x7 goto pc+0")
 __msg("frame0: regs=r8,r9 stack= before 7: (bf) r9 = r0")
 __msg("frame0: regs=r0,r8 stack= before 6: (bf) r8 = r0")
 __flag(BPF_F_TEST_STATE_FREQ)
@@ -328,8 +266,9 @@ __naked void precision_two_ids(void)
 	"r9 = r0;"
 	/* clear r0 id */
 	"r0 = 0;"
-	/* force checkpoint */
-	"goto +0;"
+	/* propagate equal scalars precision */
+	"if r7 > 7 goto +0;"
+	"if r9 > 7 goto +0;"
 	"r3 = r10;"
 	/* force r7 to be precise, this also marks r6 */
 	"r3 += r7;"
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 8a2ff81d8..17fbc1e61 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -106,7 +106,7 @@
 	mark_precise: frame0: regs=r2 stack= before 22\
 	mark_precise: frame0: parent state regs=r2 stack=:\
 	mark_precise: frame0: last_idx 20 first_idx 20\
-	mark_precise: frame0: regs=r2,r9 stack= before 20\
+	mark_precise: frame0: regs=r2 stack= before 20\
 	mark_precise: frame0: parent state regs=r2,r9 stack=:\
 	mark_precise: frame0: last_idx 19 first_idx 17\
 	mark_precise: frame0: regs=r2,r9 stack= before 19\
-- 
2.43.0

