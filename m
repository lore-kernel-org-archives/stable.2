Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF441F5C7
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813961; cv=none; b=hFWLN6E98awDuqSRfwbrQMHM70kk6PVEN3ck/58HrQ+HApypsYUnVpk1/0zmT4dKef8FxH5vnpTM5DtcBt9zcYN+VVPAhX4stCtYL0+TScaXRezsHjDB4tLvW8CpVVIbjOPbdxP8f8mk6mPMYLoTIYSLxdyNjsbmTpZ/hMgIFoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813961; c=relaxed/simple;
	bh=nr6YyTdrEMo8WW9457MiE3TsUqLTYEmBOS+kIga2T4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSvP70WWfHcDs2iYSF+71Uwlya0BmYh07ZqL60Ahf4XCK2zyvbt0zlDoGJO1/One011pjVSbYGDXfxUsSRJ6AhmXJKvg4Z6wdRM0Rgj1II3P/IaJOsq2TSN0CWxJ4xz9/RbW2tOxwFOwmjTmss4Ba+2xYfwepQVN/dEawduIQ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaLBH8Fq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaLBH8Fq"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4207ac26so1880657f8f.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791813958; x=1792418758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zjkc2adj3Sed7+w6aDc9GLvouA9HNjLU3ES/VT0wXQQ=;
        b=RaLBH8FqlOfVf0Z/tP90h3Lkd48gObSGAY3oXLlP5WbcZmMqsSpqZDcI3YlDwmO1+B
         ANjskSmhH2tTzcdFCyYHmck2mg/o784PZ142juBGqF8T7hgOrcOalG7RL6RW4WKNFmYN
         6ta445LTTlieHoo6KJhXZFZvW2hhwmtw3gp5Z/53gEhswV6KSASYCjIm4WGIarSBvtCc
         PQtTKnsxc264k3WEVxhqD21m0M9EprClBb2ZOuXzr2oNgeU86NemrQLeD3eyFqfcx8DK
         yYMk9a5VBGtqpDNMO6GRGPd8VncEEB2FoKLA3nSnlKnpY8XYDfkVapUWpwfVjytYL+J2
         oxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791813958; x=1792418758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zjkc2adj3Sed7+w6aDc9GLvouA9HNjLU3ES/VT0wXQQ=;
        b=d46NPsU2Ll+MuvPIulGCJQYMXLWz2wMPv3nLPOttuXyJbs0ddtxpwApsUtXO8s68G4
         Qw8/H99g3UBcJr8pslTgg7U7OrbPfjajLNRvcu1eBjMHOCUD1qJnnJiAOEbsr214bS38
         qyXDEP9QoiEQP4CfA8UV/7/DB/bllmaz6OPr0bTXUjQ2e8oz3ZsJZ6XlqUYLqsqGYUA0
         yGTcnSa4ecqRGVyrr0KSj0ST2w9tHhdQzkmKKLNFcpTzk/aNbFDOi6Yjz9EnHLsxQSCf
         pRVhKdMkYQqDYt8gFENGFu2Z+4ONV9/8OscWW0yZzhZd4xQ78G2ybVWQFhEChN3ElIV6
         DEFg==
X-Forwarded-Encrypted: i=1; AKwUvBz7BMcrxEgo/WOETncgWQLz2qdkeQNCtDm5e181XY5aYLlRmHjS04UWULR7Cl1nraO5J5PTOvk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsI888L+BGaZeLioipAg8q1cFcQYn2D+yasz268DpYaRvdFhWv
	GKPsAJTpzbqYd96IaG6D2fF/2IFl0e+9B0F5ZBKYrvvHDOaSLhrd4tDu
X-Gm-Gg: AYBFou0rAYON1tMeM08wyIfqqUJQ5eY01/S01hqf7xH2JcjlGk7ZoN0ngapWzgk3f8v
	bJV5MEQ4UE/cRhJ3TE5anPfyUGMSXF7X5eqJ3xkiDC7AJ5K6IbsNfAN13yR9WS06Yq9pcAfPe86
	C5bOOnaCxVfJrVXdDijBBcVaR/nTJSRCa6K7MJ/XBKj9SA4k+6QVYeJI346MRHy8njouxHe5uxO
	0TuqzEpn5hiLp/5hY+0bT76QVAhy6+sazKTCU7PxKyfeVqNUmsNDIcDV+/5ve63ji4Put9wQkD+
	IT248GP3j98h3aLgAYelT0V6Fyncmq/5yX+dOmRoMstfaWv9Qbr1rcYMO/WLA7BRLwsKSenpb3I
	+yYEFNDykgywhhH2l6/4iMAiFZqfrR0ySypUQGjzMUUvtC80/LHd7tfA2B+vXVsdYhNRbV3jko2
	+ukH+Va3QTHswQtvlRORbm/Bwj2vzFRneyBsdBLXeH9BWclGlS6qeuAZWyzPkmh6lMv/d14GUJN
	ScWIQgMoYsmxdVp5N3byShCsmsU7OjTQjDGU6MhyAwxkgh2gsHhadw=
X-Received: by 2002:a05:6000:4687:b0:487:36b:1816 with SMTP id ffacd0b85a97d-48dba7877f0mr11913463f8f.7.1791813957452;
        Mon, 12 Oct 2026 07:05:57 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.59.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9abd574sm20304616f8f.34.2026.10.12.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:05:56 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] livepatch: Fix races between stack check and module load/unload
Date: Mon, 12 Oct 2026 16:05:45 +0200
Message-ID: <20261012140546.154730-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unloading a patched module while a livepatch transition is in progress
can crash the kernel in klp_find_ops(), called from the scheduler.
KCSAN reports

  BUG: KCSAN: data-race in klp_find_ops / klp_unpatch_func

  write (marked) to 0xffff9094c09ece10 of 8 bytes by task 381 on cpu 2:
   klp_unpatch_func+0x1bd/0x280
   klp_unpatch_object+0x6a/0x90
   klp_cleanup_module_patches_limited.cold+0x4a/0xd4
   klp_module_going+0x54/0x80
   __do_sys_delete_module+0x247/0x380
   __x64_sys_delete_module+0x39/0x50
   ...

  read to 0xffff9094c09ece10 of 8 bytes by task 146 on cpu 1:
   klp_find_ops+0x55/0x90
   klp_check_and_switch_task+0x228/0x320
   klp_try_switch_task+0xb4/0xc0
   __klp_sched_try_switch+0x9a/0xb0
   __schedule+0x60a/0x1450
   schedule+0x3b/0x100
   schedule_timeout+0xc0/0x160
   ra_target_a_loop+0x97/0xa0 [klp_race_target_a]
   ...

followed by

  Oops: general protection fault, probably for non-canonical address
  0xdead000000000110: 0000 [#2] SMP NOPTI
  RIP: 0010:klp_find_ops+0x55/0x90
   ...
   klp_check_and_switch_task+0x228/0x320
   klp_try_switch_task+0xb4/0xc0
   __klp_sched_try_switch+0x9a/0xb0
   __schedule+0x60a/0x1450

0xdead000000000110 is LIST_POISON1 (0xdead000000000100) plus the offset
of func_stack in struct klp_ops.

klp_check_stack_func() walks the global klp_ops list in klp_find_ops().
It is reached from the scheduler through __klp_sched_try_switch() ->
klp_try_switch_task() -> klp_check_stack() without klp_mutex, while
klp_patch_func() and klp_unpatch_func() add, remove and free klp_ops
entries under klp_mutex when a to-be-patched module is loaded or
unloaded:

  CPU 1                                 CPU 2
  __schedule()                          delete_module()
    klp_check_stack_func()                klp_module_going()
      klp_find_ops()                        klp_unpatch_func()
        pos = ops
                                              list_del(&ops->node)
                                              kfree(ops)
        pos = ops->node.next  /* LIST_POISON1 */
        pos->func_stack.next  /* oops */

Fix it by RCU protecting the klp_ops list.  klp_find_ops() uses
list_for_each_entry_rcu() and list_first_or_null_rcu(), klp_patch_func()
publishes a new ops with list_add_rcu() only after its func_stack has
been initialized, and klp_unpatch_func() and the klp_patch_func() error
path free it with kfree_rcu() after list_del_rcu().

klp_check_stack() takes the RCU read lock around the walk to make the
dependency explicit.  It already runs with preemption disabled and with
RCU watching, so the grace period used by kfree_rcu() covers the reader.

If klp_find_ops() no longer finds the ops, the function is not
redirected anymore and klp_check_stack_func() has nothing to check.

Unload also unpatches the transition patch, so a found func_stack can
shrink, even unlinking func itself, and list_is_singular() and
list_next_entry() then pick a bogus klp_func.  Use
list_next_or_null_rcu() and treat NULL as the original function.

klp_free_object_loaded() then clears func->old_func, and new_func of NOP
functions, without waiting for readers.  Mark these accesses with
READ_ONCE() and WRITE_ONCE().  A NULL new_func matches no stack entry,
and a NULL old_func is skipped, as the lookup could otherwise match
another removed entry.

A reload during the transition needs ordering too.
func->stack_node.next is read through func, not through the ops found
under RCU, so a task that sees obj->patched set can read a stale value:
func's own node from INIT_LIST_HEAD() on the first load, or what
list_del_rcu() left at the last unload, such as a freed ops head.

The first makes klp_check_stack_func() check func->new_func instead of
the original function, so a task sleeping in the original function
could be switched.  The second can read new_func and new_size from
freed memory.  Publish obj->patched with smp_store_release() in
klp_patch_object() and read it with smp_load_acquire() in
klp_check_stack().

Clearing obj->patched needs no ordering, since a task that still sees
it set is handled by the RCU lookup, and the synchronize_rcu() in the
unload path waits for the walk before the module can be loaded again.
patched_show() reads obj->patched for sysfs output only, so mark that
read with data_race().

The load-side ordering was found by code inspection and has not been
reproduced: the reproducer runs on x86, where neither the CPU nor, given
the barriers in between, the compiler reorders these loads.

Fixes: e3ff7c609f39 ("livepatch,sched: Add livepatch task switching to cond_resched()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
Tested on x86_64 in a 4-CPU vng guest with CONFIG_KCSAN_STRICT=y, with
and without CONFIG_PROVE_LOCKING=y and CONFIG_PROVE_RCU_LIST=y.  A
livepatch transition is kept in progress while a patched module is
unloaded and reloaded for 30 minutes (about 370 reloads).  No KCSAN
report involves livepatch code, and lockdep and RCU stay silent.  On a
kernel without this patch, the same reproducer faults in klp_find_ops()
as shown above.

 kernel/livepatch/core.c       |  8 +++++---
 kernel/livepatch/patch.c      | 33 ++++++++++++++++++++------------
 kernel/livepatch/patch.h      |  2 ++
 kernel/livepatch/transition.c | 36 +++++++++++++++++++++++++++--------
 4 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index a240d1144e89c..ccae5cc5169b6 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -499,7 +499,8 @@ static ssize_t patched_show(struct kobject *kobj,
 	struct klp_object *obj;
 
 	obj = container_of(kobj, struct klp_object, kobj);
-	return sysfs_emit(buf, "%d\n", obj->patched);
+	/* Racy without klp_mutex, but only reported to user space. */
+	return sysfs_emit(buf, "%d\n", data_race(obj->patched));
 }
 
 static struct kobj_attribute patched_kobj_attr = __ATTR_RO(patched);
@@ -696,10 +697,11 @@ static void klp_free_object_loaded(struct klp_object *obj)
 	obj->mod = NULL;
 
 	klp_for_each_func(obj, func) {
-		func->old_func = NULL;
+		/* Read without klp_mutex, see klp_check_stack_func(). */
+		WRITE_ONCE(func->old_func, NULL);
 
 		if (func->nop)
-			func->new_func = NULL;
+			WRITE_ONCE(func->new_func, NULL);
 	}
 }
 
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 3f54a017bbf69..d01ec7a6256ab 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -22,15 +22,19 @@
 
 static LIST_HEAD(klp_ops);
 
+/*
+ * Caller must hold klp_mutex or rcu_read_lock(): klp_check_stack_func() walks
+ * klp_ops from the scheduler without klp_mutex.
+ */
 struct klp_ops *klp_find_ops(void *old_func)
 {
 	struct klp_ops *ops;
 	struct klp_func *func;
 
-	list_for_each_entry(ops, &klp_ops, node) {
-		func = list_first_entry(&ops->func_stack, struct klp_func,
-					stack_node);
-		if (func->old_func == old_func)
+	list_for_each_entry_rcu(ops, &klp_ops, node, lockdep_is_held(&klp_mutex)) {
+		func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
+					      stack_node);
+		if (func && READ_ONCE(func->old_func) == old_func)
 			return ops;
 	}
 
@@ -148,8 +152,8 @@ static void klp_unpatch_func(struct klp_func *func)
 		WARN_ON(ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0));
 
 		list_del_rcu(&func->stack_node);
-		list_del(&ops->node);
-		kfree(ops);
+		list_del_rcu(&ops->node);
+		kfree_rcu(ops, rcu_head);
 	} else {
 		list_del_rcu(&func->stack_node);
 	}
@@ -191,10 +195,9 @@ static int klp_patch_func(struct klp_func *func)
 				  FTRACE_OPS_FL_IPMODIFY |
 				  FTRACE_OPS_FL_PERMANENT;
 
-		list_add(&ops->node, &klp_ops);
-
 		INIT_LIST_HEAD(&ops->func_stack);
 		list_add_rcu(&func->stack_node, &ops->func_stack);
+		list_add_rcu(&ops->node, &klp_ops);
 
 		ret = ftrace_set_filter_ip(&ops->fops, ftrace_loc, 0, 0);
 		if (ret) {
@@ -222,8 +225,8 @@ static int klp_patch_func(struct klp_func *func)
 
 err:
 	list_del_rcu(&func->stack_node);
-	list_del(&ops->node);
-	kfree(ops);
+	list_del_rcu(&ops->node);
+	kfree_rcu(ops, rcu_head);
 	return ret;
 }
 
@@ -240,7 +243,7 @@ static void __klp_unpatch_object(struct klp_object *obj, bool nops_only)
 	}
 
 	if (obj->dynamic || !nops_only)
-		obj->patched = false;
+		WRITE_ONCE(obj->patched, false);
 }
 
 
@@ -264,7 +267,13 @@ int klp_patch_object(struct klp_object *obj)
 			return ret;
 		}
 	}
-	obj->patched = true;
+
+	/*
+	 * Pairs with smp_load_acquire() in klp_check_stack(): a task that sees
+	 * the object patched also sees the func_stack linkage and the
+	 * old_func/new_func addresses and sizes of all its funcs.
+	 */
+	smp_store_release(&obj->patched, true);
 
 	return 0;
 }
diff --git a/kernel/livepatch/patch.h b/kernel/livepatch/patch.h
index d5f2fbe373e05..20e8704daca53 100644
--- a/kernel/livepatch/patch.h
+++ b/kernel/livepatch/patch.h
@@ -17,11 +17,13 @@
  *
  * @node:	node for the global klp_ops list
  * @func_stack:	list head for the stack of klp_func's (active func is on top)
+ * @rcu_head:	used to free this structure with kfree_rcu()
  * @fops:	registered ftrace ops struct
  */
 struct klp_ops {
 	struct list_head node;
 	struct list_head func_stack;
+	struct rcu_head rcu_head;
 	struct ftrace_ops fops;
 };
 
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 2351a19ac2a9e..e9aa16baf1743 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/cpu.h>
+#include <linux/rculist.h>
 #include <linux/stacktrace.h>
 #include <linux/static_call.h>
 #include "core.h"
@@ -201,12 +202,16 @@ void klp_update_patch_state(struct task_struct *task)
 /*
  * Determine whether the given stack trace includes any references to a
  * to-be-patched or to-be-unpatched function.
+ *
+ * Must be called under rcu_read_lock(), see klp_check_stack().
  */
 static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
 				unsigned int nr_entries)
 {
 	unsigned long func_addr, func_size, address;
+	struct klp_func *prev;
 	struct klp_ops *ops;
+	void *old_func;
 	int i;
 
 	if (klp_target_state == KLP_TRANSITION_UNPATCHED) {
@@ -214,24 +219,35 @@ static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
 		  * Check for the to-be-unpatched function
 		  * (the func itself).
 		  */
-		func_addr = (unsigned long)func->new_func;
+		func_addr = (unsigned long)READ_ONCE(func->new_func);
 		func_size = func->new_size;
 	} else {
 		/*
 		 * Check for the to-be-patched function
 		 * (the previous func).
 		 */
-		ops = klp_find_ops(func->old_func);
+		old_func = READ_ONCE(func->old_func);
+		if (!old_func)
+			return 0;
+
+		ops = klp_find_ops(old_func);
 
-		if (list_is_singular(&ops->func_stack)) {
+		/*
+		 * The ops might have just been removed by a concurrent module
+		 * unload.  The function is not redirected anymore in that case.
+		 */
+		if (!ops)
+			return 0;
+
+		/* func_stack may shrink under us, even unlinking func itself. */
+		prev = list_next_or_null_rcu(&ops->func_stack, &func->stack_node,
+					     struct klp_func, stack_node);
+		if (!prev) {
 			/* original function */
-			func_addr = (unsigned long)func->old_func;
+			func_addr = (unsigned long)old_func;
 			func_size = func->old_size;
 		} else {
 			/* previously patched function */
-			struct klp_func *prev;
-
-			prev = list_next_entry(func, stack_node);
 			func_addr = (unsigned long)prev->new_func;
 			func_size = prev->new_size;
 		}
@@ -266,8 +282,12 @@ static int klp_check_stack(struct task_struct *task, const char **oldname)
 		return -EINVAL;
 	nr_entries = ret;
 
+	/* A concurrent module unload may free klp_ops, see klp_find_ops(). */
+	guard(rcu)();
+
 	klp_for_each_object(klp_transition_patch, obj) {
-		if (!obj->patched)
+		/* Pairs with smp_store_release() in klp_patch_object(). */
+		if (!smp_load_acquire(&obj->patched))
 			continue;
 		klp_for_each_func(obj, func) {
 			ret = klp_check_stack_func(func, entries, nr_entries);

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.53.0

