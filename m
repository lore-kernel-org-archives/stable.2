Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627961;
	b=gD8m57SvhB3OwxcIgSoteb9XCQhFQ4T9wPivrbeudO5BLNiFAUCre1OASfEHeRekbzv3
	 Ufh9AQHdV/BmdjuLmIRJonqbIJ7dVdVqjALUm/Iy6+U/n2Gb3eNQqQaJdd4YiKZnq7ruf
	 9soiWr1GMs9cgseL/we5puJ70Pgqgwsk5+aUl0KsFbfLLnQBnzvaOSXaUMP3HW2qQEqP3
	 XBJemgU8ewFsLB93U0D/jmFSjArah93EUC7RTpSmksU/MaEJRizYa0cs4loHOIAsoEmf0
	 SkhjCtAymz5bp8x7pRddXS5OAmVIOOXdZJbejsC/uKMfYOUANNT+or2CngVqCiE8dew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627961;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Tidparjpz0Jl24SvCxW/qb16QccyC13VvV0wDeZLfo0=;
	b=Z0GkAzHHqTY91tZoxIyQ7ixtClqxT9fGGT1kiOugFwsXacr2vJNREOH0odYhDJjSUiQ1
	 2D9VcxAzyrLBYbu2dzmAzm62wH3+vSpb1rHO669HYE8/IfbSTtxWHHTpTV9LkjuRdxkpl
	 bY9Rf7t0mP3pNboKzqC9Uq+EbBsc8ua2mY73CK6/FyEuaJk8A49a7qN+d5Fsvdl1nuYhB
	 5JJUUvOEzigfzKZa4uuf/BUKwlUdPaQ/cb4jKri+q7kC8/FKmqG+Wln1lq6GUwQ1DDa0J
	 RNCE702SKh7rNB/MNgb56UsxPf4ei9FsVf0H/cR+PeWmoXuYoiL14tjZ5ebEvBRXt6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jR1MutR5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA184606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jR1MutR5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80671F000CA;
	Wed, 25 Nov 2026 17:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795627961;
	bh=Tidparjpz0Jl24SvCxW/qb16QccyC13VvV0wDeZLfo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jR1MutR5CJCrSB5Z6b5JCNhE6DVvHVwnQlLXQQA1ClHMgru4SubDTt2UiDAPHSuk1
	 mbfsq2nrH1YY/xjCZDEmk8F97LLCbC4MxYNTQ83x1gZQie3szLzm3ODzxAcdfwkIey
	 +Km1SgbYZ3aJEsAfO1ml5mNZ99iIM7r/mJNrT1EbA1KTqa/tSdmueHiEcQ88vOj23T
	 nsyVlcXr7QLsijyPIVgDRxe08yhB0GnX/osqNmbhLXmdJFnX3/u4YpVuWRUZ7b+MHp
	 rZ928Y/l8fsvcBJIntYMNri9di1stgbS7gBA4y6teQicYlr2pWx7x1SRPyO+r5h8gI
	 b8kYiZOtppe3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] kprobes: Use guard() for external locks
Date: Wed, 25 Nov 2026 12:32:35 -0500
Message-ID: <20261125173227.966424-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125173227.966424-1-sashal@kernel.org>
References: <2026112527-vengeful-handrail-9419@gregkh>
 <20261125173227.966424-1-sashal@kernel.org>
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

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 54c79390119d24c1704202a64a997e1c99893b47 ]

Use guard() for text_mutex, cpu_read_lock, and jump_label_lock in
the kprobes.

Link: https://lore.kernel.org/all/173371208663.480397.7535769878667655223.stgit@devnote2/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: f60f98881b54 ("kprobes: Switch ftrace ops when adding probe with post_handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 209 ++++++++++++++++++++---------------------------
 1 file changed, 90 insertions(+), 119 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 5b36cc4bede0e..979ef378609f4 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -602,41 +602,38 @@ static void kick_kprobe_optimizer(void)
 /* Kprobe jump optimizer */
 static void kprobe_optimizer(struct work_struct *work)
 {
-	mutex_lock(&kprobe_mutex);
-	cpus_read_lock();
-	mutex_lock(&text_mutex);
+	guard(mutex)(&kprobe_mutex);
 
-	/*
-	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
-	 * kprobes before waiting for quiesence period.
-	 */
-	do_unoptimize_kprobes();
+	scoped_guard(cpus_read_lock) {
+		guard(mutex)(&text_mutex);
 
-	/*
-	 * Step 2: Wait for quiesence period to ensure all potentially
-	 * preempted tasks to have normally scheduled. Because optprobe
-	 * may modify multiple instructions, there is a chance that Nth
-	 * instruction is preempted. In that case, such tasks can return
-	 * to 2nd-Nth byte of jump instruction. This wait is for avoiding it.
-	 * Note that on non-preemptive kernel, this is transparently converted
-	 * to synchronoze_sched() to wait for all interrupts to have completed.
-	 */
-	synchronize_rcu_tasks();
+		/*
+		 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
+		 * kprobes before waiting for quiesence period.
+		 */
+		do_unoptimize_kprobes();
 
-	/* Step 3: Optimize kprobes after quiesence period */
-	do_optimize_kprobes();
+		/*
+		 * Step 2: Wait for quiesence period to ensure all potentially
+		 * preempted tasks to have normally scheduled. Because optprobe
+		 * may modify multiple instructions, there is a chance that Nth
+		 * instruction is preempted. In that case, such tasks can return
+		 * to 2nd-Nth byte of jump instruction. This wait is for avoiding it.
+		 * Note that on non-preemptive kernel, this is transparently converted
+		 * to synchronoze_sched() to wait for all interrupts to have completed.
+		 */
+		synchronize_rcu_tasks();
 
-	/* Step 4: Free cleaned kprobes after quiesence period */
-	do_free_cleaned_kprobes();
+		/* Step 3: Optimize kprobes after quiesence period */
+		do_optimize_kprobes();
 
-	mutex_unlock(&text_mutex);
-	cpus_read_unlock();
+		/* Step 4: Free cleaned kprobes after quiesence period */
+		do_free_cleaned_kprobes();
+	}
 
 	/* Step 5: Kick optimizer again if needed */
 	if (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list))
 		kick_kprobe_optimizer();
-
-	mutex_unlock(&kprobe_mutex);
 }
 
 static void wait_for_kprobe_optimizer_locked(void)
@@ -859,29 +856,24 @@ static void try_to_optimize_kprobe(struct kprobe *p)
 		return;
 
 	/* For preparing optimization, jump_label_text_reserved() is called. */
-	cpus_read_lock();
-	jump_label_lock();
-	mutex_lock(&text_mutex);
+	guard(cpus_read_lock)();
+	guard(jump_label_lock)();
+	guard(mutex)(&text_mutex);
 
 	ap = alloc_aggr_kprobe(p);
 	if (!ap)
-		goto out;
+		return;
 
 	op = container_of(ap, struct optimized_kprobe, kp);
 	if (!arch_prepared_optinsn(&op->optinsn)) {
 		/* If failed to setup optimizing, fallback to kprobe. */
 		arch_remove_optimized_kprobe(op);
 		kfree(op);
-		goto out;
+		return;
 	}
 
 	init_aggr_kprobe(ap, p);
 	optimize_kprobe(ap);	/* This just kicks optimizer thread. */
-
-out:
-	mutex_unlock(&text_mutex);
-	jump_label_unlock();
-	cpus_read_unlock();
 }
 
 static void optimize_all_kprobes(void)
@@ -1166,12 +1158,9 @@ static int arm_kprobe(struct kprobe *kp)
 	if (unlikely(kprobe_ftrace(kp)))
 		return arm_kprobe_ftrace(kp);
 
-	cpus_read_lock();
-	mutex_lock(&text_mutex);
+	guard(cpus_read_lock)();
+	guard(mutex)(&text_mutex);
 	__arm_kprobe(kp);
-	mutex_unlock(&text_mutex);
-	cpus_read_unlock();
-
 	return 0;
 }
 
@@ -1180,12 +1169,9 @@ static int disarm_kprobe(struct kprobe *kp, bool reopt)
 	if (unlikely(kprobe_ftrace(kp)))
 		return disarm_kprobe_ftrace(kp);
 
-	cpus_read_lock();
-	mutex_lock(&text_mutex);
+	guard(cpus_read_lock)();
+	guard(mutex)(&text_mutex);
 	__disarm_kprobe(kp, reopt);
-	mutex_unlock(&text_mutex);
-	cpus_read_unlock();
-
 	return 0;
 }
 
@@ -1302,62 +1288,55 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 	int ret = 0;
 	struct kprobe *ap = orig_p;
 
-	cpus_read_lock();
-
-	/* For preparing optimization, jump_label_text_reserved() is called */
-	jump_label_lock();
-	mutex_lock(&text_mutex);
-
-	if (!kprobe_aggrprobe(orig_p)) {
-		/* If 'orig_p' is not an 'aggr_kprobe', create new one. */
-		ap = alloc_aggr_kprobe(orig_p);
-		if (!ap) {
-			ret = -ENOMEM;
-			goto out;
+	scoped_guard(cpus_read_lock) {
+		/* For preparing optimization, jump_label_text_reserved() is called */
+		guard(jump_label_lock)();
+		guard(mutex)(&text_mutex);
+
+		if (!kprobe_aggrprobe(orig_p)) {
+			/* If 'orig_p' is not an 'aggr_kprobe', create new one. */
+			ap = alloc_aggr_kprobe(orig_p);
+			if (!ap)
+				return -ENOMEM;
+			init_aggr_kprobe(ap, orig_p);
+		} else if (kprobe_unused(ap)) {
+			/* This probe is going to die. Rescue it */
+			ret = reuse_unused_kprobe(ap);
+			if (ret)
+				return ret;
 		}
-		init_aggr_kprobe(ap, orig_p);
-	} else if (kprobe_unused(ap)) {
-		/* This probe is going to die. Rescue it */
-		ret = reuse_unused_kprobe(ap);
-		if (ret)
-			goto out;
-	}
 
-	if (kprobe_gone(ap)) {
-		/*
-		 * Attempting to insert new probe at the same location that
-		 * had a probe in the module vaddr area which already
-		 * freed. So, the instruction slot has already been
-		 * released. We need a new slot for the new probe.
-		 */
-		ret = arch_prepare_kprobe(ap);
-		if (ret)
+		if (kprobe_gone(ap)) {
 			/*
-			 * Even if fail to allocate new slot, don't need to
-			 * free the 'ap'. It will be used next time, or
-			 * freed by unregister_kprobe().
+			 * Attempting to insert new probe at the same location that
+			 * had a probe in the module vaddr area which already
+			 * freed. So, the instruction slot has already been
+			 * released. We need a new slot for the new probe.
 			 */
-			goto out;
+			ret = arch_prepare_kprobe(ap);
+			if (ret)
+				/*
+				 * Even if fail to allocate new slot, don't need to
+				 * free the 'ap'. It will be used next time, or
+				 * freed by unregister_kprobe().
+				 */
+				return ret;
 
-		/* Prepare optimized instructions if possible. */
-		prepare_optimized_kprobe(ap);
+			/* Prepare optimized instructions if possible. */
+			prepare_optimized_kprobe(ap);
 
-		/*
-		 * Clear gone flag to prevent allocating new slot again, and
-		 * set disabled flag because it is not armed yet.
-		 */
-		ap->flags = (ap->flags & ~KPROBE_FLAG_GONE)
-			    | KPROBE_FLAG_DISABLED;
-	}
-
-	/* Copy the insn slot of 'p' to 'ap'. */
-	copy_kprobe(ap, p);
-	ret = add_new_kprobe(ap, p);
+			/*
+			 * Clear gone flag to prevent allocating new slot again, and
+			 * set disabled flag because it is not armed yet.
+			 */
+			ap->flags = (ap->flags & ~KPROBE_FLAG_GONE)
+					| KPROBE_FLAG_DISABLED;
+		}
 
-out:
-	mutex_unlock(&text_mutex);
-	jump_label_unlock();
-	cpus_read_unlock();
+		/* Copy the insn slot of 'p' to 'ap'. */
+		copy_kprobe(ap, p);
+		ret = add_new_kprobe(ap, p);
+	}
 
 	if (ret == 0 && kprobe_disabled(ap) && !kprobe_disabled(p)) {
 		ap->flags &= ~KPROBE_FLAG_DISABLED;
@@ -1581,26 +1560,23 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	ret = check_ftrace_location(p);
 	if (ret)
 		return ret;
-	jump_label_lock();
+
+	guard(jump_label_lock)();
 
 	/* Ensure the address is in a text area, and find a module if exists. */
 	*probed_mod = NULL;
 	if (!core_kernel_text((unsigned long) p->addr)) {
 		guard(preempt)();
 		*probed_mod = __module_text_address((unsigned long) p->addr);
-		if (!(*probed_mod)) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!(*probed_mod))
+			return -EINVAL;
 
 		/*
 		 * We must hold a refcount of the probed module while updating
 		 * its code to prohibit unexpected unloading.
 		 */
-		if (unlikely(!try_module_get(*probed_mod))) {
-			ret = -ENOENT;
-			goto out;
-		}
+		if (unlikely(!try_module_get(*probed_mod)))
+			return -ENOENT;
 	}
 	/* Ensure it is not in reserved area. */
 	if (in_gate_area_no_mm((unsigned long) p->addr) ||
@@ -1610,8 +1586,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	    find_bug((unsigned long)p->addr) ||
 	    is_cfi_preamble_symbol((unsigned long)p->addr)) {
 		module_put(*probed_mod);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	/* Get module refcount and reject __init functions for loaded modules. */
@@ -1623,14 +1598,11 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		if (within_module_init((unsigned long)p->addr, *probed_mod) &&
 		    !module_is_coming(*probed_mod)) {
 			module_put(*probed_mod);
-			ret = -ENOENT;
+			return -ENOENT;
 		}
 	}
 
-out:
-	jump_label_unlock();
-
-	return ret;
+	return 0;
 }
 
 static int __register_kprobe(struct kprobe *p)
@@ -1645,14 +1617,13 @@ static int __register_kprobe(struct kprobe *p)
 		/* Since this may unoptimize 'old_p', locking 'text_mutex'. */
 		return register_aggr_kprobe(old_p, p);
 
-	cpus_read_lock();
-	/* Prevent text modification */
-	mutex_lock(&text_mutex);
-	ret = prepare_kprobe(p);
-	mutex_unlock(&text_mutex);
-	cpus_read_unlock();
-	if (ret)
-		return ret;
+	scoped_guard(cpus_read_lock) {
+		/* Prevent text modification */
+		guard(mutex)(&text_mutex);
+		ret = prepare_kprobe(p);
+		if (ret)
+			return ret;
+	}
 
 	INIT_HLIST_NODE(&p->hlist);
 	hlist_add_head_rcu(&p->hlist,
-- 
2.53.0

