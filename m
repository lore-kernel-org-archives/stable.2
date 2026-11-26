Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708104;
	b=woIOHYlm00jEdr53wBL25PQjomKVzaC77mpznkgcI6qQEE1Jaiu+/U7Sud+ZAa4vxzJS
	 HkxcI3l5LrjXKwtvvizuIQDDaRnNPrdpT6dFTURcz2oxMTcroDgaS/GUJ3uap6biNcS2n
	 ExWYF9KHB2Fy/Hq12kqoUV1I2k92ldHdPUMAnwmt5rA8Pll8oFtYtAomFmF4x5AWOwYlj
	 B6dcDvWHcg4FSKiqn3Srn7ceqII0NofdoT4urnXnZ5haPXFZ//gjiGdQ2Jk2iQul4GtWX
	 2leJ7BbaCijvFIWxzErk85zvkiqEz5+1F3a0Um7IJYQXXTgqXOwJGOHiG6VBDYzsLHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708104;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wwXbWs7ZT8w0B3EdWM8PC+MO7PRX2Vvlhf0W84STFS8=;
	b=FQPu6J/mXOkrHan590/EVNqikiFLzKCQBCP2ND8UoWEHuUrb70ad8t8/uYh+0b4LRQ3h
	 WeZY9nOeiHQ/FDJl30bHWa9hWsG1Ykw6JJiw7JdOneA8c4qyFEeV9tXND7ii7sbnmj+BP
	 /iK0NYrAT9sYZEZ1OlB5vdNiNtSiVSYHf+UPhjJ1GxgU0WuwMNwKgZzIvJDC5mFWl8I+F
	 U+WjzuIlHyYx64RFGE/CMPFMps3aiCbM1f/Nv4PsHL67zqp7+SHn69ReVicRfuUGe9FEQ
	 ZPfhLHBT/YUvmtVx4KT8Kt6LIl0zQC248bj0Ebb5cvd1d9ca2BlgkxEX6T1eyAa1gjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bBeTE3pq;
	arc=none smtp.remote-ip=95.215.58.99
Received: from mta1.migadu.com (out-99.mta1.migadu.com [95.215.58.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F23606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6F23606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bBeTE3pq
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Xp1PCLxg8xh6Qga6z1Nt+omOhAOKOgmPzF6xiXqJdvM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795708102; v=1; x=1796312902;
 b=bBeTE3pqoAFuYc1sZObyBmPAEbMFLHiva5YLbjCTrFWTAb+/uIQ5nEt/WDc+FqrE5t0Ls/yY
 7NdboCbHTrj65AfEDMFyn6K0IKG+SsrWNwN3+dhVxdcjtdzxYpZNrTWbWf/zHChAO9S3uzrML+a
 ++90/er/G6BeYwlaYZJsJluM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a48e11f5e7f05f55;
	Thu, 26 Nov 2026 15:48:21 +0000
X-Mizu-Trace-ID: a48e11f5e7f05f55
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guillaume Laporte <glapt.pro@outlook.com>,
	Vincent Thiberville <vincent@harfanglab.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	KaFai Wan <kafai.wan@linux.dev>,
	Leon Hwang <leon.hwang@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.18.y 1/4] bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()
Date: Thu, 26 Nov 2026 15:47:10 +0000
Message-ID: <20261126154714.169698-2-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126154714.169698-1-leon.hwang@linux.dev>
References: <20261126154714.169698-1-leon.hwang@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 9a6df65d5c6a9947ddab4e563e329720f44b8747 ]

Introduce a 'jit_required' bitfield flag in struct bpf_prog to track
whether a BPF program strictly requires the JIT compiler to run. This
prevents a dangerous runtime fallback to the interpreter for features
that are only implemented in the JIT compiler.

Currently, bpf_prog_has_kfunc_call() is used only for kernel function
calls, replace the kfunc-specific helper with the new 'jit_required'
flag. This makes it easy to support other JIT-only BPF features, such
as inlined helpers.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: KaFai Wan <kafai.wan@linux.dev>
Suggested-by: Leon Hwang <leon.hwang@linux.dev>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
[edit]
  Adapt the bpf_fixup_call_args() change to fixup_call_args() in
  kernel/bpf/verifier.c, and the __bpf_prog_select_runtime() change to
  bpf_prog_select_runtime() in kernel/bpf/core.c.
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   |  9 ++-------
 kernel/bpf/core.c     |  7 ++-----
 kernel/bpf/verifier.c | 12 ++++--------
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d018a74a882d..bb78a97085f6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1704,8 +1704,9 @@ struct bpf_prog_aux {
 
 struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
-	u16			jited:1,	/* Is our filter JIT'ed? */
+	u32			jited:1,	/* Is our filter JIT'ed? */
 				jit_requested:1,/* archs need to JIT the prog */
+				jit_required:1, /* program strictly requires JIT compiler */
 				gpl_compatible:1, /* Is filter GPL compatible? */
 				cb_access:1,	/* Is control block accessed? */
 				dst_needed:1,	/* Do we need dst entry? */
@@ -2854,7 +2855,6 @@ const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id,
 						 const struct bpf_prog *prog);
 void bpf_task_storage_free(struct task_struct *task);
 void bpf_cgrp_storage_free(struct cgroup *cgroup);
-bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
 const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn);
@@ -3137,11 +3137,6 @@ static inline void bpf_task_storage_free(struct task_struct *task)
 {
 }
 
-static inline bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
-{
-	return false;
-}
-
 static inline const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c99d3f396fdc..dfdcb30ea5ca 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -125,6 +125,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	fp->aux->main_prog_aux = aux;
 	fp->aux->prog = fp;
 	fp->jit_requested = ebpf_jit_enabled();
+	fp->jit_required = IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON);
 	fp->blinding_requested = bpf_jit_blinding_enabled(fp);
 #ifdef CONFIG_CGROUP_BPF
 	aux->cgroup_atype = CGROUP_BPF_ATTACH_TYPE_INVALID;
@@ -2564,15 +2565,11 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	/* In case of BPF to BPF calls, verifier did all the prep
 	 * work with regards to JITing, etc.
 	 */
-	bool jit_needed = false;
+	bool jit_needed = fp->jit_required;
 
 	if (fp->bpf_func)
 		goto finalize;
 
-	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
-	    bpf_prog_has_kfunc_call(fp))
-		jit_needed = true;
-
 	if (!bpf_prog_select_interpreter(fp))
 		jit_needed = true;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b89a5d717e42..e91ee66c8e31 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3370,6 +3370,8 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		prog_aux->kfunc_tab = tab;
 	}
 
+	env->prog->jit_required = 1;
+
 	/* func_id == 0 is always invalid, but instead of returning an error, be
 	 * conservative and wait until the code elimination pass before returning
 	 * error, so that invalid calls that get pruned out can be in BPF programs
@@ -3478,11 +3480,6 @@ static void sort_kfunc_descs_by_imm_off(struct bpf_prog *prog)
 	     kfunc_desc_cmp_by_imm_off, NULL);
 }
 
-bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
-{
-	return !!prog->aux->kfunc_tab;
-}
-
 const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn)
@@ -22420,7 +22417,6 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	struct bpf_prog *prog = env->prog;
 	struct bpf_insn *insn = prog->insnsi;
-	bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
 	int i, depth;
 #endif
 	int err = 0;
@@ -22434,8 +22430,8 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 			return err;
 	}
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-	if (has_kfunc_call) {
-		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
+	if (prog->jit_required) {
+		verbose(env, "program requires BPF JIT compiler but it is not available\n");
 		return -EINVAL;
 	}
 	if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {
-- 
2.55.0

