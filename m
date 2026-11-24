Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537252;
	b=t59bRGBz964XxVz45hPl1aKiYbC1JqgTES4NGQYxs1wGpRjf+BV8jKIqfKwa8qvnGBUM
	 tl/cLjFGwFilTSgDp+s9A1IoWsdyrvNNXz/ZI7BS7sld8/UVFGDiC6L3Q2lwO0mjPVzGT
	 zbtbkNk34uVAZWXIP7eM5/PgMgoZk16rlZQWeXBEEfZiIa2RTZRYLJ3rupoV/m+uYmZ+0
	 Bd17aR8kjn9sDKZBIfm/Ina4K1FimFbQVOKRjy3Ndu1iDqPia/27y5Ox9MlPgky4/qL+T
	 dQ8/fVkrcmtAUx5H4K0hZqA2hYDJCckSb691qm8GFu4+jTNRMiMpeeuPWUVh6beIibQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537252;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L2c/BgDET731C8fHBHnCf9TkbEjoFcSFK32JbBRg9Mg=;
	b=4/+1N8x6qYL5Zd+ctANrdrJRIYo+oVN2NIY/gD5Efr4bCWAWg/0kU3DvfskFr1H+LK8W
	 7jGwpPBy4ZfQA77hi+JpoTSUWJ5BZklm5EhXsXXhTlh4sR7SZJ0vVY7i3QmpXfVI+/OI+
	 nsaSkxUhXFv4N7NTvMoobBKASLM4+n/WUWO66OoYZnJ8z6dJiakf9m1cnBlhr0SesyRLG
	 jZBImNdhI0kRLK47AVjCtkrIWqyh7UnKFa/Emqtm5CeMN4LAZzfSQYshwfRAjDwdqJlOq
	 tKqLvYApw3lVWfEirjrG3cccisjF4hEfKCb3WoS3uy96UOco8FEu9Df9HhKRXBJ9ttw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVYw5pVr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA27606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVYw5pVr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43C61F000CF;
	Tue, 24 Nov 2026 16:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795537252;
	bh=L2c/BgDET731C8fHBHnCf9TkbEjoFcSFK32JbBRg9Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OVYw5pVrPe65oAus3lxcWQL0KfvnvGYIS1JVQutyqYkb5/0ZI9+rb/NA+SRQ8O6Zj
	 GeGxqTh/2Q2o68hBSO0qRbLyqCdJGFwC6ixv3skj5b0WpkvRnuKUIlWdVvuKAja8kn
	 bMjsilzqFTdif6eYpxl28fQKA5QzpO5DSJv1jgSYX3S97TsdflaDxuEHzcjyWUGQjg
	 ejUyrog+awVCFhBM17bFTvjL2/HupB+boyQcbsQro4e/KiFW8ToQrnqXzbnONdbRys
	 Qby64AYtWzq4ERC8T7xPuOfzCr5csSOvDlBtYuWQj5LilRfm8CTiJNTtX67bmiBxbM
	 N4wbcDhkESQdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] kprobes: Adopt guard() and scoped_guard()
Date: Tue, 24 Nov 2026 11:20:49 -0500
Message-ID: <20261124162040.947082-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112410-hurried-barbell-533d@gregkh>
References: <2026112410-hurried-barbell-533d@gregkh>
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

[ Upstream commit 587e8e6d640bcf89a4bf29745a3c3fdfe8379ae0 ]

Use guard() or scoped_guard() for critical sections rather than
discrete lock/unlock pairs.

Link: https://lore.kernel.org/all/173289887835.73724.608223217359025939.stgit@devnote2/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: a553b499f22b ("kprobes: Validate re-registration earlier in register_kretprobe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 205 ++++++++++++++++++++---------------------------
 1 file changed, 89 insertions(+), 116 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 58c04d6d1b375..7b3fe9307fb1a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -144,10 +144,9 @@ static int collect_garbage_slots(struct kprobe_insn_cache *c);
 kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 {
 	struct kprobe_insn_page *kip;
-	kprobe_opcode_t *slot = NULL;
 
 	/* Since the slot array is not protected by rcu, we need a mutex */
-	mutex_lock(&c->mutex);
+	guard(mutex)(&c->mutex);
  retry:
 	rcu_read_lock();
 	list_for_each_entry_rcu(kip, &c->pages, list) {
@@ -158,9 +157,8 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 				if (kip->slot_used[i] == SLOT_CLEAN) {
 					kip->slot_used[i] = SLOT_USED;
 					kip->nused++;
-					slot = kip->insns + (i * c->insn_size);
 					rcu_read_unlock();
-					goto out;
+					return kip->insns + (i * c->insn_size);
 				}
 			}
 			/* kip->nused is broken. Fix it. */
@@ -177,12 +175,12 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	/* All out of space.  Need to allocate a new page. */
 	kip = kmalloc(KPROBE_INSN_PAGE_SIZE(slots_per_page(c)), GFP_KERNEL);
 	if (!kip)
-		goto out;
+		return NULL;
 
 	kip->insns = c->alloc();
 	if (!kip->insns) {
 		kfree(kip);
-		goto out;
+		return NULL;
 	}
 	INIT_LIST_HEAD(&kip->list);
 	memset(kip->slot_used, SLOT_CLEAN, slots_per_page(c));
@@ -191,14 +189,12 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	kip->ngarbage = 0;
 	kip->cache = c;
 	list_add_rcu(&kip->list, &c->pages);
-	slot = kip->insns;
 
 	/* Record the perf ksymbol register event after adding the page */
 	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL, (unsigned long)kip->insns,
 			   PAGE_SIZE, false, c->sym);
-out:
-	mutex_unlock(&c->mutex);
-	return slot;
+
+	return kip->insns;
 }
 
 /* Return true if all garbages are collected, otherwise false. */
@@ -259,7 +255,7 @@ void __free_insn_slot(struct kprobe_insn_cache *c,
 	struct kprobe_insn_page *kip;
 	long idx;
 
-	mutex_lock(&c->mutex);
+	guard(mutex)(&c->mutex);
 	rcu_read_lock();
 	list_for_each_entry_rcu(kip, &c->pages, list) {
 		idx = ((long)slot - (long)kip->insns) /
@@ -285,7 +281,6 @@ void __free_insn_slot(struct kprobe_insn_cache *c,
 			collect_one_slot(kip, idx);
 		}
 	}
-	mutex_unlock(&c->mutex);
 }
 
 /*
@@ -643,10 +638,9 @@ static void kprobe_optimizer(struct work_struct *work)
 	mutex_unlock(&kprobe_mutex);
 }
 
-/* Wait for completing optimization and unoptimization */
-void wait_for_kprobe_optimizer(void)
+static void wait_for_kprobe_optimizer_locked(void)
 {
-	mutex_lock(&kprobe_mutex);
+	lockdep_assert_held(&kprobe_mutex);
 
 	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
 		mutex_unlock(&kprobe_mutex);
@@ -658,8 +652,14 @@ void wait_for_kprobe_optimizer(void)
 
 		mutex_lock(&kprobe_mutex);
 	}
+}
 
-	mutex_unlock(&kprobe_mutex);
+/* Wait for completing optimization and unoptimization */
+void wait_for_kprobe_optimizer(void)
+{
+	guard(mutex)(&kprobe_mutex);
+
+	wait_for_kprobe_optimizer_locked();
 }
 
 bool optprobe_queued_unopt(struct optimized_kprobe *op)
@@ -889,10 +889,10 @@ static void optimize_all_kprobes(void)
 	struct kprobe *p;
 	unsigned int i;
 
-	mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
 	/* If optimization is already allowed, just return. */
 	if (kprobes_allow_optimization)
-		goto out;
+		return;
 
 	cpus_read_lock();
 	kprobes_allow_optimization = true;
@@ -904,8 +904,6 @@ static void optimize_all_kprobes(void)
 	}
 	cpus_read_unlock();
 	pr_info("kprobe jump-optimization is enabled. All kprobes are optimized if possible.\n");
-out:
-	mutex_unlock(&kprobe_mutex);
 }
 
 #ifdef CONFIG_SYSCTL
@@ -915,12 +913,10 @@ static void unoptimize_all_kprobes(void)
 	struct kprobe *p;
 	unsigned int i;
 
-	mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
 	/* If optimization is already prohibited, just return. */
-	if (!kprobes_allow_optimization) {
-		mutex_unlock(&kprobe_mutex);
+	if (!kprobes_allow_optimization)
 		return;
-	}
 
 	cpus_read_lock();
 	kprobes_allow_optimization = false;
@@ -932,10 +928,8 @@ static void unoptimize_all_kprobes(void)
 		}
 	}
 	cpus_read_unlock();
-	mutex_unlock(&kprobe_mutex);
-
 	/* Wait for unoptimizing completion. */
-	wait_for_kprobe_optimizer();
+	wait_for_kprobe_optimizer_locked();
 	pr_info("kprobe jump-optimization is disabled. All kprobes are based on software breakpoint.\n");
 }
 
@@ -947,7 +941,7 @@ static int proc_kprobes_optimization_handler(struct ctl_table *table,
 {
 	int ret;
 
-	mutex_lock(&kprobe_sysctl_mutex);
+	guard(mutex)(&kprobe_sysctl_mutex);
 	sysctl_kprobes_optimization = kprobes_allow_optimization ? 1 : 0;
 	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
 
@@ -955,7 +949,6 @@ static int proc_kprobes_optimization_handler(struct ctl_table *table,
 		optimize_all_kprobes();
 	else
 		unoptimize_all_kprobes();
-	mutex_unlock(&kprobe_sysctl_mutex);
 
 	return ret;
 }
@@ -1031,7 +1024,8 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
 #define __arm_kprobe(p)				arch_arm_kprobe(p)
 #define __disarm_kprobe(p, o)			arch_disarm_kprobe(p)
 #define kprobe_disarmed(p)			kprobe_disabled(p)
-#define wait_for_kprobe_optimizer()		do {} while (0)
+#define wait_for_kprobe_optimizer_locked()			\
+	lockdep_assert_held(&kprobe_mutex)
 
 static int reuse_unused_kprobe(struct kprobe *ap)
 {
@@ -1492,6 +1486,7 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
 static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
 {
 	bool on_func_entry;
+
 	return _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
 }
 
@@ -1526,14 +1521,12 @@ static struct kprobe *__get_valid_kprobe(struct kprobe *p)
  */
 static inline int warn_kprobe_rereg(struct kprobe *p)
 {
-	int ret = 0;
+	guard(mutex)(&kprobe_mutex);
 
-	mutex_lock(&kprobe_mutex);
 	if (WARN_ON_ONCE(__get_valid_kprobe(p)))
-		ret = -EINVAL;
-	mutex_unlock(&kprobe_mutex);
+		return -EINVAL;
 
-	return ret;
+	return 0;
 }
 
 static int check_ftrace_location(struct kprobe *p)
@@ -1621,44 +1614,17 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	return ret;
 }
 
-int register_kprobe(struct kprobe *p)
+static int __register_kprobe(struct kprobe *p)
 {
 	int ret;
 	struct kprobe *old_p;
-	struct module *probed_mod;
-	kprobe_opcode_t *addr;
-	bool on_func_entry;
-
-	/* Adjust probe address from symbol */
-	addr = _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
-	if (IS_ERR(addr))
-		return PTR_ERR(addr);
-	p->addr = addr;
-
-	ret = warn_kprobe_rereg(p);
-	if (ret)
-		return ret;
 
-	/* User can pass only KPROBE_FLAG_DISABLED to register_kprobe */
-	p->flags &= KPROBE_FLAG_DISABLED;
-	p->nmissed = 0;
-	INIT_LIST_HEAD(&p->list);
-
-	ret = check_kprobe_address_safe(p, &probed_mod);
-	if (ret)
-		return ret;
-
-	mutex_lock(&kprobe_mutex);
-
-	if (on_func_entry)
-		p->flags |= KPROBE_FLAG_ON_FUNC_ENTRY;
+	guard(mutex)(&kprobe_mutex);
 
 	old_p = get_kprobe(p->addr);
-	if (old_p) {
+	if (old_p)
 		/* Since this may unoptimize 'old_p', locking 'text_mutex'. */
-		ret = register_aggr_kprobe(old_p, p);
-		goto out;
-	}
+		return register_aggr_kprobe(old_p, p);
 
 	cpus_read_lock();
 	/* Prevent text modification */
@@ -1667,7 +1633,7 @@ int register_kprobe(struct kprobe *p)
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
 	if (ret)
-		goto out;
+		return ret;
 
 	INIT_HLIST_NODE(&p->hlist);
 	hlist_add_head_rcu(&p->hlist,
@@ -1678,14 +1644,43 @@ int register_kprobe(struct kprobe *p)
 		if (ret) {
 			hlist_del_rcu(&p->hlist);
 			synchronize_rcu();
-			goto out;
 		}
 	}
 
 	/* Try to optimize kprobe */
 	try_to_optimize_kprobe(p);
-out:
-	mutex_unlock(&kprobe_mutex);
+	return 0;
+}
+
+int register_kprobe(struct kprobe *p)
+{
+	int ret;
+	struct module *probed_mod;
+	kprobe_opcode_t *addr;
+	bool on_func_entry;
+
+	/* Canonicalize probe address from symbol */
+	addr = _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
+	p->addr = addr;
+
+	ret = warn_kprobe_rereg(p);
+	if (ret)
+		return ret;
+
+	/* User can pass only KPROBE_FLAG_DISABLED to register_kprobe */
+	p->flags &= KPROBE_FLAG_DISABLED;
+	if (on_func_entry)
+		p->flags |= KPROBE_FLAG_ON_FUNC_ENTRY;
+	p->nmissed = 0;
+	INIT_LIST_HEAD(&p->list);
+
+	ret = check_kprobe_address_safe(p, &probed_mod);
+	if (ret)
+		return ret;
+
+	ret = __register_kprobe(p);
 
 	if (probed_mod)
 		module_put(probed_mod);
@@ -1860,12 +1855,11 @@ void unregister_kprobes(struct kprobe **kps, int num)
 
 	if (num <= 0)
 		return;
-	mutex_lock(&kprobe_mutex);
-	for (i = 0; i < num; i++)
-		if (__unregister_kprobe_top(kps[i]) < 0)
-			kps[i]->addr = NULL;
-	mutex_unlock(&kprobe_mutex);
-
+	scoped_guard(mutex, &kprobe_mutex) {
+		for (i = 0; i < num; i++)
+			if (__unregister_kprobe_top(kps[i]) < 0)
+				kps[i]->addr = NULL;
+	}
 	synchronize_rcu();
 	for (i = 0; i < num; i++)
 		if (kps[i]->addr)
@@ -2318,8 +2312,9 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 
 	if (num <= 0)
 		return;
-	mutex_lock(&kprobe_mutex);
 	for (i = 0; i < num; i++) {
+		guard(mutex)(&kprobe_mutex);
+
 		if (__unregister_kprobe_top(&rps[i]->kp) < 0)
 			rps[i]->kp.addr = NULL;
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
@@ -2328,7 +2323,6 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 		rcu_assign_pointer(rps[i]->rph->rp, NULL);
 #endif
 	}
-	mutex_unlock(&kprobe_mutex);
 
 	synchronize_rcu();
 	for (i = 0; i < num; i++) {
@@ -2409,18 +2403,14 @@ static void kill_kprobe(struct kprobe *p)
 /* Disable one kprobe */
 int disable_kprobe(struct kprobe *kp)
 {
-	int ret = 0;
 	struct kprobe *p;
 
-	mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
 
 	/* Disable this kprobe */
 	p = __disable_kprobe(kp);
-	if (IS_ERR(p))
-		ret = PTR_ERR(p);
 
-	mutex_unlock(&kprobe_mutex);
-	return ret;
+	return IS_ERR(p) ? PTR_ERR(p) : 0;
 }
 EXPORT_SYMBOL_GPL(disable_kprobe);
 
@@ -2430,20 +2420,16 @@ int enable_kprobe(struct kprobe *kp)
 	int ret = 0;
 	struct kprobe *p;
 
-	mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
 
 	/* Check whether specified probe is valid. */
 	p = __get_valid_kprobe(kp);
-	if (unlikely(p == NULL)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (unlikely(p == NULL))
+		return -EINVAL;
 
-	if (kprobe_gone(kp)) {
+	if (kprobe_gone(kp))
 		/* This kprobe has gone, we couldn't enable it. */
-		ret = -EINVAL;
-		goto out;
-	}
+		return -EINVAL;
 
 	if (p != kp)
 		kp->flags &= ~KPROBE_FLAG_DISABLED;
@@ -2457,8 +2443,6 @@ int enable_kprobe(struct kprobe *kp)
 				kp->flags |= KPROBE_FLAG_DISABLED;
 		}
 	}
-out:
-	mutex_unlock(&kprobe_mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(enable_kprobe);
@@ -2645,11 +2629,11 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	unsigned int i;
 	int checkcore = (val == MODULE_STATE_GOING);
 
-	if (val == MODULE_STATE_COMING) {
-		mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
+
+	if (val == MODULE_STATE_COMING)
 		add_module_kprobe_blacklist(mod);
-		mutex_unlock(&kprobe_mutex);
-	}
+
 	if (val != MODULE_STATE_GOING && val != MODULE_STATE_LIVE)
 		return NOTIFY_DONE;
 
@@ -2659,7 +2643,6 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	 * notified, only '.init.text' section would be freed. We need to
 	 * disable kprobes which have been inserted in the sections.
 	 */
-	mutex_lock(&kprobe_mutex);
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
 		hlist_for_each_entry(p, head, hlist)
@@ -2682,7 +2665,6 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	}
 	if (val == MODULE_STATE_GOING)
 		remove_module_kprobe_blacklist(mod);
-	mutex_unlock(&kprobe_mutex);
 	return NOTIFY_DONE;
 }
 
@@ -2699,7 +2681,7 @@ void kprobe_free_init_mem(void)
 	struct kprobe *p;
 	int i;
 
-	mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
 
 	/* Kill all kprobes on initmem because the target code has been freed. */
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
@@ -2709,8 +2691,6 @@ void kprobe_free_init_mem(void)
 				kill_kprobe(p);
 		}
 	}
-
-	mutex_unlock(&kprobe_mutex);
 }
 
 static int __init init_kprobes(void)
@@ -2906,11 +2886,11 @@ static int arm_all_kprobes(void)
 	unsigned int i, total = 0, errors = 0;
 	int err, ret = 0;
 
-	mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
 
 	/* If kprobes are armed, just return */
 	if (!kprobes_all_disarmed)
-		goto already_enabled;
+		return 0;
 
 	/*
 	 * optimize_kprobe() called by arm_kprobe() checks
@@ -2940,8 +2920,6 @@ static int arm_all_kprobes(void)
 	else
 		pr_info("Kprobes globally enabled\n");
 
-already_enabled:
-	mutex_unlock(&kprobe_mutex);
 	return ret;
 }
 
@@ -2952,13 +2930,11 @@ static int disarm_all_kprobes(void)
 	unsigned int i, total = 0, errors = 0;
 	int err, ret = 0;
 
-	mutex_lock(&kprobe_mutex);
+	guard(mutex)(&kprobe_mutex);
 
 	/* If kprobes are already disarmed, just return */
-	if (kprobes_all_disarmed) {
-		mutex_unlock(&kprobe_mutex);
+	if (kprobes_all_disarmed)
 		return 0;
-	}
 
 	kprobes_all_disarmed = true;
 
@@ -2983,11 +2959,8 @@ static int disarm_all_kprobes(void)
 	else
 		pr_info("Kprobes globally disabled\n");
 
-	mutex_unlock(&kprobe_mutex);
-
 	/* Wait for disarming all kprobes by optimizer */
-	wait_for_kprobe_optimizer();
-
+	wait_for_kprobe_optimizer_locked();
 	return ret;
 }
 
-- 
2.53.0

