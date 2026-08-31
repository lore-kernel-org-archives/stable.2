Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F0EED8;
	Mon, 31 Aug 2026 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135359; cv=none; b=X8rlKDeswL/jD2IbNro9MOUHdVVpr+zP9KubOdc3wPkvZdztfWA4sWOLW2UKWU0CryezVSzMEtuHN+jlqcwt0sg7HtqXE5JYr0WuTWdW9Jw1lo0j7G9xOu8OI1m3JQO7sAvUhq5sZPumQ/4yJC4SWqvGi+K54OoUXEJqSwdh0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135359; c=relaxed/simple;
	bh=bYmwagc4OGc+Cw6b8mGr0pNSY+Ij4NYDSTeCS9S8zFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3SjaBsIiACpgyjeULjazcZqukIHBg7fvi2AN5SgtEkZWW6CIwagINxGxJM5ZFa2uaD6xUM4bKYNJR59rN8nz8hwg17DYa3pyYd1INvSelppmTw4L9i3A53Yu8KvkUORN0/3lGGZjWcFDSUVMg0mfrd1U/A2JSxhrqQn3VT4tSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=hBwFySRP; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="hBwFySRP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=JfXN9Gkxkasy4rTfsGLXGqEADzTtnQJS9S
	2yZexdiYE=; b=hBwFySRPQs0KvzBKll0fkLSTZ9Dl4LSk4t1C37jsM6EajiaZza
	2DYc8v1PPmj33PlO+lmi1hxD8JjBebasaeV6lNHGf+i+xqQYcaeTuomKX/JQ9o2Q
	hA7LOIcWx3w40GDy8EH1zwMHLX11XkWUVY3ban3SNjwzWplkrXgdA6bJo=
Received: from localhost (unknown [222.195.81.60])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgB3Yxqqx5RqWKe+AA--.2654S2;
	Mon, 31 Aug 2026 08:15:38 +0800 (CST)
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
	joannelkoong@gmail.com,
	sashal@kernel.org
Subject: [PATCH 6.6.y v3 3/3] bpf: Invalidate dynptr clones in every call frame on release
Date: Mon, 31 Aug 2026 08:15:24 +0800
Message-ID: <20260831001524.3223134-4-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831001524.3223134-1-xyx2021@mail.ustc.edu.cn>
References: <20260831001524.3223134-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgB3Yxqqx5RqWKe+AA--.2654S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtrykKr15uF48CryxCFy5twb_yoW7Ar18pF
	Z5K34agr1xXF48Kr9rJws7GF4YgF4kXrW7GFWFy3yfJFnYvr98ZF18KryUXr9xtFWYkw43
	Jw4fXFZxZw4UWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBCb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r
	17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6w
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUyOtIUUUUU
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

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
index c9e3856bb59f..a2df5bbf9ab8 100644
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
index 3d431e583c49..99a791ddfefc 100644
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

