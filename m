Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676691;
	b=uBNK80XBw2zUKYWLQYzpsvKESKXMD6LZHctYddxQfCzBB0D87mpNajh7WexxMChXQ55Y
	 o69RUrJez2c7OhAbD/j5nJU+GmzRh3f/xeh36ZSejCgzrRyJeDU31iKbfdWolP+a17Ou9
	 ALYrLmeCaSO49HAC2DhDcphk+K2fLof9IOFgVLiRFN3hOKOo0yu8GuuI97GjPt093FZ6A
	 V4RN/iRbp39yIxATMdn5qfxhv2+6iIkplBPrC1tw4zsACw4GiN6zcvQ0hoxLJd1SIjD0t
	 6H+D6XkG87r4SBBShkrtEQOobdqkbP2+y9AvTB2qtdRX3qN8TdhMCGhcG2KRS8AeQxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XYjNLtFTrAyQevnzj/0Kzgc6dPd+FZvsW6YZu/EQWok=;
	b=KwSKrf9xtiKqmpZ5UHeoDLG+NE0JA34RpU50JQEYf8+kj3OvdC0CXwE/l/m+UFKpqmhB
	 RSLKfT7tk9NOwgjKRgUQHdZFwc3QXoWhvmB5KKZIpUYnknFlaPUqPbnxs2/yOGgMt0Ebg
	 s8OPvyq+lTASP525CbR+vKAKKaxo+mdXl9v2Ry/kpwGD3T+zw4TjbT3DtZkgh4Rz0m/dD
	 LIWOl/NQVLjds9fH+diGKrb0qt0yRW7YwBvTQ8/FhsrhBV7jwuY7gqHbUc7sN8u1EVNUm
	 hGzycLMBMJ8dj3EiVK3R8/XTzzvoNUU24WkY//zyTxl8zqNp3TCnFVWhgQ4SM3sVSIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=swE7g4pb;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD39860A4AF2
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD39860A4AF2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=swE7g4pb
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48b042c0759so1368523f8f.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792676689; x=1793281489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XYjNLtFTrAyQevnzj/0Kzgc6dPd+FZvsW6YZu/EQWok=;
        b=swE7g4pbulvykPpi16BvFi7jTgN6mR6aMzfmhtCUqv6gQpyPo0/pXjoj1meGfh0dJK
         7e5TlY+Qi3S6ulMPOH31NiTHUzH2cAHnISCj0jPtJsklJCHEF7J2iAEx2bWS7Jh36TFC
         SYa7oHpV/dagy2vfkWPd2/BrmVNmHlK18yuNGsJz6WiUVaPY7S9q+LzaGeP4fVHm6Ot3
         ivLJXTh0KdaCniv43sQFcifb708SDMxLtTr+FjKG2fe6U20j9J9ScEemIJh1/FgH7lrD
         Tcz1/RWZAamruSa6N5MtRGsRn0s4nAdxuspkIQDOHqzgfFbbDPYTwwDnUf8oQZPNXR3M
         lBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676689; x=1793281489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XYjNLtFTrAyQevnzj/0Kzgc6dPd+FZvsW6YZu/EQWok=;
        b=gbMvRlpop1mwI/abrnj2gjy7QZkTUDDr3Pm8wBxFa3n3o5U4pMglOZAR8q+RLrYCbp
         rOzUEZaAiH4CmlTerZBbJgSg+GABhf5Hio6hpDiFzje2q6sJBknll0qGjUY2oK0J9X9Q
         ytCpSUym1q6+PTaadkwKeDeVIoVxb/GPwsG0ioiGlHW6DJiYWiPbhNLpWtfi7a/7LPdn
         i9RCEm+A0lD2B5gmYm7zf8LI3Jq3iAsdCiMXry+le9xvS/QzBvUpdw/TG4SL4ru+buA+
         LXQVVUvoNWqaEUY1q+msfXrKmsmaP+26J3cw/ftUhhEs0W2VVbSl3bbvlxI91IgMzETm
         ihYw==
X-Forwarded-Encrypted: i=1; AKwUvByKfVF3EXf/xftAO4IYDA+PiW6ecITlt8sHdvhTv0XA3liiYi+t7CbRrjFH1ISZrRntKIod94U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmT6Bajj9J4aQno+HlTqUfwaHjFXQjSZPzf1X0ggRwzhMrOoG/
	0wUrX6aCVvsfZiV/Ig2rr4a/78K98HK+DLE1iSIRNLcWdTIkd0lZBpDr
X-Gm-Gg: AYBFou3MWDMFLo/o59Vwhisf2WCVI9l8uDKL0xKTVLo+acTrx4oG1gTLmTSCNUEtzUP
	QAuW+UeyEH5OmZMzlVX0cQxgX4F/RloPhvzC/S7u5/gkyRZLUHWmdCXyhERoKyBL8kJaaSWR43F
	XZEJo8CesLnlDT2MnuQjXMM0W3tq44TLBacaSjiSDN7t+jVaebe/jpsedDZUKjDTbERY2gnpRyN
	Q0yQOLDa3NfUbk2KK7MiTsWYVIhm9BN1zg0GiMo15s7Ooo7MpKWzaLGQCoxIv2LQEibLkxDPywY
	Ntj6lvccJIQlm6uzCRfTQ58GOboCOwiG0Wy/fUvgtSbbh/AhH1UyhMKx1byej+iGaXhipDC2M4e
	JLQ82dPoTqqeiIeGF+CsxszUycMIPHqQvT4Wi7tx2iGewGFkuRzFdib2tu/uyL8WlzPPlN1IT5W
	NijXB01v78bzrfIGXC528f3zj5aoZWbcQpyMwukuv81Klx9dccoJctp8guv49B8Ii9nLnUabJ5I
	5zcm+yKcM+6tnFMpc0VGVxhOhrXftQP3kt7g7pETZb1anazzQYWl7IlqY/SWAhmmRTp0uaEhFGc
	jNgT5YJkpmUXjWo+NfOCp7hv
X-Received: by 2002:a05:600c:1d1e:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4a20677bb15mr45085445e9.34.1792676688722;
        Thu, 22 Oct 2026 06:44:48 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a205c945e9sm62885515e9.1.2026.10.22.06.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:44:48 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Song Liu <song@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] livepatch: Fix races between stack check and module load/unload
Date: Thu, 22 Oct 2026 15:44:31 +0200
Message-ID: <20261022134433.3595212-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Unloading a patched module while a livepatch transition is in progress
can crash the kernel in klp_find_ops(), called from the scheduler.

The scheduler checks the stack of a task that still has to switch
without klp_mutex: __klp_sched_try_switch() -> klp_try_switch_task() ->
klp_check_stack().  The check walks the global klp_ops list and each
func_stack, and reads obj->patched.

Loading or unloading a patched module changes these lists in
klp_patch_func() and klp_unpatch_func() under klp_mutex only, and
unloading frees the ops, so the walk can follow a freed entry.

Protect the lists and obj->patched with a raw spinlock, klp_ops_lock.
Writers take it only around the list updates, as the ftrace calls in
klp_patch_func() and klp_unpatch_func() can sleep, and free the ops
after dropping it.  klp_check_stack() only trylocks it, and checks the
task again later if that fails.

__klp_unpatch_object() now clears obj->patched before it unpatches the
functions, so that the stack check skips an object whose functions are
being removed.

The race was found with the help of an LLM.

Fixes: e3ff7c609f39 ("livepatch,sched: Add livepatch task switching to cond_resched()")
Cc: stable@vger.kernel.org
Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
Changes in v2:
- Protect the klp_ops list, the func_stacks and obj->patched with a raw
  spinlock that klp_check_stack() only trylocks, instead of RCU and
  memory barriers (Petr)
- Check the locking with lockdep instead of describing it in comments
  (Peter)
- Rewrite the changelog without the traces (Miroslav)
- Drop the obj->patched barriers for module reload instead of splitting
  them out (Miroslav): obj->patched is now set under klp_ops_lock
- Note the LLM in the changelog instead of an Assisted-by tag, which
  was dropped upstream

v1: https://lore.kernel.org/r/20261012140546.154730-1-parri.andrea@gmail.com
Reproducer: https://lore.kernel.org/r/20261014133553.102324-1-parri.andrea@gmail.com

Tested on x86_64 in 4-CPU vng guests with five configs: KCSAN_STRICT;
KCSAN_STRICT with PROVE_LOCKING, PROVE_RAW_LOCK_NESTING,
DEBUG_ATOMIC_SLEEP and PROVE_RCU_LIST; KASAN with the same lock
debugging plus DEBUG_LIST, SLUB_DEBUG_ON and DEBUG_OBJECTS; and the
last two with PREEMPT_RT.

On each, the livepatch selftests were run, then the reproducer kept a
transition in progress while a patched module was unloaded and reloaded
for 30 minutes (229 to 358 reloads).  Without this patch, the
reproducer faults in klp_find_ops().

No KCSAN report involves livepatch code, and lockdep, RCU, KASAN and
the list and object debugging stay silent.

Two selftests fail, unrelated to this patch: test-syscall.sh catches a
KCSAN_STRICT report in osq_lock() from the test module's mutex, and on
PREEMPT_RT test-callbacks.sh catches a WARNING in klp_check_stack(),
from lockdep_assert_preemption_disabled(), also seen on v7.3-rc7.
---
 kernel/livepatch/patch.c      | 37 ++++++++++++++++++++++++++++++-----
 kernel/livepatch/patch.h      |  2 ++
 kernel/livepatch/transition.c | 31 ++++++++++++++++++++---------
 3 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 3f54a017bbf69..d75fc9a14488b 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -22,11 +22,21 @@
 
 static LIST_HEAD(klp_ops);
 
+/*
+ * klp_check_stack() walks klp_ops and the func_stacks from the scheduler,
+ * without klp_mutex, while a patched module can be loaded or unloaded.
+ * Changes to these lists and to obj->patched are made under this lock too.
+ */
+DEFINE_RAW_SPINLOCK(klp_ops_lock);
+
 struct klp_ops *klp_find_ops(void *old_func)
 {
 	struct klp_ops *ops;
 	struct klp_func *func;
 
+	lockdep_assert(lockdep_is_held(&klp_mutex) ||
+		       lockdep_is_held(&klp_ops_lock));
+
 	list_for_each_entry(ops, &klp_ops, node) {
 		func = list_first_entry(&ops->func_stack, struct klp_func,
 					stack_node);
@@ -147,11 +157,15 @@ static void klp_unpatch_func(struct klp_func *func)
 		WARN_ON(unregister_ftrace_function(&ops->fops));
 		WARN_ON(ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0));
 
+		raw_spin_lock(&klp_ops_lock);
 		list_del_rcu(&func->stack_node);
 		list_del(&ops->node);
+		raw_spin_unlock(&klp_ops_lock);
 		kfree(ops);
 	} else {
+		raw_spin_lock(&klp_ops_lock);
 		list_del_rcu(&func->stack_node);
+		raw_spin_unlock(&klp_ops_lock);
 	}
 
 	func->patched = false;
@@ -191,11 +205,13 @@ static int klp_patch_func(struct klp_func *func)
 				  FTRACE_OPS_FL_IPMODIFY |
 				  FTRACE_OPS_FL_PERMANENT;
 
-		list_add(&ops->node, &klp_ops);
-
 		INIT_LIST_HEAD(&ops->func_stack);
 		list_add_rcu(&func->stack_node, &ops->func_stack);
 
+		raw_spin_lock(&klp_ops_lock);
+		list_add(&ops->node, &klp_ops);
+		raw_spin_unlock(&klp_ops_lock);
+
 		ret = ftrace_set_filter_ip(&ops->fops, ftrace_loc, 0, 0);
 		if (ret) {
 			pr_err("failed to set ftrace filter for function '%s' (%d)\n",
@@ -213,7 +229,9 @@ static int klp_patch_func(struct klp_func *func)
 
 
 	} else {
+		raw_spin_lock(&klp_ops_lock);
 		list_add_rcu(&func->stack_node, &ops->func_stack);
+		raw_spin_unlock(&klp_ops_lock);
 	}
 
 	func->patched = true;
@@ -221,8 +239,10 @@ static int klp_patch_func(struct klp_func *func)
 	return 0;
 
 err:
+	raw_spin_lock(&klp_ops_lock);
 	list_del_rcu(&func->stack_node);
 	list_del(&ops->node);
+	raw_spin_unlock(&klp_ops_lock);
 	kfree(ops);
 	return ret;
 }
@@ -231,6 +251,13 @@ static void __klp_unpatch_object(struct klp_object *obj, bool nops_only)
 {
 	struct klp_func *func;
 
+	/* Make klp_check_stack() skip the object before its funcs go away. */
+	if (obj->dynamic || !nops_only) {
+		raw_spin_lock(&klp_ops_lock);
+		obj->patched = false;
+		raw_spin_unlock(&klp_ops_lock);
+	}
+
 	klp_for_each_func(obj, func) {
 		if (nops_only && !func->nop)
 			continue;
@@ -238,9 +265,6 @@ static void __klp_unpatch_object(struct klp_object *obj, bool nops_only)
 		if (func->patched)
 			klp_unpatch_func(func);
 	}
-
-	if (obj->dynamic || !nops_only)
-		obj->patched = false;
 }
 
 
@@ -264,7 +288,10 @@ int klp_patch_object(struct klp_object *obj)
 			return ret;
 		}
 	}
+
+	raw_spin_lock(&klp_ops_lock);
 	obj->patched = true;
+	raw_spin_unlock(&klp_ops_lock);
 
 	return 0;
 }
diff --git a/kernel/livepatch/patch.h b/kernel/livepatch/patch.h
index d5f2fbe373e05..6441373f1c2f2 100644
--- a/kernel/livepatch/patch.h
+++ b/kernel/livepatch/patch.h
@@ -25,6 +25,8 @@ struct klp_ops {
 	struct ftrace_ops fops;
 };
 
+extern raw_spinlock_t klp_ops_lock;
+
 struct klp_ops *klp_find_ops(void *old_func);
 
 int klp_patch_object(struct klp_object *obj);
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 2351a19ac2a9e..7b5cc14037e59 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -204,11 +204,14 @@ void klp_update_patch_state(struct task_struct *task)
  */
 static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
 				unsigned int nr_entries)
+	__must_hold(&klp_ops_lock)
 {
 	unsigned long func_addr, func_size, address;
 	struct klp_ops *ops;
 	int i;
 
+	lockdep_assert_held(&klp_ops_lock);
+
 	if (klp_target_state == KLP_TRANSITION_UNPATCHED) {
 		 /*
 		  * Check for the to-be-unpatched function
@@ -266,14 +269,20 @@ static int klp_check_stack(struct task_struct *task, const char **oldname)
 		return -EINVAL;
 	nr_entries = ret;
 
-	klp_for_each_object(klp_transition_patch, obj) {
-		if (!obj->patched)
-			continue;
-		klp_for_each_func(obj, func) {
-			ret = klp_check_stack_func(func, entries, nr_entries);
-			if (ret) {
-				*oldname = func->old_name;
-				return -EADDRINUSE;
+	/*
+	 * The lock is taken by module load/unload and by stack checks on other
+	 * CPUs.  Do not spin on it from the scheduler, retry the task later.
+	 */
+	scoped_cond_guard(raw_spinlock_try, return -EAGAIN, &klp_ops_lock) {
+		klp_for_each_object(klp_transition_patch, obj) {
+			if (!obj->patched)
+				continue;
+			klp_for_each_func(obj, func) {
+				ret = klp_check_stack_func(func, entries, nr_entries);
+				if (ret) {
+					*oldname = func->old_name;
+					return -EADDRINUSE;
+				}
 			}
 		}
 	}
@@ -300,7 +309,7 @@ static int klp_check_and_switch_task(struct task_struct *task, void *arg)
 /*
  * Try to safely switch a task to the target patch state.  If it's currently
  * running, or it's sleeping on a to-be-patched or to-be-unpatched function, or
- * if the stack is unreliable, return false.
+ * if the stack is unreliable, or if klp_ops_lock is busy, return false.
  */
 static bool klp_try_switch_task(struct task_struct *task)
 {
@@ -344,6 +353,10 @@ static bool klp_try_switch_task(struct task_struct *task)
 		pr_debug("%s: %s:%d is sleeping on function %s\n",
 			 __func__, task->comm, task->pid, old_name);
 		break;
+	case -EAGAIN:	/* klp_check_and_switch_task() */
+		pr_debug("%s: %s:%d could not be checked, klp_ops_lock is busy\n",
+			 __func__, task->comm, task->pid);
+		break;
 
 	default:
 		pr_debug("%s: Unknown error code (%d) when trying to switch %s:%d\n",

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.53.0

