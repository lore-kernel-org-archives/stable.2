Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1441F332917;
	Sat, 29 Aug 2026 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787999205; cv=none; b=G/iwn43Mar8Ynojh2r9DO5AphMwtFyFx23GpdIXewV/Aaac6WysbSssgZjbPiRxdO7PZopctOsIUVcRzLEVgl/FHo6BQy0img3Bk/+iFZmVt48nLhui3Be+kUIvOXRd3ay9vn17DXfW1R3nOpvkGUol1x5ISrP5K3EFzu+NkTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787999205; c=relaxed/simple;
	bh=b+a1UfMrKxlQiWJsFL+SadFiAeP7CqyRs06a4hq/ljw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NW67vrRqyhxhh9RKP8F21/brcMq2Q+jISeW/4xpGPLWTPyC4eOtjTrO8EATLsGFlQuZ7UBBIPWWIkXGtA3k0s1fNuzrFL0XgT1/ZyQu0IGmKNtUWOLXQsctK5e/sd60OrqX2ajldCRyaN2HO93TfJXyxA3nGn4L0OhXP+bvCiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=fwuQ7BSm; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="fwuQ7BSm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=1tE4lil9+oP/3glNweXbT7yaLGCU1tbQ79
	4B6lScGYw=; b=fwuQ7BSmE0rcHojg5/NLTV8y/k2zcAKQhzUP/R/MMQKFleZI1v
	1h/+Vuqp1qksxIz18Dzm2gEWBXBM2vxU0qqSahewmbJotE/vF7Qts0fInt9q60CA
	WJFfW0lrxlwnkYcZGx0s10HxDdrDdD1lTr6ei5mQ8W62yTt+r0yMIWj8c=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAnKjHTs5Jqn_C0AA--.1353S2;
	Sat, 29 Aug 2026 18:26:27 +0800 (CST)
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
Subject: [PATCH 6.6.y v2 3/3] bpf: Invalidate dynptr clones in every call frame on release
Date: Sat, 29 Aug 2026 18:26:18 +0800
Message-ID: <20260829102618.105116-4-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829102618.105116-1-xyx2021@mail.ustc.edu.cn>
References: <20260829032754.2324760-1-xyx2021@mail.ustc.edu.cn>
 <20260829102618.105116-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgAnKjHTs5Jqn_C0AA--.1353S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtrykKr15uF48CryxCFy5twb_yoW7KFWDpF
	Wvk342gr18JF48Kr9rJws7GF4YgF4kXrW7GFWFy3yrJrnYvry5ZF18Kr1UXr9xtFWYkw43
	Jrs3XFsxZw4UWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
	AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07b0jgsUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

From: Amery Hung <ameryhung@gmail.com>

[ Upstream commit 308c7a0ae8859b34d9d90a3dff953b2d14242145 ]

This is a 6.6.y-sized equivalent, not a cherry-pick of the upstream
diff.

unmark_stack_slots_dynptr() walked clones only in the submitting
pointer's frame. A program that clones a ringbuf dynptr in a subprog
and submits the clone leaves the original STACK_DYNPTR slot active in
the caller. The caller can then pass that stale original to
bpf_dynptr_data(), even though the shared ringbuf reference has already
been released.

Walk every frame and invalidate matching STACK_DYNPTR slots. Check the
slot type before reading dynptr metadata: a partial stack overwrite can
turn a pointer spill into ordinary stack data while stale union fields
remain, and those fields must not be interpreted as a dynptr ref_obj_id.
The preceding patch makes a repeated release an ordinary verifier
rejection, but it does not prevent non-release uses of a stale dynptr.

Depends on "bpf: Invalidate dynptr slices by dynptr_id on release"
only for the slice helper call inside the new loop.

The upstream commit is Amery Hung's parent_id refactor. It cannot be
applied here (see the first patch). Deviations from 308c7a0ae8859:
keep dynptr_id / ref_obj_id; walk frames with the 6.6 STACK_DYNPTR
slot loop instead of the parent_id DFS.

Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260529014936.2811085-6-ameryhung@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ Xu Yunxiang: Backport the cross-frame clone-invalidation part of the
  upstream parent_id refactor and rewrite the subject and changelog.
  This patch keeps dynptr_id/ref_obj_id
  and scans every call frame instead of using the upstream parent_id
  DFS. Add cross-frame stale-use and stale-spill regression tests. ]
Fixes: 361f129f3cc1 ("bpf: Add bpf_dynptr_clone")
Reported-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Closes: https://lore.kernel.org/r/20260829033701.2365648-1-xyx2021@mail.ustc.edu.cn
Assisted-by: Pi:GLM-5.3
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c                         | 30 +++++++--------
 .../testing/selftests/bpf/progs/dynptr_fail.c | 37 +++++++++++++++++++
 2 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c9e3856bb59fdb..a2df5bbf9ab8d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -996,7 +996,7 @@ static void invalidate_slices_of_dynptr(struct bpf_verifier_env *env, int dynptr
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, ref_obj_id, i, err;
+	int spi, ref_obj_id, i, err, frm;
 
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
@@ -1028,22 +1028,22 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 		return err;
 	invalidate_slices_of_dynptr(env, state->stack[spi].spilled_ptr.id);
 
-	/* Invalidate any dynptr clones */
-	for (i = 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
-		if (state->stack[i].spilled_ptr.ref_obj_id != ref_obj_id)
+	/* Invalidate any dynptr clones, including those in other frames. */
+	for (frm = 0; frm <= env->cur_state->curframe; frm++) {
+		struct bpf_func_state *f = env->cur_state->frame[frm];
+
+		if (!f)
 			continue;
+		for (i = 1; i < f->allocated_stack / BPF_REG_SIZE; i++) {
+			if (f->stack[i].slot_type[0] != STACK_DYNPTR)
+				continue;
+			if (f->stack[i].spilled_ptr.ref_obj_id != ref_obj_id)
+				continue;
 
-		/* it should always be the case that if the ref obj id
-		 * matches then the stack slot also belongs to a
-		 * dynptr
-		 */
-		if (state->stack[i].slot_type[0] != STACK_DYNPTR) {
-			verbose(env, "verifier internal error: misconfigured ref_obj_id\n");
-			return -EFAULT;
-		}
-		if (state->stack[i].spilled_ptr.dynptr.first_slot) {
-			invalidate_slices_of_dynptr(env, state->stack[i].spilled_ptr.id);
-			invalidate_dynptr(env, state, i);
+			if (f->stack[i].spilled_ptr.dynptr.first_slot) {
+				invalidate_slices_of_dynptr(env, f->stack[i].spilled_ptr.id);
+				invalidate_dynptr(env, f, i);
+			}
 		}
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 3d431e583c4999..99a791ddfefcb7 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1509,6 +1509,43 @@ int clone_invalid2(struct xdp_md *xdp)
 }
 
 /* Invalidating a dynptr should invalidate its clones */
+static __noinline void submit_dynptr_clone(struct bpf_dynptr *ptr)
+{
+	struct bpf_dynptr clone;
+
+	bpf_dynptr_clone(ptr, &clone);
+	bpf_ringbuf_submit_dynptr(&clone, 0);
+}
+
+SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr")
+int clone_invalidate_cross_frame(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(struct sample), 0, &ptr);
+	submit_dynptr_clone(&ptr);
+	bpf_dynptr_data(&ptr, 0, sizeof(struct sample));
+	return 0;
+}
+
+SEC("?raw_tp")
+__success
+int clone_invalidate_cross_frame_stale_spill(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	void *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(struct sample), 0, &ptr);
+	data = bpf_dynptr_data(&ptr, 0, sizeof(struct sample));
+	asm volatile("*(u64 *)(r10 - 24) = %[data];"
+		"*(u32 *)(r10 - 20) = 0x12345678;"
+		:: [data] "r"(data) : "memory");
+	/* A dead, scrubbed spill must not be mistaken for a dynptr slot. */
+	submit_dynptr_clone(&ptr);
+	return 0;
+}
+
 SEC("?raw_tp")
 __failure __msg("Expected an initialized dynptr as arg #3")
 int clone_invalidate1(void *ctx)
-- 
2.43.0

