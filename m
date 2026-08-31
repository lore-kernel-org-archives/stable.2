Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DC817DFFA;
	Mon, 31 Aug 2026 00:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135358; cv=none; b=Knn6Tqc8scs9DHxzN6IwfgOjO/6NZvuX7zh87z10EaXEVb2KmnOB7hb/ImV3SRd4IJTD+VdYiaaXXjVAM5BNk/tUtEbuJi0l8TO858PAu9GOJEu7e6zJBbatTYdqWUrglhLggM//sQYl7JhSQerYXWWamxTYQk3sNKyyBkVUako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135358; c=relaxed/simple;
	bh=tjQk/tcoXTWlnW1mv4zPyWztDKkSgasv8OZ4hH9nPkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li2h4drQsjfnVCDIAOvUX4cvVcn9uYHk1bgQSvap7azOVP0cBqQhAtTO5+Lca8SSg81FHqV1B72ZSIGXJs7jMsJt9nhxuV3S3X8ZcQQCDVFYQ0++3RegFhjpbv3blIJdKZIEJfWRO8oOS+5/Ozw+/zaSRHL3v11Hv9SDYc+2E6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=FPIS2ECx; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="FPIS2ECx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=FAd/imFfuZQaHyax7PtwCtdJmSuJoGh37Q
	2I8Ea5Tls=; b=FPIS2ECxS3NQN+WN2TI7MmuY0qopDdyZnfYb1EOh5x1fre8uJJ
	+u+71IuF7f+PhJcizxidhCyOv3mWXCgh700Bq6ZB8xBPwVZzAhglhzaB19vmUsTI
	x3BjNbzhysoPE2COu+2p/SkUfIRs4yBCAgKRNf84yNCjjlqHqyKm9dFhI=
Received: from localhost (unknown [222.195.81.60])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDXxBupx5RqU6e+AA--.2640S2;
	Mon, 31 Aug 2026 08:15:37 +0800 (CST)
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
Subject: [PATCH 6.6.y v3 2/3] bpf: Propagate referenced dynptr release errors
Date: Mon, 31 Aug 2026 08:15:23 +0800
Message-ID: <20260831001524.3223134-3-xyx2021@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgDXxBupx5RqU6e+AA--.2640S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4kXrWDZF4UWrWrtry8AFb_yoWrJw1UpF
	4ku39Iqr1IqF4xKrs7AFs7Za1F9a1rX3y3GrW8t34fAr1rXr98ZF9Ygr1jqrs0yrWrGw45
	Zw12gF45Zw4UXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF
	1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_tw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07brHqxUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

[ Upstream commit 308c7a0ae8859b34d9d90a3dff953b2d14242145 ]

This is a stable-sized equivalent, not a cherry-pick of the upstream
diff.

release_reference_state() rejects an attempt from a BPF callback to
release a reference acquired by its caller. For referenced dynptrs,
unmark_stack_slots_dynptr() instead wraps release_reference() in
WARN_ON_ONCE() and then returns success.

Consequently, a callback that submits or discards its caller's ringbuf
dynptr can turn this normal verifier rejection into a kernel warning. A
kernel configured with panic_on_warn=1 panics while verifying the program.

Propagate the release_reference() error to check_helper_call(), which
already reports the invalid release and rejects the program. Add a
regression test using a non-constant bpf_loop() iteration count so the
callback is verified in a separate frame.

The upstream parent_id refactor returns release_reference() directly from
unmark_stack_slots_dynptr(). Extract that behavior here while retaining
the stable kernels' ref_obj_id representation.

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
index ccd5c86706b1..c9e3856bb59f 100644
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
index 6ac09d6c34f2..3d431e583c49 100644
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

