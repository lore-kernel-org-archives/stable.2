Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707019;
	b=4nmIrp+K/IkFkDnQ+Y1wkHf+10OfzKqFUkIFhx9OWI1ghMfDQFhC3GpxhVyLvpTI9NyG
	 fkBs8/bTIRMQ4dp8wrI2z+bjTZkPnNG8stCWLFa+F0NmuDwAYrSU6AS7GDTiVixKMM311
	 SNWcHpWvpCQJdbG0wWZxF80NHAUrZZyAZOjlkUapqxSmdCbPOYCKJljyIWv2BCBVvNLlk
	 T+cqWSyIoxQYSHswsnUMuGD5tlpeGu5k4aLsTY6xCrSYDsnvq9u5UNQtjqLSJJMSlQvtT
	 xWWqjhl+jDRZFvOgIE5s2zEqBdPnDUXWATeYUfgl558QzaMuv6MVkN7i6J7fPt6ptIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707019;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j1wEUgRHOMt1lzx3ATdVUSt4N7lhwZheqjkl8TJ4K/M=;
	b=jgSytN9ROSe6Q8PJnIRhjjhnJUUvo4+R9khXE8QebCrsccfp/PvmzBvQqJzC05uVXOQj
	 B6JqHoD2OhaQv0b/jNHwa4fkHuyPOAQZRj+aZuVytUYhjbodmrOjPPTrrtBNaglfWZDKv
	 MAzI3lyCZJ73zKul8OiXHHooe7xWUh9coONWpOtl5UYDpainsAbiwcFfGu/GfYzC4GHv1
	 hTGpSyuB5Laue3bZBPLZLQw+YCsf3eV2j3Qco4vwOzcTDXSy0KTr6pK1AFNATRUtmo4ZS
	 AcYs43mTZTpW9FDf1TxS2C6V+/yvYXc76NVgNxvcpuLFpCobZvGYZRXUsxYepwyJBgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Xft87DKA;
	arc=none smtp.remote-ip=95.215.58.180
Received: from mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC370606A32C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC370606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Xft87DKA
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6ySozJ5Q5Zruo2czzzDALNozKUXg+IBeO4fucNOJgQg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795707016; v=1; x=1796311816;
 b=Xft87DKA14btX8V0W0k4VXEntslz8umdDXtjNRVmxsKGE+bWrmLuhpreQZ2U0B1S07ITErJ6
 HOlVCB2fMdMoJsyuXJJFMXa+DnRZVMcxMJblKCNxisk0GgQxRO1Hb5ETwcVHJPrlhxGJOjWDSXm
 YhmyCbdv/C96EaFRYkA7COBI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4ae66caffb760c9d;
	Thu, 26 Nov 2026 15:30:15 +0000
X-Mizu-Trace-ID: 4ae66caffb760c9d
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	KaFai Wan <kafai.wan@linux.dev>,
	Leon Hwang <leon.hwang@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH linux-6.12.y 1/4] bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()
Date: Thu, 26 Nov 2026 15:29:59 +0000
Message-ID: <20261126153002.162337-2-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126153002.162337-1-leon.hwang@linux.dev>
References: <20261126153002.162337-1-leon.hwang@linux.dev>
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
index f43aa1cd1b0b..d4a9108594bf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1585,8 +1585,9 @@ struct bpf_prog_aux {
 
 struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
-	u16			jited:1,	/* Is our filter JIT'ed? */
+	u32			jited:1,	/* Is our filter JIT'ed? */
 				jit_requested:1,/* archs need to JIT the prog */
+				jit_required:1, /* program strictly requires JIT compiler */
 				gpl_compatible:1, /* Is filter GPL compatible? */
 				cb_access:1,	/* Is control block accessed? */
 				dst_needed:1,	/* Do we need dst entry? */
@@ -2682,7 +2683,6 @@ const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id,
 						 const struct bpf_prog *prog);
 void bpf_task_storage_free(struct task_struct *task);
 void bpf_cgrp_storage_free(struct cgroup *cgroup);
-bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
 const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn);
@@ -2951,11 +2951,6 @@ static inline void bpf_task_storage_free(struct task_struct *task)
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
index 6bc3dc998ae1..6dce9b4cf0df 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -122,6 +122,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	fp->aux = aux;
 	fp->aux->prog = fp;
 	fp->jit_requested = ebpf_jit_enabled();
+	fp->jit_required = IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON);
 	fp->blinding_requested = bpf_jit_blinding_enabled(fp);
 #ifdef CONFIG_CGROUP_BPF
 	aux->cgroup_atype = CGROUP_BPF_ATTACH_TYPE_INVALID;
@@ -2529,15 +2530,11 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
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
index ecd8595bd545..a9fe21072c0a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2961,6 +2961,8 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		prog_aux->kfunc_tab = tab;
 	}
 
+	env->prog->jit_required = 1;
+
 	/* func_id == 0 is always invalid, but instead of returning an error, be
 	 * conservative and wait until the code elimination pass before returning
 	 * error, so that invalid calls that get pruned out can be in BPF programs
@@ -3069,11 +3071,6 @@ static void sort_kfunc_descs_by_imm_off(struct bpf_prog *prog)
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
@@ -20860,7 +20857,6 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	struct bpf_prog *prog = env->prog;
 	struct bpf_insn *insn = prog->insnsi;
-	bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
 	int i, depth;
 #endif
 	int err = 0;
@@ -20874,8 +20870,8 @@ static int fixup_call_args(struct bpf_verifier_env *env)
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

