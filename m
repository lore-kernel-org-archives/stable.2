Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297EC2F3621;
	Sat, 29 Aug 2026 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787999213; cv=none; b=Y0JcNqG5StzMjjjaB6qEjWw86vMTliLEZjpNQTxa9gyt1txUjjSN/pwzuboygJLELFolS7MCSiCA51oltPuU+LHOSORuA/N7WJbDW3010Ap1OZf7+XktqzR+oq7xI6t814TIyJ7Pg+UWGDV8t4iMStgcuoZpcutkQop9HIy/TQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787999213; c=relaxed/simple;
	bh=tbql3P6FfZ9Y8zbTUKvbWAWMDINwCRJfDmrvffC/hLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEcpzMxvhoxuzbKymVUHO1PH7ZmDgoslR6QQ9T2UxXVybZ8vbK+I1fGnsDOpPkw8L+eFzm47uxlJ1KvUX/Y0CSuRigpWVbc4StVwd33Mg8ftOUhOkyxLsr1aNMiax1RXCvvkZYjhF+yYDdhp0gp9DyUwoTJnrKG60eAP+tsP9ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=qXwx8JSc; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="qXwx8JSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=tfVdvfFf/nCVXNp1fP3ritGpJIQbM0usrx
	Q5FLGzyRo=; b=qXwx8JScs5hgOfCHH5UxtjpO1wb6fYX+C2dEF3+ArE4ZpcUyWb
	A1i8sOgVa4zKQ5L1/x6qm+7r9SY+MS4MByuNIQJSk5dySPlbnPlPVSaHmjcpWR/1
	LnJOyTpM/unb6vA4mysouPUXdyzxm9uKgU7EDV6iiubES6d5o8sMczlhQ=
Received: from localhost (unknown [183.216.9.64])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDn6C_ks5Jq7vC0AA--.1358S2;
	Sat, 29 Aug 2026 18:26:44 +0800 (CST)
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
Subject: [PATCH 6.12.y v3 2/3] bpf: Propagate referenced dynptr release errors
Date: Sat, 29 Aug 2026 18:26:37 +0800
Message-ID: <20260829102638.105170-3-xyx2021@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgDn6C_ks5Jq7vC0AA--.1358S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4kXrWDZF4UWrW7XryxKrg_yoWrCF1UpF
	48u39Fqr1IqF4xKrs7AFs7uF4F9an3XrW3GrWkt34fZr1rXF98ZFnYgr1jqrn0yrWrCw4Y
	vw12gF43Zw4UXFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
	Av7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUYO0etUUUUU==
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
index dbc9cfcffcd60d..65ee9afaa5ff07 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -811,7 +811,7 @@ static void invalidate_slices_of_dynptr(struct bpf_verifier_env *env, int dynptr
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, ref_obj_id, i;
+	int spi, ref_obj_id, i, err;
 
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
@@ -838,7 +838,9 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
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
index 61bd3f7c946f63..52bd7f8871c579 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -134,6 +134,28 @@ int ringbuf_missing_release_callback(void *ctx)
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

