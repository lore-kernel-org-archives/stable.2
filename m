Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C862C2E62B3;
	Sat, 29 Aug 2026 03:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974620; cv=none; b=nFR5OxQUxiB/lcFsBjuz4Se8eyXkY3VIm1xBBEVRGqg56PUd+EqSyBpNz64CF4ONem6MiGUfOeEBlSJvpcywNhfvDsg0YCL1P0DSEfxoAS86M6JudfTcQ5QtCFO4iH0VV+BrfhK/YeD/NNtuxUNPozdJdHA94mNkgoJafSpze2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974620; c=relaxed/simple;
	bh=GjmZVCmYYE6QQEmkGblUMYlrAvkdQ0u+eoWNZ4xFGDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDYqtATEkdExR3JjY4xGx3QoGky8cLmQKnSHfBjh/NLs0zAwu9TAIcmZ0uEQ1IqB7PwvvOSTJOv19pn4yEAB/o9yASqRNAxgqGXknEbMPil6qSSd13qWzoICTyJz2ymi3EmNhyDLaMvVQPBYr/BaoIeUS4pgVq6eCEgXi8PI0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=NeO63joi; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="NeO63joi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=90Ny4MLaxvSP/nSvI5s6UO+HMfibWe19H4
	I0gv/YRJM=; b=NeO63joiSZUCHMmEcE/3ZCU/6QrEWIUJv++myu6JI7EJBII1oj
	sPlDxcMybwcU/rNR/PmPtSghiWv1ssT8ZmMqqlNn4FDT/ijLVb3TabRup5MBPzma
	rIo4IyIzudhOM7yhL9REfRXXMAe20NMx32yJg8sT2kn3PVRcVkqdj5L1c=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAnKjHPU5JqPF+zAA--.229S2;
	Sat, 29 Aug 2026 11:36:48 +0800 (CST)
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
Subject: [PATCH 6.6.y 1/2] bpf: Invalidate dynptr slices by dynptr_id on release
Date: Sat, 29 Aug 2026 11:36:45 +0800
Message-ID: <20260829033645.2365631-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829032754.2324760-1-xyx2021@mail.ustc.edu.cn>
References: <20260829032754.2324760-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgAnKjHPU5JqPF+zAA--.229S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr1kuw15Aw17uFykXry3XFb_yoWxXF4fpF
	sYk3sFgr40qF4xKFnrAFs7AFW5KF4kXw43GFWrK3yxJrnYqr98ZF1kKryUXrnIyFy0kw47
	Aw1SqrsxZr4Uu3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jrv_JF1lnxkEFVAIw20F6cxK64vIFxWl
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8Zw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07brTmDUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

From: Amery Hung <ameryhung@gmail.com>

[ Upstream commit 308c7a0ae8859b34d9d90a3dff953b2d14242145 ]

This is a 6.6.y-sized equivalent, not a cherry-pick of the upstream
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

The upstream commit is Amery Hung's parent_id refactor (Fixes:
870c28588afa, qdisc kfuncs). It cannot be applied here:

- It is an 11-file bpf-next change, well over the 100-line stable
  limit, and it removes dynptr_id / ref_obj_id.
- 6.6.y still uses dynptr_id and does not have the qdisc kfuncs in
  that Fixes: tag, so AUTOSEL never pulled it.

Deviations from 308c7a0ae8859: keep dynptr_id and ref_obj_id; do not
introduce parent_id; only add slice invalidation on
unmark_stack_slots_dynptr().

Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260529014936.2811085-6-ameryhung@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ Xu Yunxiang: Split the upstream parent_id refactor into two
  stable-sized equivalent fixes and rewrite the subject and changelog
  to describe each one. This first patch keeps dynptr_id/ref_obj_id and
  invalidates slices from unmark_stack_slots_dynptr(). Add a regression
  test for a bpf_dynptr_slice_rdwr() pointer used after submit. ]
Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
Reported-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Assisted-by: Pi:GLM-5.3
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c                         | 27 +++++++++++++++++--
 .../testing/selftests/bpf/progs/dynptr_fail.c | 20 ++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ad679bc42427c8..62fa2895a92050 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -990,6 +990,9 @@ static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_stat
 	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
 }
 
+static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_state *reg);
+static void invalidate_slices_of_dynptr(struct bpf_verifier_env *env, int dynptr_id);
+
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
@@ -1000,6 +1003,7 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 		return spi;
 
 	if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
+		invalidate_slices_of_dynptr(env, state->stack[spi].spilled_ptr.id);
 		invalidate_dynptr(env, state, spi);
 		return 0;
 	}
@@ -1013,8 +1017,14 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
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
@@ -1029,8 +1039,10 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
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
@@ -1047,6 +1059,17 @@ static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_
 		__mark_reg_unknown(env, reg);
 }
 
+static void invalidate_slices_of_dynptr(struct bpf_verifier_env *env, int dynptr_id)
+{
+	struct bpf_func_state *fstate;
+	struct bpf_reg_state *dreg;
+
+	bpf_for_each_reg_in_vstate(env->cur_state, fstate, dreg, ({
+		if (dreg->dynptr_id == dynptr_id)
+			mark_reg_invalid(env, dreg);
+	}));
+}
+
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi)
 {
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 66a60bfb58672f..131f55fbd6ed31 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -315,6 +315,26 @@ int data_slice_use_after_release1(void *ctx)
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
+	sample = bpf_dynptr_slice_rdwr(&ptr, 0, NULL, sizeof(*sample));
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

