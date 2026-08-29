Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047C2382394;
	Sat, 29 Aug 2026 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787999202; cv=none; b=FznLiqBvZxqMzbPmFF8fDfSteL+oXT4ltLaomx9WV8XtfqTEPnsQHaR2eUTi3/ChYA8Z2HxVSgEwY8WNXpPUbA7UwA3ANjma9R+CQLq7nUK5sy6DYbEXQoAxA24SvKZ5uxQbLD4pBPZUavGYIMXoGLE8dZ2KtZKbhubBKljBLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787999202; c=relaxed/simple;
	bh=I+oCA/ECYr7ov2ox1OIyDGp1T1W2ahQAHHMk4swgEs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+HyGYiXlAbD4Ui9IoraKIHsM3hev0dVnFbzsLK80LIh6szR3PRTCe2BvwvyfydKpnT4ca9YBEB6r+7aLFMCr2B8B3UT1gGCYf460ANbwNASKto863UOJj8d6PcmavnHFu9uBtzyZ3522iI71TkWONErWdOx3l3MW2pDfnymvMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=r/v4OJF6; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="r/v4OJF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=E4dHbNivA/iP99RT7gj+0K49/tUf+b1nWW
	RpXpzUCaE=; b=r/v4OJF6Op3v8u8AvM8Z53E/bKeB+G93rsFJBeAbXwdt/KJsv1
	6MV/taZHGtXAWQba7IS0HNCyoT7EQGvgOyQz5xwWnE7kbm7iW0Ror16YIJj/rW1q
	LYDeaUAEA1OaytEgg+sKHuu1BFdOleHecNhIc+v449L7l4ZGgyzxbwWg4=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCHjDPRs5JqmPC0AA--.5645S2;
	Sat, 29 Aug 2026 18:26:25 +0800 (CST)
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
Subject: [PATCH 6.6.y v2 2/3] bpf: Propagate referenced dynptr release errors
Date: Sat, 29 Aug 2026 18:26:17 +0800
Message-ID: <20260829102618.105116-3-xyx2021@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgCHjDPRs5JqmPC0AA--.5645S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4kXrWDZF4UWrW7XryxKrg_yoWrCF15pF
	48u39Iqr1IqF48Krs7AFs7ZF1F9an5XrW3GrWkt34fZr1rXF98ZF9Ygr1jqrn0yrW8Gw4Y
	vw12gF45Zw4UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
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

This is a stable-sized equivalent, not a cherry-pick of the upstream
diff.

release_reference_state() rejects an attempt from a BPF callback to
release a reference acquired by its caller.  For referenced dynptrs,
unmark_stack_slots_dynptr() instead wraps release_reference() in
WARN_ON_ONCE() and then returns success.

Consequently, a callback that submits or discards its caller's ringbuf
dynptr can turn this normal verifier rejection into a kernel warning.  A
kernel configured with panic_on_warn=1 panics while verifying the program.

Propagate the release_reference() error to check_helper_call(), which
already reports the invalid release and rejects the program.  Add a
regression test using a non-constant bpf_loop() iteration count so the
callback is verified in a separate frame.

The upstream parent_id refactor returns release_reference() directly from
unmark_stack_slots_dynptr().  Extract that behavior here while retaining
the stable kernels' ref_obj_id representation.

Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260529014936.2811085-6-ameryhung@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ Xu Yunxiang: Extract only the referenced-dynptr error propagation from
  the upstream object relationship refactor for the old stable verifier.
  Add a callback regression test. ]
Fixes: 270605317366 ("bpf: Rework process_dynptr_func")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260829040110.D6A991F000E9@smtp.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c                         |  6 +++--
 .../testing/selftests/bpf/progs/dynptr_fail.c | 22 +++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ccd5c86706b184..c9e3856bb59fdb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -996,7 +996,7 @@ static void invalidate_slices_of_dynptr(struct bpf_verifier_env *env, int dynptr
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, ref_obj_id, i;
+	int spi, ref_obj_id, i, err;
 
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
@@ -1023,7 +1023,9 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	 * Mirror destroy_if_dynptr_stack_slot(), which already invalidates
 	 * slices by dynptr_id.
 	 */
-	WARN_ON_ONCE(release_reference(env, ref_obj_id));
+	err = release_reference(env, ref_obj_id);
+	if (err)
+		return err;
 	invalidate_slices_of_dynptr(env, state->stack[spi].spilled_ptr.id);
 
 	/* Invalidate any dynptr clones */
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 6ac09d6c34f2bc..3d431e583c4999 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -133,6 +133,28 @@ int ringbuf_missing_release_callback(void *ctx)
 	return 0;
 }
 
+static int release_caller_dynptr_callback_fn(__u32 index, void *data)
+{
+	struct bpf_dynptr *ptr = data;
+
+	bpf_ringbuf_submit_dynptr(ptr, 0);
+	return 0;
+}
+
+/* A callback cannot release a dynptr reference acquired by its caller. */
+SEC("?raw_tp")
+__failure __msg("reference has not been acquired before")
+int ringbuf_release_caller_dynptr_callback(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	if (bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, &ptr))
+		return 0;
+	bpf_loop(val & 1, release_caller_dynptr_callback_fn, &ptr, 0);
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
 /* Can't call bpf_ringbuf_submit/discard_dynptr on a non-initialized dynptr */
 SEC("?raw_tp")
 __failure __msg("arg 1 is an unacquired reference")
-- 
2.43.0

