Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D94A3793DF;
	Sat, 29 Aug 2026 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787999211; cv=none; b=caznQucp6Y5CSDu1zxU7I6uJN1MG9oL0450hA8IFI1YFUu1lhp/QrylvYgCNitR71Iks1bXXGkDr4GpYMsIg6ACv3OJfzXyUfgk9F4gHM/0cL2edhbHVA38ZNXMG/ixpJ0q9x1j7qfMK2s9xUVQrjFzFfqwDVh27r3hsSJ7t6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787999211; c=relaxed/simple;
	bh=3XFeC9IcikwKjS36id0sTw7navq83mMKzL3MECIgVbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRjYFSzgl4c6XdQdohYJzzdzMwPa4oZefUP31Tr98Lt/YjTtCOy76paMiRxAQfAilGQ3dLqc1atVjwl45+CmfCmZaDabvXOuhn08+bxlQy4sw2XV4rBZzMpjFl9EAr8tQU8UKRMGs/bI8v3ImgZDduEJXP6r1UWANpKU1VgVxio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=pXSaSWFr; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="pXSaSWFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=gLGrcu9bwV2ElhVQdTCEB19hfIshkoJ5g4
	EueZv/VOM=; b=pXSaSWFrANmcrUprg5saOw+lLNbSOLFoU4ySg+0gG8u3MTRDsT
	ViA2iGmF3RNgJ9XTI7fwjxuAGXxNCi6k1ENyAZjdULl+4Ff5NcaBFc0xV0QBtvVj
	Z8J0orXYrScZEmD9OAr905+p1l268n41GY0JN1TagBuMU+GBubWhHJI4w=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAHCjHis5Jq3fC0AA--.1321S2;
	Sat, 29 Aug 2026 18:26:42 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	ameryhung@gmail.com,
	joannelkoong@gmail.com
Subject: [PATCH 6.12.y v3 1/3] bpf: Invalidate dynptr slices by dynptr_id on release
Date: Sat, 29 Aug 2026 18:26:36 +0800
Message-ID: <20260829102638.105170-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829102638.105170-1-xyx2021@mail.ustc.edu.cn>
References: <20260829033725.2365697-1-xyx2021@mail.ustc.edu.cn>
 <20260829102638.105170-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgAHCjHis5Jq3fC0AA--.1321S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr1kuF18KryxGr4rGFykKrg_yoWxCr4kpF
	sYk3sFgr1vqF4xKFsrXFs7AFW5KF4kXw43GFWrK3yxJrnYqr98ZF1kKryUXrnIyFyFkr47
	Aw1aqrZxZr48WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
	Av7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5IztUUUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

From: Amery Hung <ameryhung@gmail.com>

[ Upstream commit 308c7a0ae8859b34d9d90a3dff953b2d14242145 ]

This is a 6.12.y-sized equivalent, not a cherry-pick of the upstream
diff.

unmark_stack_slots_dynptr() comments say it invalidates slices of the
released dynptr, but it only calls release_reference(ref_obj_id).
bpf_dynptr_slice() and bpf_dynptr_slice_rdwr() stamp dynptr_id and
leave ref_obj_id at 0, so LDX/STX through those slices remains allowed
after bpf_ringbuf_submit_dynptr() / bpf_ringbuf_discard_dynptr().
bpf_dynptr_data() slices already carry ref_obj_id.

Walk registers with a matching dynptr_id, the same way
destroy_if_dynptr_stack_slot() already does when a dynptr stack slot is
overwritten. Do this for the released dynptr, for each clone, and for
the non-refcounted path.

Check the register base type before reading dynptr_id because the field
shares a union with other register metadata. Use base_type() rather than
an exact type match so slices carrying DYNPTR_TYPE_* flags remain covered.

The upstream commit is Amery Hung's parent_id refactor (Fixes:
870c28588afa, qdisc kfuncs). It cannot be applied here:

- It is an 11-file bpf-next change, well over the 100-line stable
  limit, and it removes dynptr_id / ref_obj_id.
- 6.12.y still uses dynptr_id and does not have the qdisc kfuncs in
  that Fixes: tag, so AUTOSEL never pulled it.

Deviations from 308c7a0ae8859: keep dynptr_id and ref_obj_id; do not
introduce parent_id; only add slice invalidation on
unmark_stack_slots_dynptr().

Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260529014936.2811085-6-ameryhung@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ Xu Yunxiang: Backport the slice-invalidation part of the upstream
  parent_id refactor and rewrite the subject and changelog.
  This patch keeps dynptr_id/ref_obj_id and
  invalidates slices from unmark_stack_slots_dynptr(). Add a regression
  test for a bpf_dynptr_slice() pointer used after submit. ]
Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
Reported-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Closes: https://lore.kernel.org/r/20260829033725.2365697-2-xyx2021@mail.ustc.edu.cn
Assisted-by: Pi:GLM-5.3
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c                         | 27 +++++++++++++++++--
 .../testing/selftests/bpf/progs/dynptr_fail.c | 20 ++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 99b3f539e431fe..dbc9cfcffcd60d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -805,6 +805,9 @@ static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_stat
 	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
 }
 
+static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_state *reg);
+static void invalidate_slices_of_dynptr(struct bpf_verifier_env *env, int dynptr_id);
+
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
@@ -815,6 +818,7 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 		return spi;
 
 	if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
+		invalidate_slices_of_dynptr(env, state->stack[spi].spilled_ptr.id);
 		invalidate_dynptr(env, state, spi);
 		return 0;
 	}
@@ -828,8 +832,14 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	 * 2) Any slices derived from this dynptr.
 	 */
 
-	/* Invalidate any slices associated with this dynptr */
+	/* Invalidate any slices associated with this dynptr.
+	 * release_reference() only walks registers that carry ref_obj_id;
+	 * slices are PTR_TO_MEM with dynptr_id set and ref_obj_id left 0.
+	 * Mirror destroy_if_dynptr_stack_slot(), which already invalidates
+	 * slices by dynptr_id.
+	 */
 	WARN_ON_ONCE(release_reference(env, ref_obj_id));
+	invalidate_slices_of_dynptr(env, state->stack[spi].spilled_ptr.id);
 
 	/* Invalidate any dynptr clones */
 	for (i = 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
@@ -844,8 +854,10 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 			verbose(env, "verifier internal error: misconfigured ref_obj_id\n");
 			return -EFAULT;
 		}
-		if (state->stack[i].spilled_ptr.dynptr.first_slot)
+		if (state->stack[i].spilled_ptr.dynptr.first_slot) {
+			invalidate_slices_of_dynptr(env, state->stack[i].spilled_ptr.id);
 			invalidate_dynptr(env, state, i);
+		}
 	}
 
 	return 0;
@@ -862,6 +874,17 @@ static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_
 		__mark_reg_unknown(env, reg);
 }
 
+static void invalidate_slices_of_dynptr(struct bpf_verifier_env *env, int dynptr_id)
+{
+	struct bpf_func_state *fstate;
+	struct bpf_reg_state *dreg;
+
+	bpf_for_each_reg_in_vstate(env->cur_state, fstate, dreg, ({
+		if (base_type(dreg->type) == PTR_TO_MEM && dreg->dynptr_id == dynptr_id)
+			mark_reg_invalid(env, dreg);
+	}));
+}
+
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi)
 {
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index dfd817d0348c47..61bd3f7c946f63 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -316,6 +316,26 @@ int data_slice_use_after_release1(void *ctx)
 	return 0;
 }
 
+/* Releasing a dynptr must invalidate slices that only carry dynptr_id. */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int slice_kfunc_use_after_submit(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	struct sample *sample;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
+	sample = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*sample));
+	if (!sample) {
+		bpf_ringbuf_discard_dynptr(&ptr, 0);
+		return 0;
+	}
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+	/* this should fail */
+	val = sample->pid;
+	return 0;
+}
+
 /* A data slice can't be used after it has been released.
  *
  * This tests the case where the data slice tracks a dynptr (ptr2)
-- 
2.43.0

