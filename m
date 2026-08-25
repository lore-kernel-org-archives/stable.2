Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B43FF8B0
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662132; cv=none; b=pbwlnV8i1tx4cVVRIbpvF611WZ0YnZq0ygBEbEeDAYz0FJBuUofRjj5UHEVwWiFUUqclo1oCgZUzNkkcQNdrw8YkVjc4RENzlimEI20q/6KpUdv2LMPPp2DiWrnQtlK6ERy1fTjk3i85h2htjqZmA3qbUy7U4D2C3oNAC0wVLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662132; c=relaxed/simple;
	bh=JBukCL+qPCiKz2ldcRghqNXMnIUN3MXUZ0ikJucpZvA=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QWmj9kU31TbRipkKSJg6Q/N16Wqaeq6GeJIS2r64Q+Lwrfxp89ALxp3oROW5+Pkidm8ngQEMIpXb8m4wm+4w6prehrlNYu6Jb+CUHsn09t+6+GF/ZGEH/Y38KpNniYXrfS1lOwPUE9W51TzzHXMMiZZpDXE9kEzEIv51jJi4HZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkfCfH8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkfCfH8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7251F000E9;
	Tue, 25 Aug 2026 12:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787662131;
	bh=ZCEk/q8vSMnS/YB4Y7lwsjDrSc7vm0PmbGipYdbdNbY=;
	h=Date:From:To:Cc:Subject:References;
	b=ZkfCfH8d3VAcGEXCzxR42vrD+zBXjErDWSt1JBXHgMrX7mO3NTGNxp29kcOeCXDt7
	 XWAFzJs/W8C7YI+WFWPCLIjHz//tfQVgwysyb6YVusV0Wdt4ygIkqn1sI1Ow0sgxqs
	 zKp1en6+aRehTgyGqJQ9fEWtdDwHvMFCmrRVGftV71wls8d+YT+/sgikbbz8kmXGvS
	 cZCZrva2/FJrenSyuh0WqyawCzNf6tsV+9wQtHwvTZ7/hUd/RKSiNUKES4DISDEQ92
	 LQuvpBtYnbgvFsliKfQZ6ipFzyYviOqsnYmQ4Ap1/m9gtuygjD3s5/azro4hNG9E0o
	 dRZSWsqHU6nLQ==
Date: Tue, 25 Aug 2026 14:48:48 +0200
Message-ID: <20260825091708.702202648@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
 peterz@infradead.org,
 syzbot+350a93852ac854927f45@syzkaller.appspotmail.com
Subject: [patch 7.1.y 6/6] futex: Fix might_sleep() warning in
 futex_pivot_pending()
References: <2026082446-lumpish-subdivide-9766@gregkh>
 <20260825091624.748852250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Peter Zijlstra <peterz@infradead.org>

commit d8aa5dd97944a72d4a9e3cc79bb80fcac7d6e829 upstream.

A younger me put a WARN in might_sleep() to warn about nested sleep loops. This
younger me also build a wait-loop variant that can deal with it. This wait-loop
variant doesn't have all the fancy wrappers, since it isn't used much. It also
lacks wait-bit support.

Add the wait-bit support and use it to fix the nested wait issue.

Fixes: 8e7ff730dd96 ("futex: Fix race in futex_pivot_pending() during private hash resize")
Reported-by: syzbot+350a93852ac854927f45@syzkaller.appspotmail.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260820074927.GH1246887@noisy.programming.kicks-ass.net
Closes: https://syzkaller.appspot.com/bug?extid=350a93852ac854927f45
---
 include/linux/wait.h     |    1 +
 include/linux/wait_bit.h |    1 +
 kernel/futex/core.c      |   27 ++++++++++++++++++++++++++-
 kernel/sched/wait.c      |   15 +++++++++++++++
 kernel/sched/wait_bit.c  |   14 +++++++++++---
 5 files changed, 54 insertions(+), 4 deletions(-)
---
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1228,6 +1228,7 @@ long prepare_to_wait_event(struct wait_q
 void finish_wait(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry);
 long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout);
 int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key);
+int woken_wake_bit_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key);
 int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key);
 
 #define DEFINE_WAIT_FUNC(name, function)					\
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -32,6 +32,7 @@ int out_of_line_wait_on_bit_timeout(unsi
 int out_of_line_wait_on_bit_lock(unsigned long *word, int, wait_bit_action_f *action, unsigned int mode);
 struct wait_queue_head *bit_waitqueue(unsigned long *word, int bit);
 extern void __init wait_bit_init(void);
+extern struct wait_bit_key *__var_wake_key(struct wait_queue_entry *wq_entry, void *arg);
 
 int wake_bit_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key);
 
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -44,6 +44,7 @@
 #include <linux/prctl.h>
 #include <linux/mempolicy.h>
 #include <linux/mmap_lock.h>
+#include <linux/wait_bit.h>
 
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
@@ -1869,11 +1870,35 @@ static int futex_hash_allocate(unsigned
 		futex_hash_bucket_init(&fph->queues[i], fph);
 
 	if (custom) {
+		struct wait_bit_queue_entry __wbq_entry;
+		struct wait_queue_head *__wq_head;
+
 		/*
 		 * Only let prctl() wait / retry; don't unduly delay clone().
 		 */
 again:
-		wait_var_event(mm, futex_pivot_pending(mm));
+		__wq_head = __var_waitqueue(mm);
+		init_wait_var_entry(&__wbq_entry, mm, 0);
+		__wbq_entry.wq_entry.func = woken_wake_bit_function;
+		add_wait_queue(__wq_head, &__wbq_entry.wq_entry);
+
+		/*
+		 * add_wait_queue()		futex_ref_put()
+		 * MB (this)			MB (implied)
+		 * futex_pivot_pending()	wake_up_var()
+		 *                                waitqueue_active()
+		 *
+		 * Notably, it must not be possible to see
+		 * !futex_pivot_pending() && !waitqueue_active().
+		 */
+		smp_mb();
+
+		while (!futex_pivot_pending(mm) &&
+		       wait_woken(&__wbq_entry.wq_entry, TASK_UNINTERRUPTIBLE,
+				  MAX_SCHEDULE_TIMEOUT))
+			/* empty */;
+
+		remove_wait_queue(__wq_head, &__wbq_entry.wq_entry);
 	}
 
 	scoped_guard(mutex, &mm->futex_hash_lock) {
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -5,6 +5,7 @@
  * (C) 2004 Nadia Yvette Chambers, Oracle
  */
 #include "sched.h"
+#include <linux/wait_bit.h>
 
 void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *name, struct lock_class_key *key)
 {
@@ -463,3 +464,17 @@ int woken_wake_function(struct wait_queu
 	return default_wake_function(wq_entry, mode, sync, key);
 }
 EXPORT_SYMBOL(woken_wake_function);
+
+int woken_wake_bit_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *arg)
+{
+	struct wait_bit_key *key = __var_wake_key(wq_entry, arg);
+	if (!key)
+		return 0;
+
+	/* Pairs with the smp_store_mb() in wait_woken(). */
+	smp_mb(); /* C */
+	wq_entry->flags |= WQ_FLAG_WOKEN;
+
+	return default_wake_function(wq_entry, mode, sync, key);
+}
+EXPORT_SYMBOL(woken_wake_bit_function);
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -167,9 +167,7 @@ wait_queue_head_t *__var_waitqueue(void
 }
 EXPORT_SYMBOL(__var_waitqueue);
 
-static int
-var_wake_function(struct wait_queue_entry *wq_entry, unsigned int mode,
-		  int sync, void *arg)
+struct wait_bit_key *__var_wake_key(struct wait_queue_entry *wq_entry, void *arg)
 {
 	struct wait_bit_key *key = arg;
 	struct wait_bit_queue_entry *wbq_entry =
@@ -177,6 +175,16 @@ var_wake_function(struct wait_queue_entr
 
 	if (wbq_entry->key.flags != key->flags ||
 	    wbq_entry->key.bit_nr != key->bit_nr)
+		return NULL;
+
+	return key;
+}
+
+static int var_wake_function(struct wait_queue_entry *wq_entry, unsigned int mode,
+			     int sync, void *arg)
+{
+	struct wait_bit_key *key = __var_wake_key(wq_entry, arg);
+	if (!key)
 		return 0;
 
 	return autoremove_wake_function(wq_entry, mode, sync, key);

