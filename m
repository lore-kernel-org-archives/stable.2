Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10483033DE;
	Sat, 29 Aug 2026 03:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974662; cv=none; b=gp9qXGUylzG18n+7n2SMyVExssqseN2jGfYRnk5ocoHBMlnl5fYfSHSywgmTvWHCtw0wpuWLUAKpaBuOl6V2P7w8GiBhpDYRscbzuN1TO20wmsIWXHu0NFupGlAe+JHlRF8Eh+AshttB7MYiZ1GG69QAHnHM2SMrzyFvluJR910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974662; c=relaxed/simple;
	bh=LUwuw8SwoNLDZvetPeStfZ8kQvyEP/ySTwseZ0aPHdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlkmtzXSB50o8EiRgX+3uberUQd3/hxB9cVCbGh72t7GvJtUJtLbJeDQlQRVDQdpXvtVpRYWUucKplSbYoj90UNESVTIS7ekdUN5q9Crw+TwdscrMloUphjIgMk79e8eHSFvj1oaU58CjHDErsSC+VtWbwkGMSCWZlPtW83l4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=FAvsONFf; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="FAvsONFf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=rRvGaXigj9AE1DnAORB1B6ums6TuZS9Ob5
	iJQWHymV8=; b=FAvsONFfH3GhFYa0dOlDYtLSA97WqRtQxh+GphtT8W6kgqqyhc
	Z0ZsdSv5UJQ2vwpJnqH5GWeUG1s9FSX4dxQWzjQJo3oqmFEVL4yWydNfupqbbZ6t
	fVfXmMdyJXsVr6vNusEJgHYqQEYeowdT7KDVrh57aPafeaxXWdBy509ZE=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBnazL8U5Jq91+zAA--.221S2;
	Sat, 29 Aug 2026 11:37:33 +0800 (CST)
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
Subject: [PATCH 6.12.y v2 2/2] bpf: Invalidate dynptr clones in every call frame on release
Date: Sat, 29 Aug 2026 11:37:25 +0800
Message-ID: <20260829033725.2365697-3-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829033725.2365697-1-xyx2021@mail.ustc.edu.cn>
References: <20260829033725.2365697-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBnazL8U5Jq91+zAA--.221S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF17ZFWDZF4rZF4UXw48Xrb_yoW7ZFW5pF
	Z5Ka9IqryxJF48Krn7Jws7Wr4FgF4kXrW7GFWrt3yrAF1Yvr98ZF1fKryUXr9ayFWFkw4Y
	yw4SqFsxAw4UXaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
	Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bOJ5wUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

From: Amery Hung <ameryhung@gmail.com>

[ Upstream commit 308c7a0ae8859b34d9d90a3dff953b2d14242145 ]

This is a 6.12.y-sized equivalent, not a cherry-pick of the upstream
diff.

unmark_stack_slots_dynptr() walked clones only in the submitting
pointer's frame. A program that clones a ringbuf dynptr in a subprog,
submits the clone, then submits the original in the caller is
accepted: the caller's STACK_DYNPTR slot is never cleared. The second
bpf_ringbuf_commit() flips BUSY on an already-committed header and a
userspace consumer stalls.

Walk every frame and invalidate matching STACK_DYNPTR slots. Leave
WARN_ON_ONCE(release_reference()) as a swallow: a hard -EINVAL would
reject legitimate programs that release once in a different frame
than they acquired.

Depends on "bpf: Invalidate dynptr slices by dynptr_id on release"
only for the slice helper call inside the new loop.

The upstream commit is Amery Hung's parent_id refactor. It cannot be
applied here (see the previous patch). Deviations from 308c7a0ae8859:
keep dynptr_id / ref_obj_id; walk frames with the 6.12 STACK_DYNPTR
slot loop instead of the parent_id DFS.

Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260529014936.2811085-6-ameryhung@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ Xu Yunxiang: Split the upstream parent_id refactor into two
  stable-sized equivalent fixes and rewrite the subject and changelog
  to describe each one. This second patch keeps dynptr_id/ref_obj_id
  and scans every call frame instead of using the upstream parent_id
  DFS. Add a cross-frame clone regression test. ]
Fixes: 361f129f3cc1 ("bpf: Add bpf_dynptr_clone")
Reported-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Assisted-by: Pi:GLM-5.3
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c                         | 39 ++++++++++++-------
 .../testing/selftests/bpf/progs/dynptr_fail.c | 22 +++++++++++
 2 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5d0874a09a8db0..9f314360551f8e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -811,7 +811,7 @@ static void invalidate_slices_of_dynptr(struct bpf_verifier_env *env, int dynptr
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, ref_obj_id, i;
+	int spi, ref_obj_id, i, frm;
 
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
@@ -841,22 +841,31 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	WARN_ON_ONCE(release_reference(env, ref_obj_id));
 	invalidate_slices_of_dynptr(env, state->stack[spi].spilled_ptr.id);
 
-	/* Invalidate any dynptr clones */
-	for (i = 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
-		if (state->stack[i].spilled_ptr.ref_obj_id != ref_obj_id)
+	/* Invalidate any dynptr clones, including those in other frames.
+	 * Do not turn a failing release_reference() into -EINVAL: that
+	 * rejects legitimate cross-frame single releases on 6.6/6.12/6.13.
+	 */
+	for (frm = 0; frm <= env->cur_state->curframe; frm++) {
+		struct bpf_func_state *f = env->cur_state->frame[frm];
+
+		if (!f)
 			continue;
+		for (i = 1; i < f->allocated_stack / BPF_REG_SIZE; i++) {
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
+			/* it should always be the case that if the ref obj id
+			 * matches then the stack slot also belongs to a
+			 * dynptr
+			 */
+			if (f->stack[i].slot_type[0] != STACK_DYNPTR) {
+				verbose(env, "verifier internal error: misconfigured ref_obj_id\n");
+				return -EFAULT;
+			}
+			if (f->stack[i].spilled_ptr.dynptr.first_slot) {
+				invalidate_slices_of_dynptr(env, f->stack[i].spilled_ptr.id);
+				invalidate_dynptr(env, f, i);
+			}
 		}
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index a896701855a4b0..1787289a5218f9 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1512,6 +1512,28 @@ int clone_invalid2(struct xdp_md *xdp)
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
+__failure __msg("is an unacquired reference")
+int clone_invalidate_cross_frame(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(struct sample), 0, &ptr);
+	submit_dynptr_clone(&ptr);
+
+	/* The clone release in the callee must invalidate the caller's ptr. */
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+	return 0;
+}
+
 SEC("?raw_tp")
 __failure __msg("Expected an initialized dynptr as arg #2")
 int clone_invalidate1(void *ctx)
-- 
2.43.0

