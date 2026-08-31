Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9727242D67;
	Mon, 31 Aug 2026 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135365; cv=none; b=bgUSnTjq8zBFlLniNqRDB+27gG+F0aUe5FsN0vTsB60d8MC2o+zJv8Yk15zlB140463REIBgwz6uyuwLv+0ae+90ushny3CcVbkUzgc79M/L5Gbj8iyy4aQUBycDvqrrOPHpwS+N5VbwIDKUGRCRoWorA3dc4+DUsnz/ahkOo6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135365; c=relaxed/simple;
	bh=2ioPfrJZa9P6FEKRT6EDS85yX/LQ2SB8L79dle+5s9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApWaWNrTdCIZ+omOkIrBFnf3TMPYe+l9/sxKa4dEtDRm8X1TNFqlKqpqJ0NymhDJpi1pKrL2uNy9cNqIYSIMhTVOFhuLKHmm/Zz6FYqhydSt2osv0dIFs2hDzOhaDYscGZNhqO8tVqxF1wQMh5xI9vjWaK8TJLgxlUdU/v3VMww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=I7CXBlsK; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="I7CXBlsK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=wEQmqpcncrfjvZ1xDsaaG1Y4dNHuTjWElU
	6pMapkMNE=; b=I7CXBlsKcUFh0O36WiEs/j6O8tB/ckq+0bKz8yLmjV46U7muPq
	LqPlTV8nF32xp8cG8skTlDicwxfLUQ4gujPC6wvz5TqE1oCOkTSS0OfW8bnvj/Uy
	cEijrEApJYT6KFfWfC/f7kfA43e51DzscIEuPuO+uBCcFHxal377ne4mY=
Received: from localhost (unknown [222.195.81.60])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCHfiW9x5Rqn6e+AA--.2688S2;
	Mon, 31 Aug 2026 08:15:57 +0800 (CST)
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
Subject: [PATCH 6.12.y v4 2/3] bpf: Propagate referenced dynptr release errors
Date: Mon, 31 Aug 2026 08:15:51 +0800
Message-ID: <20260831001552.3223196-3-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831001552.3223196-1-xyx2021@mail.ustc.edu.cn>
References: <20260831001552.3223196-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgCHfiW9x5Rqn6e+AA--.2688S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4kXrWDZF4UWrWrtry8AFb_yoWrJFWDpF
	48u39Fqr1IqF4Ikrs7AFs7ZF4F9Fs3X3y3GrW8t34fAr1rXF98ZFnYgr1jqrn0yrWrGw43
	Zw12gF43Zw4UXrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBKb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r
	1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67AK6w
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUYPl1JUUUUU=
	=
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
index dbc9cfcffcd6..65ee9afaa5ff 100644
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
index 61bd3f7c946f..52bd7f8871c5 100644
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

